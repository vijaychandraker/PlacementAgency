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
            if (!IsPostBack)
            {
                BindApproveStstus();
            }
            String UserID  = Session["UserID"] != null ? Session["UserID"].ToString() : string.Empty;
            String RoleID  = Session["RoleID"] != null ? Session["RoleID"].ToString() : string.Empty;
            String Username =  Session["Username"] != null ? Session["Username"].ToString() : string.Empty;
            String DistrictID =  Session["DistrictID"] != null ? Session["DistrictID"].ToString() : string.Empty;
            String DistrictName =  Session["DistrictName"] != null ? Session["DistrictName"].ToString() : string.Empty;
            String Zone_ID =  Session["Zone_ID"] != null ? Session["Zone_ID"].ToString() : string.Empty;
            String Zone_Name =  Session["Zone_Name"] != null ? Session["Zone_Name"].ToString() : string.Empty;
            String Agency_ID =  Session["Agency_ID"] != null ? Session["Agency_ID"].ToString() : string.Empty;
            String Agency_Name =  Session["Agency_Name"] != null ? Session["Agency_Name"].ToString() : string.Empty;


            DateTime currentDate = DateTime.Now;
            DateTime previousMonthDate = currentDate.AddMonths(-1);

            int prevMonth = previousMonthDate.Month;
            int prevYear = previousMonthDate.Year;

            string prevMonthName = previousMonthDate.ToString("MMMM"); // January, February...
            lblmonth.Text = prevMonthName;

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
