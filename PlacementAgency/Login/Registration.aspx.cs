using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.Login
{
    public partial class Registration : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRoles();
            }

        }
        private void LoadRoles()
        {
            DataTable dt = db.ExecuteQuery("csmcl_sp_GetActiveRoles", null);
            ddlRole.DataSource = dt;
            ddlRole.DataTextField = "RoleName";
            ddlRole.DataValueField = "RoleID";
            ddlRole.DataBind();
            ddlRole.Items.Insert(0, new ListItem("-- Select Role --", ""));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
            string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMsg.Text = "Username and Password are required.";
                return;
            }
               string password = txtPassword.Text.Trim();
            // Hash password + salt
            byte[] salt = PasswordHelper.GenerateSalt();
            byte[] hash = PasswordHelper.HashPassword(password, salt);

            SqlParameter[] param = new SqlParameter[]
            {
            new SqlParameter("@Username", txtUsername.Text.Trim()),
            new SqlParameter("@PasswordHash", hash),
            new SqlParameter("@PasswordSalt", salt),
            new SqlParameter("@FullName", txtFullName.Text.Trim()),
            new SqlParameter("@Mobile", txtMobile.Text.Trim()),
            new SqlParameter("@Email", txtEmail.Text.Trim()),
            new SqlParameter("@RoleID", ddlRole.SelectedValue),
            new SqlParameter("@IsActive", chkActive.Checked ? 1 : 0)
            };

            int rows = db.ExecuteNonQuery("csmcl_sp_InsertUser", param);

            if (rows > 0)
            {
                lblMsg.CssClass = "text-success";
                lblMsg.Text = "User created successfully.";
            }
            else
            {
                lblMsg.CssClass = "text-danger";
                lblMsg.Text = "Error saving user.";
            }
        }
    }
}