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
    public partial class csmcl_EntryReport : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bindmonth();
                BindFY();

            }
        }
        public void Bindmonth()
        {
            DataTable dtval = db.ExecuteQuery("csmcl_sp_GetAllMonths", null);
            ddlmonthreport.DataSource = dtval;
            ddlmonthreport.DataTextField = "MonthName";
            ddlmonthreport.DataValueField = "MonthID";
            ddlmonthreport.DataBind();
            ddlmonthreport.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }
        public void BindFY()
        {
            ddlFYreport.Items.Clear();
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1; 
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYreport.Items.Add(new ListItem(fy, fy));
            }
            ddlFYreport.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            ddlFYreport.SelectedValue = currentFY;
        }
        private void LoadReportData()
        {
            SqlParameter[] param = new SqlParameter[]
            {
        new SqlParameter("@District_ID", 101),   // replace with session or logged-in district
        new SqlParameter("@FY", ddlFYreport.SelectedValue),
        new SqlParameter("@Month", ddlmonthreport.SelectedValue),
        new SqlParameter("@ApproveByDishead", "0")
            };

            DataTable dt = db.ExecuteQuery("csmcl_GetDutyEntries", param);

            if (dt.Rows.Count > 0)
            {
                lblmsg.Visible = false;
                maincont.Visible = true;
                object note = dt.Rows[0]["RejectByDishead_Note"];
                if (note != DBNull.Value && !string.IsNullOrEmpty(note.ToString()))
                {
                    lblrejectMSG.Visible = true;
                    lblrejectMSG.Text = "Reject Note: " + note.ToString();
                }
                else
                {
                    lblrejectMSG.Visible = false;
                }
                foreach (DataRow dr in dt.Rows)
                {
                    string category = dr["CategoryName"].ToString();
                    string location = dr["LocationName"].ToString();
                    string rtype = dr["RateTypeName"].ToString();
                    string duties = dr["NoOfDuties"].ToString();

                    if (category == "CHIEF SALESMAN" && location == "Office" && rtype == "Month")
                        txtMCLOffic.Text = duties;
                    else if (category == "CHIEF SALESMAN" && location == "Shop" && rtype == "Month")
                        txtMCLShop.Text = duties;
                    else if (category == "SALESMAN" && location == "Office" && rtype == "Month")
                        txtMSoffice.Text = duties;
                    else if (category == "SALESMAN" && location == "Shop" && rtype == "Month")
                        txtMSShop.Text = duties;
                    else if (category == "MULTIPURPOSE" && location == "Office" && rtype == "Month")
                        txtMMOffice.Text = duties;
                    else if (category == "MULTIPURPOSE" && location == "Shop" && rtype == "Month")
                        txtMMShop.Text = duties;
                    else if (category == "CHIEF SALESMAN" && location == "Shop" && rtype == "OT")
                        txtOTCLShop.Text = duties;
                    else if (category == "SALESMAN" && location == "Shop" && rtype == "OT")
                        txtOTSShop.Text = duties;
                    else if (category == "MULTIPURPOSE" && location == "Shop" && rtype == "OT")
                        txtOTMShop.Text = duties;
                    else if (category == "CHIEF SALESMAN" && location == "Office" && rtype == "Day")
                        txtDCSOffice.Text = duties;
                    else if (category == "CHIEF SALESMAN" && location == "Shop" && rtype == "Day")
                        txtDCSShop.Text = duties;
                    else if (category == "SALESMAN" && location == "Office" && rtype == "Day")
                        txtDSOffice.Text = duties;
                    else if (category == "SALESMAN" && location == "Shop" && rtype == "Day")
                        txtDSShop.Text = duties;
                    else if (category == "MULTIPURPOSE" && location == "Office" && rtype == "Day")
                        txtDMOffice.Text = duties;
                    else if (category == "MULTIPURPOSE" && location == "Shop" && rtype == "Day")
                        txtDMShop.Text = duties;
                }
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "No data found";
                maincont.Visible = false;
                lblrejectMSG.Visible = false;
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddlFYreport.SelectedIndex > 0 && ddlmonthreport.SelectedIndex > 0)
            {
                lblmsg.Visible = false;
                maincont.Visible = true;
                lblrejectMSG.Visible = true;
                LoadReportData();
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "select Dropdown";
            }
           
        }
    }
}