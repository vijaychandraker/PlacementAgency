using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace PlacementAgency.UI.Dist
{
    public partial class csmcl_DistEntry : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bindmonth();
                BindLocation();
                BindCategory();
                BindRateType();
                BindFY();
            }
        }

        //month
        public void Bindmonth()
        {
            DataTable dtval = db.ExecuteQuery("csmcl_sp_GetAllMonths", null);
            ddlmonth.DataSource = dtval;
            ddlmonth.DataTextField = "MonthName";
            ddlmonth.DataValueField = "MonthID";
            ddlmonth.DataBind();
            // Add default item at the top
            ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }
        public void BindLocation()
        {
            DataTable dtlo = db.ExecuteQuery("csmcl_sp_GetAllLocations", null);
            ddllocation.DataSource = dtlo;
            ddllocation.DataTextField = "LocationName";
            ddllocation.DataValueField = "LocationID";
            ddllocation.DataBind();
            ddllocation.Items.Insert(0, new ListItem("-- Select Location --", ""));
        }
        public void BindCategory()
        {
            DataTable dtct = db.ExecuteQuery("csmcl_sp_GetAllEmployeeCategories", null);
            ddlcategory.DataSource = dtct;
            ddlcategory.DataTextField = "CategoryName";
            ddlcategory.DataValueField = "CategoryID";
            ddlcategory.DataBind();
            ddlcategory.Items.Insert(0, new ListItem("-- Select Category --", ""));
        }
        public void BindRateType()
        {
            DataTable dtrt = db.ExecuteQuery("csmcl_sp_GetAllRateTypes", null);
            ddlrtype.DataSource = dtrt;
            ddlrtype.DataTextField = "RateTypeName";
            ddlrtype.DataValueField = "RtypeID";
            ddlrtype.DataBind();
            ddlrtype.Items.Insert(0, new ListItem("-- Select Rate Type --", ""));
        }
        public void BindFY()
        {
            ddlFY.Items.Clear();

            // Get current date and year
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1; // FY starts in April

            // Generate last 2 + current FY
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFY.Items.Add(new ListItem(fy, fy));
            }

            // Add default item at top
            ddlFY.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));

            // Optional: auto-select current FY
            // string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFY.SelectedValue = currentFY;
        }

        public string GenerateRandomID()
        {
            // Prefix with 'D'
            string prefix = "D";

            // Current date in yyyyMMdd format (e.g. 20251106)
            string datePart = DateTime.Now.ToString("yyyyMMdd");

            // Random 5-digit number
            Random rand = new Random();
            string randomPart = rand.Next(10000, 99999).ToString();

            // Combine all parts
            string generatedID = prefix + datePart + randomPart;

            return generatedID;
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlcategory.SelectedValue) ||
       string.IsNullOrEmpty(ddllocation.SelectedValue) ||
       string.IsNullOrEmpty(ddlrtype.SelectedValue))
            {
                // show validation message here
                return;
            }

            SqlParameter[] parameters = {
        new SqlParameter("@EntryID", GenerateRandomID()),
        new SqlParameter("@Zone_ID", "Z1"),
        new SqlParameter("@Agency_ID", "AG1"),
        new SqlParameter("@District_ID", 101),
        new SqlParameter("@CategoryID", ddlcategory.SelectedValue),
        new SqlParameter("@LocationID", ddllocation.SelectedValue),
        new SqlParameter("@RtypeID", ddlrtype.SelectedValue),
        new SqlParameter("@NoOfDuties", duties.Text.Trim()),
        new SqlParameter("@Month", ddlmonth.SelectedValue),
        new SqlParameter("@FY", ddlFY.SelectedValue),
        new SqlParameter("@ApproveByDishead", "0"),
        new SqlParameter("@EntryBy", "abc")
    };

            int rows = db.ExecuteNonQuery("csmcl_sp_InsertDutyEntry", parameters);
            if (rows > 0)
            {

            }
            else
            {

            }

        }

        public void BindMonthByFY(string selectedFY)
        {
            ddlmonth.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }
            // Extract years from FY like "2025-26"
            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            // April–December of startYear
            for (int m = 4; m <= 12; m++)
            {
                string monthName = new DateTime(startYear, m, 1).ToString("MMMM");
                ddlmonth.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            // January–March of nextYear
            for (int m = 1; m <= 3; m++)
            {
                string monthName = new DateTime(endYear, m, 1).ToString("MMMM");
                ddlmonth.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

          //  ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }

        protected void ddlFY_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFY.SelectedValue);
        }
    }
    }