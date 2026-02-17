using PlacementAgency.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace PlacementAgency.Login
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // ensure captcha image is requested at first load if you set it server-side
                if (imgCaptcha != null)
                {
                    imgCaptcha.ImageUrl = ResolveUrl("~/helpers/Captcha.ashx?t=" + DateTime.UtcNow.Ticks);
                }
            }
        }
        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            // 1. Check captcha
            string enteredCaptcha = txtCaptcha.Text.Trim();
            string sessionCaptcha = Session["CaptchaCode"] as string;

            if (string.IsNullOrEmpty(sessionCaptcha) ||
                string.IsNullOrEmpty(enteredCaptcha) ||
                !string.Equals(enteredCaptcha, sessionCaptcha, StringComparison.OrdinalIgnoreCase))
            {
                ShowMessage("Invalid captcha. Please try again.");
                return;
            }

            string usernameOrEmail = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(usernameOrEmail) || string.IsNullOrWhiteSpace(password))
            {
                ShowMessage("Username/Email and Password are required.");
                return;
            }

            // 2. Prepare parameters (stored proc should accept both @Username and @Email)
            SqlParameter[] parameters;
            if (IsValidEmail(usernameOrEmail))
            {
                parameters = new SqlParameter[]
                {
                    new SqlParameter("@Email", usernameOrEmail),
                    new SqlParameter("@Username", DBNull.Value)
                };
            }
            else
            {
                parameters = new SqlParameter[]
                {
                    new SqlParameter("@Username", usernameOrEmail),
                    new SqlParameter("@Email", DBNull.Value)
                };
            }

            // Use the existing field 'db' (not a new local instance)
            DataTable dt = db.ExecuteQuery("sp_GetUserByUsernameOrEmail", parameters);

            if (dt == null || dt.Rows.Count == 0)
            {
                ShowMessage("Invalid username or password.");
                return;
            }

            DataRow row = dt.Rows[0];

            // Safe extraction of DB values (handle DBNull)
            bool isActive = false;
            if (row["IsActive"] != DBNull.Value)
                isActive = Convert.ToBoolean(row["IsActive"]);

            int userId = 0;
            if (row["UserID"] != DBNull.Value)
                userId = Convert.ToInt32(row["UserID"]);

            int role = 0;
            if (row["RoleID"] != DBNull.Value)
                role = Convert.ToInt32(row["RoleID"]);

            // usernameOrEmail is the value user typed; prefer DB username if present
            string username = usernameOrEmail;
            if (row["Username"] != DBNull.Value)
                username = row["Username"].ToString();

            // optional additional fields (district example)
            int districtId = 0;
            if (row.Table.Columns.Contains("District_ID") && row["District_ID"] != DBNull.Value)
                districtId = Convert.ToInt32(row["District_ID"]);

            string districtName = string.Empty;
            if (row.Table.Columns.Contains("District_Name") && row["District_Name"] != DBNull.Value)
                districtName = row["District_Name"].ToString();


            string Zone_ID = string.Empty;
            if (row.Table.Columns.Contains("Zone_ID") && row["Zone_ID"] != DBNull.Value)
                Zone_ID = row["Zone_ID"].ToString();

            string Zone_Name = string.Empty;
            if (row.Table.Columns.Contains("Zone_Name") && row["Zone_Name"] != DBNull.Value)
                Zone_Name = row["Zone_Name"].ToString();

            string Agency_ID = string.Empty;
            if (row.Table.Columns.Contains("Agency_ID") && row["Agency_ID"] != DBNull.Value)
                Agency_ID = row["Agency_ID"].ToString();

            string Agency_Name = string.Empty;
            if (row.Table.Columns.Contains("Agency_Name") && row["Agency_Name"] != DBNull.Value)
                Agency_Name = row["Agency_Name"].ToString();



            // Read binary salt/hash from DB (these columns must be varbinary in DB)
            byte[] storedHash = null;
            byte[] storedSalt = null;

            if (row["PasswordHash"] != DBNull.Value)
                storedHash = (byte[])row["PasswordHash"];

            if (row["PasswordSalt"] != DBNull.Value)
                storedSalt = (byte[])row["PasswordSalt"];

            if (storedHash == null || storedSalt == null)
            {
                ShowMessage("Account setup incomplete. Contact administrator.");
                return;
            }

            if (!isActive)
            {
                ShowMessage("Your account is inactive. Contact administrator.");
                return;
            }

            // 3. Verify password using secure helper (timing-safe)
            bool validPassword = PasswordHelper.VerifyPassword(password, storedSalt, storedHash);

            if (!validPassword)
            {
                ShowMessage("Invalid username or password.");
                return;
            }

            // 4. Update last login
            try
            {
                SqlParameter[] updateParams = { new SqlParameter("@UserID", userId) };
                db.ExecuteNonQuery("sp_UpdateLastLogin", updateParams);
            }
            catch
            {
                // don't fail login because of last-login update; consider logging the error
            }

            // 5. Prevent session fixation: abandon and create fresh session
            // Capture required values first, then reset session
            string userNameForSession = username;
            int roleIdForSession = role;
            int userIdForSession = userId;
            int DistrictIDForSession = districtId;
            string DistrictNameForSession = districtName;
            string Zone_IDForSession = districtName;
            string Zone_NameForSession = districtName;
            string Agency_IDForSession = districtName;
            string Agency_NameForSession = districtName;

            // Abandon current session and start a new one
            Session.Clear();
       //     Session.Abandon();

            // NOTE: ASP.NET may keep the same cookie until redirect; to be thorough, issue a new session cookie
            // but simplest approach: after Abandon redirect to same app page to issue new session id.
            // We'll set session variables now (ASP.NET will create a new session on access).
            Session["UserID"] = userIdForSession;
            Session["RoleID"] = roleIdForSession;
            Session["Username"] = userNameForSession;
            Session["DistrictID"] = DistrictIDForSession;
            Session["DistrictName"] = DistrictNameForSession;
            Session["Zone_ID"] = Zone_IDForSession;
            Session["Zone_Name"] = Zone_NameForSession;
            Session["Agency_ID"] = Agency_IDForSession;
            Session["Agency_Name"] = Agency_NameForSession;

            // 6. Redirect based on role or to a default dashboard
            Response.Redirect("~/UI/Dashboard/Dashboard.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
        private bool IsValidEmail(string input)
        {
            return Regex.IsMatch(input ?? string.Empty, @"^[^@\s]+@[^@\s]+\.[^@\s]+$", RegexOptions.IgnoreCase);
        }
        private void ShowMessage(string message)
        {
            // Use a safe client script that escapes single quotes
            string safe = message.Replace("'", "\\'");
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{safe}');", true);
        }
    }
}
