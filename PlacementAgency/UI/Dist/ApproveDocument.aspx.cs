using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Dist
{
    public partial class ApproveDocument : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                
            }

        }

        protected void ddlMonthAg_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlEPF_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlEPF.SelectedValue == "Reject")
                txtepf.Visible = true;
            else
                    txtepf.Visible = false;
        }

        protected void ddlESIR_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlESIR.SelectedValue == "Reject")
                txtesir.Visible = true;
            else
                txtesir.Visible = false;
        }

        protected void ddlGST_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlGST.SelectedValue == "Reject")
                txtgst.Visible = true;
            else
                txtgst.Visible = false;
        }

        protected void ddlNEmpoy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlNEmpoy.SelectedValue == "Reject")
                txtnemply.Visible = true;
            else
                txtnemply.Visible = false;
        }

        protected void ddlspcerti_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlspcerti.SelectedValue == "Reject")
                txtespc.Visible = true;
            else
                txtespc.Visible = false;

        }
        protected void ddlSOP_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSOP.SelectedValue == "Reject")
                txtsop.Visible = true;
            else
                txtsop.Visible = false;
        }
    }
}