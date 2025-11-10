using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Dist
{
    public partial class csmclDistApproveStatus : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                BindFY();
            }
        }
        public void BindGrid()
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@District_ID", 101),
                 new SqlParameter("@Month", ddlmonthDApprove.SelectedValue),
                new SqlParameter("@FY", ddlFYDapprove.SelectedValue),
           };
            DataTable dtgrd = db.ExecuteQuery("csmcl_sp_GetDutyEntryApproveStatus", param);
            if (dtgrd.Rows.Count > 0)
            {
                lblmsgcheck.Visible = false;
                gveDuty.DataSource = dtgrd;
                gveDuty.DataBind();
            }
            else
            {
                lblmsgcheck.Visible = true;
                lblmsgcheck.Text = "No data Found";
                maincontApprove.Visible = false;
            }
        }



        public void BindFY()
        {
            ddlFYDapprove.Items.Clear();
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1;
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYDapprove.Items.Add(new ListItem(fy, fy));
            }
            ddlFYDapprove.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            //  string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFYDapprove.SelectedValue = currentFY;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddlFYDapprove.SelectedIndex > 0 && ddlmonthDApprove.SelectedIndex > 0)
            {
                
                maincontApprove.Visible = true;
                BindGrid();
            }
            else
            {
                lblmsgcheck.Visible = true;
                lblmsgcheck.Text = "select Dropdown";
            }
        }
        public void BindMonthByFY(string selectedFY)
        {
            ddlmonthDApprove.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlmonthDApprove.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }
            // Extract years from FY like "2025-26"
            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            // April–December of startYear
            for (int m = 4; m <= 12; m++)
            {
                string monthName = new DateTime(startYear, m, 1).ToString("MMMM");
                ddlmonthDApprove.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            // January–March of nextYear
            for (int m = 1; m <= 3; m++)
            {
                string monthName = new DateTime(endYear, m, 1).ToString("MMMM");
                ddlmonthDApprove.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            ddlmonthDApprove.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }

        protected void ddlFYDapprove_SelectedIndexChanged1(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFYDapprove.SelectedValue);
        }

        protected void gveDuty_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDis = (Label)e.Row.FindControl("lblDis");
                Label lblAgency = (Label)e.Row.FindControl("lblAgency");
                Label lblState = (Label)e.Row.FindControl("lblState");

                SetStatus(lblDis);
                SetStatus(lblAgency);
                SetStatus(lblState);
            }
        }

        private void SetStatus(Label lbl)
        {
            if (lbl != null)
            {
                string val = lbl.Text.Trim();

                switch (val)
                {
                    case "0":
                        lbl.Text = "Pending";
                        lbl.CssClass = "badge bg-warning text-dark";
                        break;
                    case "1":
                        lbl.Text = "Approved";
                        lbl.CssClass = "badge bg-success";
                        break;
                    default:
                        lbl.Text = "Rejected";
                        lbl.CssClass = "badge bg-danger";
                        break;
                }

                lbl.Font.Bold = true;
            }
        }

    }
}