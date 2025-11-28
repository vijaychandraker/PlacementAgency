using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
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
            }


        }
        public void BindrateMaster()
        {

            DataTable dtval = db.ExecuteQuery("csmcl_GetRateEntries", null);
            gv_ratemsater.DataSource = dtval;
            gv_ratemsater.DataBind();
        }
    }
}