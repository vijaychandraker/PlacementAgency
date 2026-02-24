using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Dashboard
{
    
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["RoleID"] == null)
            //{
            //    Response.Redirect("~/Login/Login.aspx");
            //    return;
            //}   
            //else
            //{
                if (!IsPostBack)
                {
                    DateTime previousMonth = DateTime.Now.AddMonths(-1);
                    lblmonth.Text = previousMonth.ToString("MMMM yyyy");
                    BindApproveStstus();
                }
            //}
        }

        public void BindApproveStstus()
        {
            DataTable dt = db.ExecuteQuery("csmcl_GetDistrictApprovalStatus", null);
            GV_approveStatus.DataSource = dt;
            GV_approveStatus.DataBind();
        }

        protected void GV_approveStatus_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GV_approveStatus.PageIndex = e.NewPageIndex;
            BindApproveStstus();
        }
    }
}
