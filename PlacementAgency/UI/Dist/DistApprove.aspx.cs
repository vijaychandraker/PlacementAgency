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
    public partial class DistApprove : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                Bindmonth();
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
                new SqlParameter("@ApproveByDishead", "0"),
           };
            DataTable dtgrd = db.ExecuteQuery("csmcl_sp_GetDutyEntryDetails", param);
            if (dtgrd.Rows.Count > 0)
            {
                lblmsg.Visible = false;
                gveDuty.DataSource = dtgrd;
                gveDuty.DataBind();
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "No data Found";
                maincontApprove.Visible = false;
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            {
                SqlParameter[] parameters = {             
            new SqlParameter("@District_ID", 101),
            new SqlParameter("@FY", ddlFYDapprove.SelectedValue),
            new SqlParameter("@Month",  ddlmonthDApprove.SelectedValue)
        };

                int rows = db.ExecuteNonQuery("csmcl_sp_UpdateApproveByDisthead", parameters);

                if (rows > 0)
                {
                    lblmsg.Text = "District approval successful.";
                }
                else
                {
                    lblmsg.Text = "No pending records found for approval.";
              
                }
            }
            
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            txtreasion.Visible = true;
            btnSubmit.Visible = true;
        }

         public void Bindmonth()
        {
            DataTable dtval = db.ExecuteQuery("csmcl_sp_GetAllMonths", null);
            ddlmonthDApprove.DataSource = dtval;
            ddlmonthDApprove.DataTextField = "MonthName";
            ddlmonthDApprove.DataValueField = "MonthID";
            ddlmonthDApprove.DataBind();
            ddlmonthDApprove.Items.Insert(0, new ListItem("-- Select Month --", ""));
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
                lblmsg.Visible = false;
                maincontApprove.Visible = true;
                BindGrid();
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "select Dropdown";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            {
                SqlParameter[] parameters = {
            new SqlParameter("@District_ID", 101),
            new SqlParameter("@FY", ddlFYDapprove.SelectedValue),
            new SqlParameter("@Month",  ddlmonthDApprove.SelectedValue),
            new SqlParameter("@RejectByDishead_Note",  txtreasion.Text.Trim())

        };

                int rows = db.ExecuteNonQuery("csmcl_sp_UpdateRejectByDisthead_note", parameters);

                if (rows > 0)
                {
                    lblmsg.Text = "District approval successful.";
                }
                else
                {
                    lblmsg.Text = "No pending records found for approval.";

                }
            }

        }
    }
}