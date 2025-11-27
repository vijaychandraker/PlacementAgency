using PlacementAgency.UI.Dashboard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace PlacementAgency
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                lblusername.Text = Session["Username"] != null ? Session["Username"].ToString() : string.Empty;
                lbluserrole.Text = Session["RoleID"] != null ? Session["RoleID"].ToString() : string.Empty;
                lbldistrict.Text = Session["DistrictName"] != null ? Session["DistrictName"].ToString() : string.Empty;
            }
            if (Session["RoleID"] != null)
            {
                string roleId = Session["RoleID"] != null ? Session["RoleID"].ToString() : string.Empty;

                switch (roleId)
                {
                    //case "1": // Admin
                    //    lnkDashboard.Visible = true;
                    //    lnkShowData.Visible = true;
                    //    lnkReport.Visible = true;
                    //    break;

                    case "2": // DistrictUser
                        lidistapprovepayroll.Visible = false;
                        liagencyapprove.Visible = false;
                        lidashboard.Visible = true;
                        lipayrolentry.Visible = true;


                        break;
                    case "3": // DistrictAdmin
                        lidistapprovepayroll.Visible = true;
                        lidashboard.Visible = true;
                        lipayrolentry.Visible = false;
                        liapproveststus.Visible = false;
                        lireport.Visible = false;
                        liagencyapprove.Visible=false;
                        break;
                    case "4": // Agency
                        liagencyapprove.Visible=true;
                        lidashboard.Visible = true;
                        lipayrolentry.Visible = false;
                        lidistapprovepayroll.Visible = false;
                        lireport.Visible = false;
                        liapproveststus.Visible = false;
                        break;
                        //case "5": // StateAdmin
                        //    lnkDashboard.Visible = true;
                        //    lnkUser.Visible = true;
                        //    lnkReport.Visible = true;
                        //    break;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            FormsAuthentication.SignOut();

            Response.Redirect("~/Login/Login.aspx");
        }
    }
}