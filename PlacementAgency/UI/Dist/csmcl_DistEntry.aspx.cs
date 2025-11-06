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
                Bindmonth();
            BindLocation();
            BindCategory();
            BindRateType();
            BindFY();
        }

        //month
        public void Bindmonth()
        {
            DataTable dtCompany = db.ExecuteQuery("csmcl_sp_GetAllMonths", null);
            ddlmonth.DataSource = dtCompany;
            ddlmonth.DataTextField = "MonthName";
            ddlmonth.DataValueField = "MonthID";
            ddlmonth.DataBind();
            // Add default item at the top
            ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }
        public void BindLocation()
        {
            DataTable dt = db.ExecuteQuery("csmcl_sp_GetAllLocations", null);
            ddllocation.DataSource = dt;
            ddllocation.DataTextField = "LocationName";
            ddllocation.DataValueField = "LocationID";
            ddllocation.DataBind();
            ddllocation.Items.Insert(0, new ListItem("-- Select Location --", ""));
        }
        public void BindCategory()
        {
            DataTable dt = db.ExecuteQuery("csmcl_sp_GetAllEmployeeCategories", null);
            ddlcategory.DataSource = dt;
            ddlcategory.DataTextField = "CategoryName";
            ddlcategory.DataValueField = "CategoryID";
            ddlcategory.DataBind();
            ddlcategory.Items.Insert(0, new ListItem("-- Select Category --", ""));
        }
        public void BindRateType()
        {
            DataTable dt = db.ExecuteQuery("csmcl_sp_GetAllRateTypes", null);
            ddlrtype.DataSource = dt;
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

            // Optional: auto-select current FY
            string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            ddlFY.SelectedValue = currentFY;
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
            SqlParameter[] parameters = {   
                    new SqlParameter("@month", ddlmonth.SelectedValue),
                    new SqlParameter("@location",ddllocation.SelectedValue),
                    new SqlParameter("@category", ddlcategory.SelectedValue),
                    new SqlParameter("@rtype", ddlrtype.SelectedValue),
                    new SqlParameter("@duties", duties.Text.Trim()),
                    new SqlParameter("@EntryID", GenerateRandomID()),
                    new SqlParameter("@Zone_ID", "Z1"),
                    new SqlParameter("@Agency_ID", "AG1"),
                    new SqlParameter("@District_ID",101),
                    new SqlParameter("@FY",ddlFY.SelectedValue),
                    new SqlParameter("@EntryBy", "abc"),
                     new SqlParameter("@UpdateDate", ""),
                    new SqlParameter("@UpdateBy", "abc")
                    };
                db.ExecuteNonQuery("InsertInsurancePolicy", parameters);
            int successdata = (int)parameters[parameters.Length - 1].Value;
            if (successdata > 0)
            {
                
            }
            else
            {
                
            }

        }
    }
}