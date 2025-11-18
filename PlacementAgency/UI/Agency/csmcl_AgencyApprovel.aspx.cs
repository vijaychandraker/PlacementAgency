using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Agency
{
    public partial class csmcl_AgencyApprovel : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDistrict();
                BindFY();
            }
        }

        public void BindFY()
        {
            ddlFYAg.Items.Clear();

            // Get current date and year
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1; // FY starts in April

            // Generate last 2 + current FY
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYAg.Items.Add(new ListItem(fy, fy));
            }

            // Add default item at top
            ddlFYAg.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            ddlMonthAg.Items.Insert(0, new ListItem("-- Select Month --", ""));

            // Optional: auto-select current FY
            // string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFY.SelectedValue = currentFY;
        }

        public void BindDistrict()
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Agency_ID", "AG1")

           };

            DataTable dtct = db.ExecuteQuery("csmcl_sp_GetDistrictByAgency", param);
            ddldistrictAgent.DataSource = dtct;
            ddldistrictAgent.DataTextField = "District_Name";
            ddldistrictAgent.DataValueField = "District_ID";
            ddldistrictAgent.DataBind();

            ddldistrictAgent.Items.Insert(0, new ListItem("-- Select District --", ""));


        }
        public void BindMonthByFY(string selectedFY)
        {
            ddlMonthAg.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlMonthAg.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }
            // Extract years from FY like "2025-26"
            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            // April–December of startYear
            for (int m = 4; m <= 12; m++)
            {
                string monthName = new DateTime(startYear, m, 1).ToString("MMMM");
                ddlMonthAg.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            // January–March of nextYear
            for (int m = 1; m <= 3; m++)
            {
                string monthName = new DateTime(endYear, m, 1).ToString("MMMM");
                ddlMonthAg.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            //  ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }

        protected void ddlFY_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFYAg.SelectedValue);
        }
        public void BindDutyRateData()
        {

            maincont.Visible = true;
            divmsg.Visible = true;
            SqlParameter[] param = new SqlParameter[]
            {
        new SqlParameter("@Month", ddlMonthAg.SelectedValue),
        new SqlParameter("@FY", ddlFYAg.SelectedValue),
        new SqlParameter("@ApproveByDishead", "1"),
        new SqlParameter("@District_ID", ddldistrictAgent.SelectedValue)
            };

            DataTable dt = db.ExecuteQuery("csmcl_sp_GetDutyEntryApproveStatus_ByAgency", param);

            // Helpers
            decimal ToDecimal(object o)
            {
                if (o == null || o == DBNull.Value) return 0m;
                decimal x;
                return decimal.TryParse(o.ToString(), out x) ? x : 0m;
            }
            string F(decimal v) => v.ToString("N2");

            // Clear all labels first (prevent old values left behind)
            Action<Label> clr = lbl => { if (lbl != null) lbl.Text = ""; };
            clr(lbl_CS_Off_MAg); clr(lbl_CS_Off_M_HCAg); clr(lbl_CS_Off_M_DutAg); clr(lbl_CS_Off_M_TotalAg);
            clr(lbl_CS_Sh_MAg); clr(lbl_CS_Sh_M_HCAg); clr(lbl_CS_Sh_M_DutAg); clr(lbl_CS_Sh_M_TotalAg);
            clr(lbl_S_Off_MAg); clr(lbl_S_Off_M_HCAg); clr(lbl_S_Off_M_DutAg); clr(lbl_S_Off_M_TotalAg);
            clr(lbl_S_Sh_MAg); clr(lbl_S_Sh_M_HCAg); clr(lbl_S_Sh_M_DutAg); clr(lbl_S_Sh_M_TotalAg);
            clr(lbl_M_Off_MAg); clr(lbl_M_Off_M_HCAg); clr(lbl_M_Off_M_DutAg); clr(lbl_M_Off_M_TotalAg);
            clr(lbl_M_Sh_MAg); clr(lbl_M_Sh_M_HCAg); clr(lbl_M_Sh_M_DutAg); clr(lbl_M_Sh_M_TotalAg);

            clr(lbl_CS_Sh_OTAg); clr(lbl_CS_Sh_OT_HCAg); clr(lbl_CS_Sh_OT_DutAg); clr(lbl_CS_Sh_OT_TotalAg);
            clr(lbl_S_Sh_OTAg); clr(lbl_S_Sh_OT_HCAg); clr(lbl_S_Sh_OT_DutAg); clr(lbl_S_Sh_OT_Dut_TotalAg);
            clr(lbl_M_Sh_OTAg); clr(lbl_M_Sh_OT_HCAg); clr(lbl_M_Sh_OT_DutAg); clr(lbl_M_Sh_OT_TotalAg);

            clr(lbl_CS_Off_DAg); clr(lbl_CS_Off_D_HCAg); clr(lbl_CS_Off_D_DutAg); clr(lbl_CS_Off_D_TotalAg);
            clr(lbl_CS_Sh_DAg); clr(lbl_CS_Sh_D_HCAg); clr(lbl_CS_Sh_D_DutAg); clr(lbl_CS_Sh_D_TotalAg);
            clr(lbl_S_Off_DAg); clr(lbl_S_Off_D_HCAg); clr(lbl_S_Off_D_DutAg); clr(lbl_S_Off_D_TotalAg);
            clr(lbl_S_Sh_DAg); clr(lbl_S_Sh_D_HCAg); clr(lbl_S_Sh_D_DutAg); clr(lbl_S_Sh_D_TotalAg);
            clr(lbl_M_Off_DAg); clr(lbl_M_Off_D_HCAg); clr(lbl_M_Off_D_DutAg); clr(lbl_M_Off_D_TotalAg);
            clr(lbl_M_Sh_DAg); clr(lbl_M_Sh_D_HCAg); clr(lbl_M_Sh_D_DutAg); clr(lbl_M_Sh_D_TotalAg);

            // totals placeholders (make sure these labels exist in .aspx or change names)
            if (lblTotalAAg != null) lblTotalAAg.Text = "";
            if (lblTotalBAg != null) lblTotalBAg.Text = "";
            if (lblTotalCAg != null) lblTotalCAg.Text = "";
            if (lblTotalD_AplusBplusCAg != null) lblTotalD_AplusBplusCAg.Text = "";
            if (lblESICAg != null) lblESICAg.Text = "";
            if (lblEPFAg != null) lblEPFAg.Text = "";
            if (lblAgencyChargesAg != null) lblAgencyChargesAg.Text = "";
            if (lblTotalEAg != null) lblTotalEAg.Text = "";
            if (lblCGSTAg != null) lblCGSTAg.Text = "";
            if (lblSGSTAg != null) lblSGSTAg.Text = "";
            if (lblGrandTotalAg != null) lblGrandTotalAg.Text = "";
            if (lblTDSAg != null) lblTDSAg.Text = "";
            if (lblLessCGSTAg != null) lblLessCGSTAg.Text = "";
            if (lblLessSGSTAg != null) lblLessSGSTAg.Text = "";
            if (lblRoundedTotalAg != null) lblRoundedTotalAg.Text = "";

            // Accumulators
            decimal totalA = 0m; // monthly
            decimal totalB = 0m; // OT
            decimal totalC = 0m; // per day

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string category = (dr["CategoryName"] ?? "").ToString().Trim();
                    string rateType = (dr["RateTypeName"] ?? "").ToString().Trim();
                    string location = (dr["LocationName"] ?? "").ToString().Trim();

                    // Normalize common DB values if needed (adjust these if your DB uses different text)
                    string catNorm = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(
                        category.Replace("(Office)", "").Replace("(Shop)", "").ToLower()).Trim();
                    string rtNorm = rateType.Replace("Day", "Day").Trim();
                    rtNorm = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(rtNorm.ToLower());
                    string locNorm = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(location.ToLower()).Trim();

                    decimal headCount = ToDecimal(dr["HeadCount"]);
                    decimal amount = ToDecimal(dr["Amount"]);
                    decimal duties = ToDecimal(dr["NoOfDuties"]);

                    decimal lineTotal = 0m;

                    // MONTHLY
                    if (rtNorm.Equals("Month", StringComparison.OrdinalIgnoreCase))
                    {
                        lineTotal = (amount * duties) / 26;
                        totalA += lineTotal;

                        if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Off_MAg.Text = F(amount);
                            lbl_CS_Off_M_HCAg.Text = headCount.ToString();
                            lbl_CS_Off_M_DutAg.Text = duties.ToString();
                            lbl_CS_Off_M_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_MAg.Text = F(amount);
                            lbl_CS_Sh_M_HCAg.Text = headCount.ToString();
                            lbl_CS_Sh_M_DutAg.Text = duties.ToString();
                            lbl_CS_Sh_M_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Off_MAg.Text = F(amount);
                            lbl_S_Off_M_HCAg.Text = headCount.ToString();
                            lbl_S_Off_M_DutAg.Text = duties.ToString();
                            lbl_S_Off_M_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_MAg.Text = F(amount);
                            lbl_S_Sh_M_HCAg.Text = headCount.ToString();
                            lbl_S_Sh_M_DutAg.Text = duties.ToString();
                            lbl_S_Sh_M_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Off_MAg.Text = F(amount);
                            lbl_M_Off_M_HCAg.Text = headCount.ToString();
                            lbl_M_Off_M_DutAg.Text = duties.ToString();
                            lbl_M_Off_M_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_MAg.Text = F(amount);
                            lbl_M_Sh_M_HCAg.Text = headCount.ToString();
                            lbl_M_Sh_M_DutAg.Text = duties.ToString();
                            lbl_M_Sh_M_TotalAg.Text = F(lineTotal);
                        }
                    }
                    // OT - assuming NoOfDuties may represent OT Hours or the separate column; adjust if you store OT hours elsewhere
                    else if (rtNorm.Equals("OT", StringComparison.OrdinalIgnoreCase) || rtNorm.Equals("OT", StringComparison.OrdinalIgnoreCase))
                    {
                        // For OT we treat duties as total OT hours (adjust logic if needed)
                        lineTotal = amount * duties;
                        totalB += lineTotal;

                        if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_OTAg.Text = F(amount);
                            lbl_CS_Sh_OT_HCAg.Text = headCount.ToString();
                            lbl_CS_Sh_OT_DutAg.Text = duties.ToString();
                            lbl_CS_Sh_OT_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_OTAg.Text = F(amount);
                            lbl_S_Sh_OT_HCAg.Text = headCount.ToString();
                            lbl_S_Sh_OT_DutAg.Text = duties.ToString();
                            lbl_S_Sh_OT_Dut_TotalAg.Text = F(lineTotal); // you used this ID in markup
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_OTAg.Text = F(amount);
                            lbl_M_Sh_OT_HCAg.Text = headCount.ToString();
                            lbl_M_Sh_OT_DutAg.Text = duties.ToString();
                            lbl_M_Sh_OT_TotalAg.Text = F(lineTotal);
                        }
                    }
                    // Per Day
                    else if (rtNorm.Equals("Day", StringComparison.OrdinalIgnoreCase) || rtNorm.Equals("Day", StringComparison.OrdinalIgnoreCase))
                    {
                        // Per day: assume duties = number of days
                        lineTotal = amount * duties;
                        totalC += lineTotal;

                        if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Off_DAg.Text = F(amount);
                            lbl_CS_Off_D_HCAg.Text = headCount.ToString();
                            lbl_CS_Off_D_DutAg.Text = duties.ToString();
                            lbl_CS_Off_D_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_DAg.Text = F(amount);
                            lbl_CS_Sh_D_HCAg.Text = headCount.ToString();
                            lbl_CS_Sh_D_DutAg.Text = duties.ToString();
                            lbl_CS_Sh_D_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Off_DAg.Text = F(amount);
                            lbl_S_Off_D_HCAg.Text = headCount.ToString();
                            lbl_S_Off_D_DutAg.Text = duties.ToString();
                            lbl_S_Off_D_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_DAg.Text = F(amount);
                            lbl_S_Sh_D_HCAg.Text = headCount.ToString();
                            lbl_S_Sh_D_DutAg.Text = duties.ToString();
                            lbl_S_Sh_D_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Off_DAg.Text = F(amount);
                            lbl_M_Off_D_HCAg.Text = headCount.ToString();
                            lbl_M_Off_D_DutAg.Text = duties.ToString();
                            lbl_M_Off_D_TotalAg.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_DAg.Text = F(amount);
                            lbl_M_Sh_D_HCAg.Text = headCount.ToString();
                            lbl_M_Sh_D_DutAg.Text = duties.ToString();
                            lbl_M_Sh_D_TotalAg.Text = F(lineTotal);
                        }
                    }
                    // other/unknown rate types: fallback to write into Monthly boxes (or skip)
                    else
                    {
                        // optional: log or handle unknown RateTypeName
                        continue;
                    }
                }

                //// Write totals into labels (ensure these labels exist)
                if (lblTotalAAg != null) lblTotalAAg.Text = F(totalA);
                if (lblTotalBAg != null) lblTotalBAg.Text = F(totalB);
                if (lblTotalCAg != null) lblTotalCAg.Text = F(totalC);

                //// Example downstream calculations (adjust percentages or label IDs as needed)
                decimal D_total = totalA + totalB + totalC; // as per your sheet A + B
                if (lblTotalD_AplusBplusCAg != null) lblTotalD_AplusBplusCAg.Text = F(D_total);

                decimal esi = D_total * 0.0325m;
                decimal epf = 3217113 * 0.13m;
                decimal agencyCharges = D_total * 0.09m;

                if (lblESICAg != null) lblESICAg.Text = F(esi);
                if (lblEPFAg != null) lblEPFAg.Text = F(epf);
                if (lblAgencyChargesAg != null) lblAgencyChargesAg.Text = F(agencyCharges);

                decimal totalE = D_total + esi + epf + agencyCharges;
                if (lblTotalEAg != null) lblTotalEAg.Text = F(totalE);

                decimal cgst = totalE * 0.09m;
                decimal sgst = totalE * 0.09m;
                if (lblCGSTAg != null) lblCGSTAg.Text = F(cgst);
                if (lblSGSTAg != null) lblSGSTAg.Text = F(sgst);

                decimal grandF = totalE + cgst + sgst;
                if (lblGrandTotalAg != null) lblGrandTotalAg.Text = F(grandF);


                decimal tds = totalE * 0.001m;
                decimal lessCgst = totalE * 0.01m;
                decimal lessSgst = totalE * 0.01m;

                //if (lblTDSAg != null) lblTDSAg.Text = F(tds);
                //if (lblLessCGSTAg != null) lblLessCGSTAg.Text = F(lessCgst);
                //if (lblLessSGSTAg != null) lblLessSGSTAg.Text = F(lessSgst);

                //decimal rounded = grandF - (tds + lessCgst + lessSgst);
                //if (lblRoundedTotalAg != null) lblRoundedTotalAg.Text = F(Math.Round(rounded, 0, MidpointRounding.AwayFromZero));

                if (lblTDSAg != null) lblTDSAg.Text = "Pending by State";
                if (lblLessCGSTAg != null) lblLessCGSTAg.Text = "Pending by State";
                if (lblLessSGSTAg != null) lblLessSGSTAg.Text = "Pending by State";

                decimal rounded = grandF - (tds + lessCgst + lessSgst);
                if (lblRoundedTotalAg != null) lblRoundedTotalAg.Text = "Pending";
            }
            else
            {
                maincont.Visible = false;
                divmsg.Visible = false;
            }
        }


        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
           

        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            {
                SqlParameter[] parameters = {
            new SqlParameter("@District_ID", ddldistrictAgent.SelectedValue),
            new SqlParameter("@FY", ddlFYAg.SelectedValue),
            new SqlParameter("@Month",  ddlMonthAg.SelectedValue)
        };

                int rows = db.ExecuteNonQuery("csmcl_sp_UpdateApproveByAgency", parameters);

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
            txtreasionAg.Visible = true;
            btnSubmitAg.Visible = true;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            {
                SqlParameter[] parameters = {
            new SqlParameter("@District_ID", ddldistrictAgent.SelectedValue),
            new SqlParameter("@FY", ddlFYAg.SelectedValue),
            new SqlParameter("@Month",  ddlMonthAg.SelectedValue),
            new SqlParameter("@RejectByAghead_Note",  txtreasionAg.Text.Trim())

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

        protected void btnSubmit_Click1(object sender, EventArgs e)
        {
            BindDutyRateData();
        }
    }
}