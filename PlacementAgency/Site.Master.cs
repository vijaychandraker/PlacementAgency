using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        }
    }
}