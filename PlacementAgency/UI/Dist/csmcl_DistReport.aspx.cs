using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Dist
{
    public partial class csmcl_DistReport : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFY();
                Bindmonth();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        public void Bindmonth()
        {
            DataTable dtval = db.ExecuteQuery("csmcl_sp_GetAllMonths", null);
            ddlmonthreportdist.DataSource = dtval;
            ddlmonthreportdist.DataTextField = "MonthName";
            ddlmonthreportdist.DataValueField = "MonthID";
            ddlmonthreportdist.DataBind();
            ddlmonthreportdist.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }
        public void BindFY()
        {
            ddlFYreportdist.Items.Clear();
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1;
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYreportdist.Items.Add(new ListItem(fy, fy));
            }
            ddlFYreportdist.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            ddlFYreportdist.SelectedValue = currentFY;
        }
    }
}