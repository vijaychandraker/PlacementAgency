using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Agency
{
    public partial class csmcl_AgencyApprovel : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                BindDistrict();
                BindFY();

            }
        }

    public void BindGrid()
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@District_ID", ddldistrictAgent.SelectedValue),
                 new SqlParameter("@Month", ddlmonthDApproveAgent.SelectedValue),
                new SqlParameter("@FY", ddlFYDapproveAgent.SelectedValue),
                new SqlParameter("@ApproveByDishead", "0"),
           };
            DataTable dtgrd = db.ExecuteQuery("csmcl_sp_GetDutyEntryDetails", param);
            if (dtgrd.Rows.Count > 0)
            {
                //lblmsg.Visible = false;
                gveDutyAgent.DataSource = dtgrd;
                gveDutyAgent.DataBind();
            }
            else
            {
               // lblmsg.Visible = true;
              //  lblmsg.Text = "No data Found";
              //  maincontApprove.Visible = false;
            }
        }
        public void BindDistrict()
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Agency_ID", "AG1")
              
           };
           
                DataTable dtct = db.ExecuteQuery("csmcl_sp_GetDistrictByAgency", param);
            ddldistrictAgent.DataSource = dtct;
            ddldistrictAgent.DataTextField = "District_Name";
            ddldistrictAgent.DataValueField = "District_ID";
            ddldistrictAgent.DataBind();

            ddldistrictAgent.Items.Insert(0, new ListItem("-- Select District --", ""));


        }

        public void BindFY()
        {
            ddlFYDapproveAgent.Items.Clear();
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1;
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYDapproveAgent.Items.Add(new ListItem(fy, fy));
            }
            ddlFYDapproveAgent.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            ddlmonthDApproveAgent.Items.Insert(0, new ListItem("-- Select Month --", ""));
            //  string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFYDapprove.SelectedValue = currentFY;
        }

        public void BindMonthByFY(string selectedFY)
        {
            ddlmonthDApproveAgent.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlmonthDApproveAgent.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }
            // Extract years from FY like "2025-26"
            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            // April–December of startYear
            for (int m = 4; m <= 12; m++)
            {
                string monthName = new DateTime(startYear, m, 1).ToString("MMMM");
                ddlmonthDApproveAgent.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            // January–March of nextYear
            for (int m = 1; m <= 3; m++)
            {
                string monthName = new DateTime(endYear, m, 1).ToString("MMMM");
                ddlmonthDApproveAgent.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            
        }

        protected void ddlFYDapprove_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFYDapproveAgent.SelectedValue);
        }

        protected void btnSearchAgent_Click(object sender, EventArgs e)
        {
            if (ddlFYDapproveAgent.SelectedIndex > 0 && ddlmonthDApproveAgent.SelectedIndex > 0)
            {
              //  lblmsg.Visible = false;
              //  maincontApprove.Visible = true;
                BindGrid();
            }
            else
            {
              //  lblmsg.Visible = true;
              //  lblmsg.Text = "select Dropdown";
            }
        }
    }
}