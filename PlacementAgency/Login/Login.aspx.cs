using PlacementAgency.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.Security;

namespace PlacementAgency.Login
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                imgCaptcha.ImageUrl = ResolveUrl("~/Helpers/Captcha.ashx?t=" + DateTime.UtcNow.Ticks);
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            // ================= CAPTCHA VALIDATION =================
            string enteredCaptcha = txtCaptcha.Text.Trim();
            string sessionCaptcha = Session["CaptchaCode"] as string;

            if (string.IsNullOrEmpty(sessionCaptcha) ||
                !string.Equals(enteredCaptcha, sessionCaptcha, StringComparison.OrdinalIgnoreCase))
            {
                ShowMessage("Invalid captcha. Please try again.");
                return;
            }

            // ================= INPUT VALIDATION =================
            string usernameOrEmail = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(usernameOrEmail) || string.IsNullOrWhiteSpace(password))
            {
                ShowMessage("Username/Email and Password are required.");
                return;
            }

            // ================= FETCH USER =================
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

            DataTable dt = db.ExecuteQuery("sp_GetUserByUsernameOrEmail", parameters);

            if (dt == null || dt.Rows.Count == 0)
            {
                ShowMessage("Invalid username or password.");
                return;
            }

            DataRow row = dt.Rows[0];

            // ================= SAFE DB EXTRACTION =================
            bool isActive = row["IsActive"] != DBNull.Value && Convert.ToBoolean(row["IsActive"]);
            if (!isActive)
            {
                ShowMessage("Your account is inactive. Contact administrator.");
                return;
            }

            int userId = Convert.ToInt32(row["UserID"]);
            int roleId = Convert.ToInt32(row["RoleID"]);
            string username = row["Username"].ToString();

            int districtId = row.Table.Columns.Contains("District_ID") && row["District_ID"] != DBNull.Value
                ? Convert.ToInt32(row["District_ID"]) : 0;

            string districtName = row.Table.Columns.Contains("District_Name") && row["District_Name"] != DBNull.Value
                ? row["District_Name"].ToString() : string.Empty;

            string zoneId = row.Table.Columns.Contains("Zone_ID") && row["Zone_ID"] != DBNull.Value
                ? row["Zone_ID"].ToString() : string.Empty;

            string zoneName = row.Table.Columns.Contains("Zone_Name") && row["Zone_Name"] != DBNull.Value
                ? row["Zone_Name"].ToString() : string.Empty;

            string agencyId = row.Table.Columns.Contains("Agency_ID") && row["Agency_ID"] != DBNull.Value
                ? row["Agency_ID"].ToString() : string.Empty;

            string agencyName = row.Table.Columns.Contains("Agency_Name") && row["Agency_Name"] != DBNull.Value
                ? row["Agency_Name"].ToString() : string.Empty;

            byte[] storedHash = row["PasswordHash"] as byte[];
            byte[] storedSalt = row["PasswordSalt"] as byte[];

            if (storedHash == null || storedSalt == null)
            {
                ShowMessage("Account configuration error. Contact administrator.");
                return;
            }

            // ================= PASSWORD VERIFY =================
            bool validPassword = PasswordHelper.VerifyPassword(password, storedSalt, storedHash);

            if (!validPassword)
            {
                ShowMessage("Invalid username or password.");
                return;
            }

            // ================= UPDATE LAST LOGIN =================
            try
            {
                SqlParameter[] updateParams = {
                    new SqlParameter("@UserID", userId)
                };
                db.ExecuteNonQuery("csmcl_sp_UpdateLastLogin", updateParams);
            }
            catch
            {
                // Do not block login for logging failure
            }

            // ================= PREVENT SESSION FIXATION =================
            Session.Clear();

            Session["UserID"] = userId;
            Session["RoleID"] = roleId;
            Session["Username"] = username;
            Session["DistrictID"] = districtId;
            Session["DistrictName"] = districtName;
            Session["Zone_ID"] = zoneId;
            Session["Zone_Name"] = zoneName;
            Session["Agency_ID"] = agencyId;
            Session["Agency_Name"] = agencyName;

            // ================= CREATE AUTH COOKIE + REDIRECT =================
            FormsAuthentication.RedirectFromLoginPage(username, false);
        }

        private bool IsValidEmail(string input)
        {
            return Regex.IsMatch(input ?? string.Empty,
                @"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                RegexOptions.IgnoreCase);
        }

        private void ShowMessage(string message)
        {
            string safe = message.Replace("'", "\\'");
            ClientScript.RegisterStartupScript(this.GetType(),
                "alert",
                $"alert('{safe}');",
                true);
        }
    }
}