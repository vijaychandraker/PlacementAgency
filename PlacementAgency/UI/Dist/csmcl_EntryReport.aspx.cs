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
        string a = "4";
        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (!IsPostBack)
            {
                Bindmonth();
                BindFY();
               // BindDistrict();

            }
        }

        //public void BindDistrict()
        //{
           
        //    DataTable dtct = db.ExecuteQuery("csmcl_sp_Getalldistrict", null);
        //    ddldistrictstate.DataSource = dtct;
        //    ddldistrictstate.DataTextField = "District_Name";
        //    ddldistrictstate.DataValueField = "District_ID";
        //    ddldistrictstate.DataBind();

        //    ddldistrictstate.Items.Insert(0, new ListItem("-- Select District --", ""));


        //}
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
        new SqlParameter("@ApproveByDishead", "4")
            };

            DataTable dt = db.ExecuteQuery("csmcl_GetDutyEntries", param);

            if (dt.Rows.Count > 0)
            {
                if(a == "4")
                {
                    Enabletxt();
                    btnupdate.Visible= true;
                    //btncancel.Visible= true;
                }
                else
                {
                    desabletxt();
                }
                    
                lblmsg.Visible = false;
                maincont.Visible = true;
                object note = dt.Rows[0]["RejectByDishead_Note"];
                if (note != DBNull.Value && !string.IsNullOrEmpty(note.ToString()))
                {
                    lblrejectMSG.Visible = true;
                    lblrejectMSG.Text = "Rejected By District: " + note.ToString();
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
                    string headcount = dr["HCount"].ToString();

                    if (category == "CHIEF SALESMAN" && location == "Office" && rtype == "Month")
                    {
                        txtMCLOffic.Text = duties;
                        txtMCLOffic_HC.Text = headcount;
                    }
                    else if (category == "CHIEF SALESMAN" && location == "Shop" && rtype == "Month")
                    {
                        txtMCLShop.Text = duties;
                        txtMCLShop_HC.Text = headcount;
                    }
                    else if (category == "SALESMAN" && location == "Office" && rtype == "Month")
                    {
                        txtMSoffice.Text = duties;
                        txtMSoffice_HC.Text = headcount;
                    }
                    else if (category == "SALESMAN" && location == "Shop" && rtype == "Month")
                    {
                        txtMSShop.Text = duties;
                        txtMSShop_HC.Text = headcount;
                    }
                    else if (category == "MULTIPURPOSE" && location == "Office" && rtype == "Month")
                    {
                        txtMMOffice.Text = duties;
                        txtMMOffice_HC.Text = headcount;
                    }
                    else if (category == "MULTIPURPOSE" && location == "Shop" && rtype == "Month")
                    {
                        txtMMShop.Text = duties;
                        txtMMShop_HC.Text = headcount;
                    }
                    else if (category == "CHIEF SALESMAN" && location == "Shop" && rtype == "OT")
                    {
                        txtOTCLShop.Text = duties;
                        txtOTCLShop_HC.Text = headcount;
                    }
                    else if (category == "SALESMAN" && location == "Shop" && rtype == "OT")
                    {
                        txtOTSShop.Text = duties;
                        txtOTSShop_HC.Text = headcount;
                    }
                    else if (category == "MULTIPURPOSE" && location == "Shop" && rtype == "OT")
                    {
                        txtOTMShop.Text = duties;
                        txtOTMShop_HC.Text = headcount;
                    }
                    else if (category == "CHIEF SALESMAN" && location == "Office" && rtype == "Day")
                    {
                        txtDCSOffice.Text = duties;
                        txtDCSOffice_HC.Text = headcount;
                    }
                    else if (category == "CHIEF SALESMAN" && location == "Shop" && rtype == "Day")
                    {
                        txtDCSShop.Text = duties;
                        txtDCSShop_HC.Text = headcount;
                    }
                    else if (category == "SALESMAN" && location == "Office" && rtype == "Day")
                    {
                        txtDSOffice.Text = duties;
                        txtDSOffice_HC.Text = headcount;
                    }
                    else if (category == "SALESMAN" && location == "Shop" && rtype == "Day")
                    {
                        txtDSShop.Text = duties;
                        txtDSShop_HC.Text = headcount;
                    }
                    else if (category == "MULTIPURPOSE" && location == "Office" && rtype == "Day")
                    {
                        txtDMOffice.Text = duties;
                        txtDMOffice_HC.Text = headcount;
                    }
                    else if (category == "MULTIPURPOSE" && location == "Shop" && rtype == "Day")
                    {
                        txtDMShop.Text = duties;
                        txtDMShop_HC.Text = headcount;
                    }
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

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            UpdateReportData();

        }
        private void UpdateReportData()
        {
            string updatedBy = Session["UserName"] != null ? Session["UserName"].ToString() : "System";

            // Define ID mappings
            var dutiesList = new List<(TextBox TextBox, TextBox TextBox2, string CategoryID, string LocationID, string RtypeID)>
    {
        (txtMCLOffic_HC,txtMCLOffic, "EC1", "L1", "RT1"),
        (txtMCLShop_HC, txtMCLShop, "EC1", "L2", "RT1"),
        (txtMSoffice_HC,txtMSoffice, "EC2", "L1", "RT1"),
        (txtMSShop_HC,txtMSShop, "EC2", "L2", "RT1"),
        (txtMMOffice_HC,txtMMOffice, "EC3", "L1", "RT1"),
        (txtMMShop_HC,txtMMShop, "EC3", "L2", "RT1"),

        (txtOTCLShop_HC,txtOTCLShop, "EC1", "L2", "RT2"),
        (txtOTSShop_HC,txtOTSShop, "EC2", "L2", "RT2"),
        (txtOTMShop_HC,txtOTMShop, "EC3", "L2", "RT2"),

        (txtDCSOffice_HC,txtDCSOffice, "EC1", "L1", "RT3"),
        (txtDCSShop_HC,txtDCSShop, "EC1", "L2", "RT3"),
        (txtDSOffice_HC,txtDSOffice, "EC2", "L1", "RT3"),
        (txtDSShop_HC,txtDSShop, "EC2", "L2", "RT3"),
        (txtDMOffice_HC,txtDMOffice, "EC3", "L1", "RT3"),
        (txtDMShop_HC, txtDMShop, "EC3", "L2", "RT3")
    };

            foreach (var item in dutiesList)
            {
                if (!string.IsNullOrWhiteSpace(item.TextBox.Text)|| !string.IsNullOrWhiteSpace(item.TextBox2.Text))
                {
                    SqlParameter[] parameters = new SqlParameter[]
                    {
                new SqlParameter("@District_ID", 101),
                new SqlParameter("@FY", ddlFYreport.SelectedValue),
                new SqlParameter("@Month", ddlmonthreport.SelectedValue),
                new SqlParameter("@CategoryID", item.CategoryID),
                new SqlParameter("@LocationID", item.LocationID),
                new SqlParameter("@RtypeID", item.RtypeID),
                new SqlParameter("@NoOfDuties", item.TextBox2.Text),
                new SqlParameter("@HCount", item.TextBox.Text),
           //     new SqlParameter("@ApproveByDishead", "0"),
                new SqlParameter("@UpdateBy", updatedBy)
                    };

                    db.ExecuteNonQuery("csmcl_UpdateDutyEntries", parameters);  
                }
            }
            desabletxt();
            btnupdate.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "ApproveSuccess",
            "Swal.fire({ icon: 'success', title: 'Records updated successfully.', text: '' });", true);

           // lblmsg.Visible = true;
           // lblmsg.Text = "";
        }

        public void desabletxt()
        {

                txtMCLOffic.Enabled = false;
                txtMCLOffic_HC.Enabled = false;
                txtMCLShop.Enabled = false;
                txtMCLShop_HC.Enabled = false;
                txtMSoffice.Enabled = false;
                txtMSoffice_HC.Enabled = false;
                txtMSShop.Enabled = false;
                txtMSShop_HC.Enabled = false;
                txtMMOffice.Enabled = false;
                txtMMOffice_HC.Enabled = false;
                txtMMShop.Enabled = false;
                txtMMShop_HC.Enabled = false;
                txtOTCLShop.Enabled = false;
                txtOTCLShop_HC.Enabled = false;
                txtOTSShop.Enabled = false;
                txtOTSShop_HC.Enabled = false;
                txtOTMShop.Enabled = false;
                txtOTMShop_HC.Enabled = false;
                txtDCSOffice.Enabled = false;
                txtDCSOffice_HC.Enabled = false;
                txtDCSShop.Enabled = false;
                txtDCSShop_HC.Enabled = false;
                txtDSOffice.Enabled = false;
                txtDSOffice_HC.Enabled = false;
                txtDSShop.Enabled = false;
                txtDSShop_HC.Enabled = false;
                txtDMOffice.Enabled = false;
                txtDMOffice_HC.Enabled = false;
                txtDMShop.Enabled = false;
                txtDMShop_HC.Enabled = false;
          
        }
        public void Enabletxt()
        {

            txtMCLOffic.Enabled = true;
            txtMCLOffic_HC.Enabled = true;
            txtMCLShop.Enabled = true;
            txtMCLShop_HC.Enabled = true;
            txtMSoffice.Enabled = true;
            txtMSoffice_HC.Enabled = true;
            txtMSShop.Enabled = true;
            txtMSShop_HC.Enabled = true;
            txtMMOffice.Enabled = true;
            txtMMOffice_HC.Enabled = true;
            txtMMShop.Enabled = true;
            txtMMShop_HC.Enabled = true;
            txtOTCLShop.Enabled = true;
            txtOTCLShop_HC.Enabled = true;
            txtOTSShop.Enabled = true;
            txtOTSShop_HC.Enabled = true;
            txtOTMShop.Enabled = true;
            txtOTMShop_HC.Enabled = true;
            txtDCSOffice.Enabled = true;
            txtDCSOffice_HC.Enabled = true;
            txtDCSShop.Enabled = true;
            txtDCSShop_HC.Enabled = true;
            txtDSOffice.Enabled = true;
            txtDSOffice_HC.Enabled = true;
            txtDSShop.Enabled = true;
            txtDSShop_HC.Enabled = true;
            txtDMOffice.Enabled = true;
            txtDMOffice_HC.Enabled = true;
            txtDMShop.Enabled = true;
            txtDMShop_HC.Enabled = true;

        }

    }
}