using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices.Internal;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Dashboard
{
    public partial class csmcl_ratemaster : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindrateMaster();
                BindFY();
                BindLocation();
                BindCategory();
                BindRateType();
            }


        }
        public void BindrateMaster()
        {
            DataTable dt = db.ExecuteQuery("csmcl_GetRateEntries", null);
            gv_ratemsater.DataSource = dt;
            gv_ratemsater.DataBind();
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
            // string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFY.SelectedValue = currentFY;
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

        protected void gv_ratemsater_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gv_ratemsater.EditIndex = e.NewEditIndex;
            BindrateMaster();
        }

        protected void gv_ratemsater_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gv_ratemsater.EditIndex = -1;
            BindrateMaster();
        }

        protected void gv_ratemsater_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rateId = Convert.ToInt32(gv_ratemsater.DataKeys[e.RowIndex].Value);

            GridViewRow row = gv_ratemsater.Rows[e.RowIndex];

            DropDownList ddlCat = (DropDownList)row.FindControl("ddlEditCategory");
            DropDownList ddlLoc = (DropDownList)row.FindControl("ddlEditLocation");
            DropDownList ddlRt = (DropDownList)row.FindControl("ddlEditRateType");
            TextBox txtAmount = (TextBox)row.FindControl("txtEditAmount");

            SqlParameter[] parameters = new SqlParameter[]
            {
        new SqlParameter("@RateID", rateId),
        new SqlParameter("@CategoryID", ddlCat.SelectedValue),
        new SqlParameter("@LocationID", ddlLoc.SelectedValue),
        new SqlParameter("@RtypeID", ddlRt.SelectedValue),
        new SqlParameter("@Amount", txtAmount.Text)
            };

            db.ExecuteNonQuery("usp_UpdateRateMaster", parameters);

            gv_ratemsater.EditIndex = -1;
            BindrateMaster();
        }

        protected void gv_ratemsater_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rateId = Convert.ToInt32(gv_ratemsater.DataKeys[e.RowIndex].Value);

            SqlParameter[] parameters = new SqlParameter[]
            {
        new SqlParameter("@RateID", rateId)
            };

            db.ExecuteNonQuery("usp_DeleteRateMaster", parameters);

            BindrateMaster();
        }

        protected void gv_ratemsater_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
                (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;

                // Category
                DropDownList ddlCat = (DropDownList)e.Row.FindControl("ddlEditCategory");
                ddlCat.DataSource = db.ExecuteQuery("csmcl_sp_GetAllEmployeeCategories", null);
                ddlCat.DataBind();
                ddlCat.SelectedValue = drv["CategoryID"].ToString();

                // Location
                DropDownList ddlLoc = (DropDownList)e.Row.FindControl("ddlEditLocation");
                ddlLoc.DataSource = db.ExecuteQuery("csmcl_sp_GetAllLocations", null);
                ddlLoc.DataBind();
                ddlLoc.SelectedValue = drv["LocationID"].ToString();

                // Rate Type
                DropDownList ddlRt = (DropDownList)e.Row.FindControl("ddlEditRateType");
                ddlRt.DataSource = db.ExecuteQuery("csmcl_sp_GetAllRateTypes", null);
                ddlRt.DataBind();
                ddlRt.SelectedValue = drv["RtypeID"].ToString();
            }
        }


    }
}