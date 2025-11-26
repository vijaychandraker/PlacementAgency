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
               // BindZone();
                BindFY();
            }
        }
        
        public void BindFY()
        {
            ddlFYdis.Items.Clear();

            // Get current date and year
            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1; // FY starts in April

            // Generate last 2 + current FY
            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYdis.Items.Add(new ListItem(fy, fy));
            }

            // Add default item at top
            ddlFYdis.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            ddlMonthdis.Items.Insert(0, new ListItem("-- Select Month --", ""));

            // Optional: auto-select current FY
            // string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFY.SelectedValue = currentFY;
        }
        public void BindMonthByFY(string selectedFY)
        {
            ddlMonthdis.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlMonthdis.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }
            // Extract years from FY like "2025-26"
            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            // April–December of startYear
            for (int m = 4; m <= 12; m++)
            {
                string monthName = new DateTime(startYear, m, 1).ToString("MMMM");
                ddlMonthdis.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            // January–March of nextYear
            for (int m = 1; m <= 3; m++)
            {
                string monthName = new DateTime(endYear, m, 1).ToString("MMMM");
                ddlMonthdis.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            //  ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }

        protected void ddlFY_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFYdis.SelectedValue);
        }
        public void BindDutyRateData()
        {

            maincont.Visible = true;
           // divmsg.Visible = true;
            SqlParameter[] param = new SqlParameter[]
            {
        new SqlParameter("@Month", ddlMonthdis.SelectedValue),
        new SqlParameter("@FY", ddlFYdis.SelectedValue),
        new SqlParameter("@ApproveByDishead", "0"),
        new SqlParameter("@District_ID", 101)
            };

            DataTable dt = db.ExecuteQuery("csmcl_sp_GetDutyEntryApproveStatus_ByDist", param);

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
            clr(lbl_CS_Off_Mdis); clr(lbl_CS_Off_M_HCdis); clr(lbl_CS_Off_M_Dutdis); clr(lbl_CS_Off_M_Totaldis);
            clr(lbl_CS_Sh_Mdis); clr(lbl_CS_Sh_M_HCdis); clr(lbl_CS_Sh_M_Dutdis); clr(lbl_CS_Sh_M_Totaldis);
            clr(lbl_S_Off_Mdis); clr(lbl_S_Off_M_HCdis); clr(lbl_S_Off_M_Dutdis); clr(lbl_S_Off_M_Totaldis);
            clr(lbl_S_Sh_Mdis); clr(lbl_S_Sh_M_HCdis); clr(lbl_S_Sh_M_Dutdis); clr(lbl_S_Sh_M_Totaldis);
            clr(lbl_M_Off_Mdis); clr(lbl_M_Off_M_HCdis); clr(lbl_M_Off_M_Dutdis); clr(lbl_M_Off_M_Totaldis);
            clr(lbl_M_Sh_Mdis); clr(lbl_M_Sh_M_HCdis); clr(lbl_M_Sh_M_Dutdis); clr(lbl_M_Sh_M_Totaldis);

            clr(lbl_CS_Sh_OTdis); clr(lbl_CS_Sh_OT_HCdis); clr(lbl_CS_Sh_OT_Dutdis); clr(lbl_CS_Sh_OT_Totaldis);
            clr(lbl_S_Sh_OTdis); clr(lbl_S_Sh_OT_HCdis); clr(lbl_S_Sh_OT_Dutdis); clr(lbl_S_Sh_OT_Dut_Totaldis);
            clr(lbl_M_Sh_OTdis); clr(lbl_M_Sh_OT_HCdis); clr(lbl_M_Sh_OT_Dutdis); clr(lbl_M_Sh_OT_Totaldis);

            clr(lbl_CS_Off_Ddis); clr(lbl_CS_Off_D_HCdis); clr(lbl_CS_Off_D_Dutdis); clr(lbl_CS_Off_D_Totaldis);
            clr(lbl_CS_Sh_Ddis); clr(lbl_CS_Sh_D_HCdis); clr(lbl_CS_Sh_D_Dutdis); clr(lbl_CS_Sh_D_Totaldis);
            clr(lbl_S_Off_Ddis); clr(lbl_S_Off_D_HCdis); clr(lbl_S_Off_D_Dutdis); clr(lbl_S_Off_D_Totaldis);
            clr(lbl_S_Sh_Ddis); clr(lbl_S_Sh_D_HCdis); clr(lbl_S_Sh_D_Dutdis); clr(lbl_S_Sh_D_Totaldis);
            clr(lbl_M_Off_Ddis); clr(lbl_M_Off_D_HCdis); clr(lbl_M_Off_D_Dutdis); clr(lbl_M_Off_D_Totaldis);
            clr(lbl_M_Sh_Ddis); clr(lbl_M_Sh_D_HCdis); clr(lbl_M_Sh_D_Dutdis); clr(lbl_M_Sh_D_Totaldis);

            // totals placeholders (make sure these labels exist in .aspx or change names)
            if (lblTotalAdis != null) lblTotalAdis.Text = "";
            if (lblTotalBdis != null) lblTotalBdis.Text = "";
            if (lblTotalCdis != null) lblTotalCdis.Text = "";
            if (lblTotalD_AplusBplusCdis != null) lblTotalD_AplusBplusCdis.Text = "";
            if (lblESICdis != null) lblESICdis.Text = "";
            if (lblEPFdis != null) lblEPFdis.Text = "";
            if (lblAgencyChargesdis != null) lblAgencyChargesdis.Text = "";
            if (lblTotalEdis != null) lblTotalEdis.Text = "";
            if (lblCGSTdis != null) lblCGSTdis.Text = "";
            if (lblSGSTdis != null) lblSGSTdis.Text = "";
            if (lblGrandTotaldis != null) lblGrandTotaldis.Text = "";
            if (lblTDSdis != null) lblTDSdis.Text = "";
            if (lblLessCGSTdis != null) lblLessCGSTdis.Text = "";
            if (lblLessSGSTdis != null) lblLessSGSTdis.Text = "";
            if (lblRoundedTotaldis != null) lblRoundedTotaldis.Text = "";

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
                            lbl_CS_Off_Mdis.Text = F(amount);
                            lbl_CS_Off_M_HCdis.Text = headCount.ToString();
                            lbl_CS_Off_M_Dutdis.Text = duties.ToString();
                            lbl_CS_Off_M_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_Mdis.Text = F(amount);
                            lbl_CS_Sh_M_HCdis.Text = headCount.ToString();
                            lbl_CS_Sh_M_Dutdis.Text = duties.ToString();
                            lbl_CS_Sh_M_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Off_Mdis.Text = F(amount);
                            lbl_S_Off_M_HCdis.Text = headCount.ToString();
                            lbl_S_Off_M_Dutdis.Text = duties.ToString();
                            lbl_S_Off_M_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_Mdis.Text = F(amount);
                            lbl_S_Sh_M_HCdis.Text = headCount.ToString();
                            lbl_S_Sh_M_Dutdis.Text = duties.ToString();
                            lbl_S_Sh_M_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Off_Mdis.Text = F(amount);
                            lbl_M_Off_M_HCdis.Text = headCount.ToString();
                            lbl_M_Off_M_Dutdis.Text = duties.ToString();
                            lbl_M_Off_M_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_Mdis.Text = F(amount);
                            lbl_M_Sh_M_HCdis.Text = headCount.ToString();
                            lbl_M_Sh_M_Dutdis.Text = duties.ToString();
                            lbl_M_Sh_M_Totaldis.Text = F(lineTotal);
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
                            lbl_CS_Sh_OTdis.Text = F(amount);
                            lbl_CS_Sh_OT_HCdis.Text = headCount.ToString();
                            lbl_CS_Sh_OT_Dutdis.Text = duties.ToString();
                            lbl_CS_Sh_OT_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_OTdis.Text = F(amount);
                            lbl_S_Sh_OT_HCdis.Text = headCount.ToString();
                            lbl_S_Sh_OT_Dutdis.Text = duties.ToString();
                            lbl_S_Sh_OT_Dut_Totaldis.Text = F(lineTotal); // you used this ID in markup
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_OTdis.Text = F(amount);
                            lbl_M_Sh_OT_HCdis.Text = headCount.ToString();
                            lbl_M_Sh_OT_Dutdis.Text = duties.ToString();
                            lbl_M_Sh_OT_Totaldis.Text = F(lineTotal);
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
                            lbl_CS_Off_Ddis.Text = F(amount);
                            lbl_CS_Off_D_HCdis.Text = headCount.ToString();
                            lbl_CS_Off_D_Dutdis.Text = duties.ToString();
                            lbl_CS_Off_D_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_Ddis.Text = F(amount);
                            lbl_CS_Sh_D_HCdis.Text = headCount.ToString();
                            lbl_CS_Sh_D_Dutdis.Text = duties.ToString();
                            lbl_CS_Sh_D_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Off_Ddis.Text = F(amount);
                            lbl_S_Off_D_HCdis.Text = headCount.ToString();
                            lbl_S_Off_D_Dutdis.Text = duties.ToString();
                            lbl_S_Off_D_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_Ddis.Text = F(amount);
                            lbl_S_Sh_D_HCdis.Text = headCount.ToString();
                            lbl_S_Sh_D_Dutdis.Text = duties.ToString();
                            lbl_S_Sh_D_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Off_Ddis.Text = F(amount);
                            lbl_M_Off_D_HCdis.Text = headCount.ToString();
                            lbl_M_Off_D_Dutdis.Text = duties.ToString();
                            lbl_M_Off_D_Totaldis.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_Ddis.Text = F(amount);
                            lbl_M_Sh_D_HCdis.Text = headCount.ToString();
                            lbl_M_Sh_D_Dutdis.Text = duties.ToString();
                            lbl_M_Sh_D_Totaldis.Text = F(lineTotal);
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
                if (lblTotalAdis != null) lblTotalAdis.Text = F(totalA);
                if (lblTotalBdis != null) lblTotalBdis.Text = F(totalB);
                if (lblTotalCdis != null) lblTotalCdis.Text = F(totalC);

                //// Example downstream calculations (adjust percentages or label IDs as needed)
                decimal D_total = totalA + totalB + totalC; // as per your sheet A + B
                if (lblTotalD_AplusBplusCdis != null) lblTotalD_AplusBplusCdis.Text = F(D_total);

                decimal esi = D_total * 0.0325m;
                decimal epf = 3217113 * 0.13m;
                decimal agencyCharges = D_total * 0.09m;

                if (lblESICdis != null) lblESICdis.Text = F(esi);
                if (lblEPFdis != null) lblEPFdis.Text = F(epf);
                if (lblAgencyChargesdis != null) lblAgencyChargesdis.Text = F(agencyCharges);

                decimal totalE = D_total + esi + epf + agencyCharges;
                if (lblTotalEdis != null) lblTotalEdis.Text = F(totalE);

                decimal cgst = totalE * 0.09m;
                decimal sgst = totalE * 0.09m;
                if (lblCGSTdis != null) lblCGSTdis.Text = F(cgst);
                if (lblSGSTdis != null) lblSGSTdis.Text = F(sgst);

                decimal grandF = totalE + cgst + sgst;
                if (lblGrandTotaldis != null) lblGrandTotaldis.Text = F(grandF);

        
                decimal tds = totalE * 0.001m;
                decimal lessCgst = totalE * 0.01m;
                decimal lessSgst = totalE * 0.01m;

                if (lblTDSdis != null) lblTDSdis.Text = F(tds);
                if (lblLessCGSTdis != null) lblLessCGSTdis.Text = F(lessCgst);
                if (lblLessSGSTdis != null) lblLessSGSTdis.Text = F(lessSgst);

                decimal rounded = grandF - (tds + lessCgst + lessSgst);
                if (lblRoundedTotaldis != null) lblRoundedTotaldis.Text = F(Math.Round(rounded, 0, MidpointRounding.AwayFromZero));

                //if (lblTDSdis != null) lblTDSdis.Text = "Pending by State";
                //if (lblLessCGSTdis != null) lblLessCGSTdis.Text = "Pending by State";
                //if (lblLessSGSTdis != null) lblLessSGSTdis.Text = "Pending by State";

                //decimal rounded = grandF - (tds + lessCgst + lessSgst);
                //if (lblRoundedTotaldis != null) lblRoundedTotaldis.Text = "Pending";
            }
            else
            {
                maincont.Visible = false;
               // divmsg.Visible = false;
            }
        }


        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDutyRateData();

        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            {
                SqlParameter[] parameters = {
            new SqlParameter("@District_ID", 101),
            new SqlParameter("@FY", ddlFYdis.SelectedValue),
            new SqlParameter("@Month",  ddlMonthdis.SelectedValue)
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            {
                SqlParameter[] parameters = {
            new SqlParameter("@District_ID", 101),
            new SqlParameter("@FY", ddlFYdis.SelectedValue),
            new SqlParameter("@Month",  ddlMonthdis.SelectedValue),
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