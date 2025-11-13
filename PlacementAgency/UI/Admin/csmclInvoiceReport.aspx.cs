using PlacementAgency.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Admin
{
    public partial class csmclInvoiceReport : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindZone();
                BindFY();
            }
        }
        public void BindZone()
        {
            DataTable dtval = db.ExecuteQuery("csmcl_sp_GetZoneList", null);
            ddlZone.DataSource = dtval;
            ddlZone.DataTextField = "Zone_Name";
            ddlZone.DataValueField = "Zone_ID";
            ddlZone.DataBind();
            // Add default item at the top
            ddlZone.Items.Insert(0, new ListItem("-- Select Zone --", ""));
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
            ddlMonth.Items.Insert(0, new ListItem("-- Select Month --", ""));

            // Optional: auto-select current FY
            // string currentFY = $"{currentYear}-{(currentYear + 1).ToString().Substring(2)}";
            // ddlFY.SelectedValue = currentFY;
        }
        public void BindMonthByFY(string selectedFY)
        {
            ddlMonth.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlMonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }
            // Extract years from FY like "2025-26"
            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            // April–December of startYear
            for (int m = 4; m <= 12; m++)
            {
                string monthName = new DateTime(startYear, m, 1).ToString("MMMM");
                ddlMonth.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            // January–March of nextYear
            for (int m = 1; m <= 3; m++)
            {
                string monthName = new DateTime(endYear, m, 1).ToString("MMMM");
                ddlMonth.Items.Add(new ListItem($"{monthName}", m.ToString()));
            }

            //  ddlmonth.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }

        protected void ddlFY_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFY.SelectedValue);
        }
        public void BindDutyRateData()
        {
            SqlParameter[] param = new SqlParameter[]
            {
        new SqlParameter("@Month", ddlMonth.SelectedValue),
        new SqlParameter("@FY", ddlFY.SelectedValue),
        new SqlParameter("@ApproveByDishead", "0"),
        new SqlParameter("@Zone_ID", ddlZone.SelectedValue)
            };

            DataTable dt = db.ExecuteQuery("csmcl_sp_GetDutyEntryApproveStatus_ByZone", param);

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
            clr(lbl_CS_Off_M); clr(lbl_CS_Off_M_HC); clr(lbl_CS_Off_M_Dut); clr(lbl_CS_Off_M_Total);
            clr(lbl_CS_Sh_M); clr(lbl_CS_Sh_M_HC); clr(lbl_CS_Sh_M_Dut); clr(lbl_CS_Sh_M_Total);
            clr(lbl_S_Off_M); clr(lbl_S_Off_M_HC); clr(lbl_S_Off_M_Dut); clr(lbl_S_Off_M_Total);
            clr(lbl_S_Sh_M); clr(lbl_S_Sh_M_HC); clr(lbl_S_Sh_M_Dut); clr(lbl_S_Sh_M_Total);
            clr(lbl_M_Off_M); clr(lbl_M_Off_M_HC); clr(lbl_M_Off_M_Dut); clr(lbl_M_Off_M_Total);
            clr(lbl_M_Sh_M); clr(lbl_M_Sh_M_HC); clr(lbl_M_Sh_M_Dut); clr(lbl_M_Sh_M_Total);

            clr(lbl_CS_Sh_OT); clr(lbl_CS_Sh_OT_HC); clr(lbl_CS_Sh_OT_Dut); clr(lbl_CS_Sh_OT_Total);
            clr(lbl_S_Sh_OT); clr(lbl_S_Sh_OT_HC); clr(lbl_S_Sh_OT_Dut); clr(lbl_S_Sh_OT_Dut_Total);
            clr(lbl_M_Sh_OT); clr(lbl_M_Sh_OT_HC); clr(lbl_M_Sh_OT_Dut); clr(lbl_M_Sh_OT_Total);

            clr(lbl_CS_Off_D); clr(lbl_CS_Off_D_HC); clr(lbl_CS_Off_D_Dut); clr(lbl_CS_Off_D_Total);
            clr(lbl_CS_Sh_D); clr(lbl_CS_Sh_D_HC); clr(lbl_CS_Sh_D_Dut); clr(lbl_CS_Sh_D_Total);
            clr(lbl_S_Off_D); clr(lbl_S_Off_D_HC); clr(lbl_S_Off_D_Dut); clr(lbl_S_Off_D_Total);
            clr(lbl_S_Sh_D); clr(lbl_S_Sh_D_HC); clr(lbl_S_Sh_D_Dut); clr(lbl_S_Sh_D_Total);
            clr(lbl_M_Off_D); clr(lbl_M_Off_D_HC); clr(lbl_M_Off_D_Dut); clr(lbl_M_Off_D_Total);
            clr(lbl_M_Sh_D); clr(lbl_M_Sh_D_HC); clr(lbl_M_Sh_D_Dut); clr(lbl_M_Sh_D_Total);

            // totals placeholders (make sure these labels exist in .aspx or change names)
            if (lblTotalA != null) lblTotalA.Text = "";
            if (lblTotalB != null) lblTotalB.Text = "";
            if (lblTotalC != null) lblTotalC.Text = "";
            if (lblTotalD_AplusBplusC != null) lblTotalD_AplusBplusC.Text = "";
            if (lblESIC != null) lblESIC.Text = "";
            if (lblEPF != null) lblEPF.Text = "";
            if (lblAgencyCharges != null) lblAgencyCharges.Text = "";
            if (lblTotalE != null) lblTotalE.Text = "";
            if (lblCGST != null) lblCGST.Text = "";
            if (lblSGST != null) lblSGST.Text = "";
            if (lblGrandTotal != null) lblGrandTotal.Text = "";
            if (lblTDS != null) lblTDS.Text = "";
            if (lblLessCGST != null) lblLessCGST.Text = "";
            if (lblLessSGST != null) lblLessSGST.Text = "";
            if (lblRoundedTotal != null) lblRoundedTotal.Text = "";

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
                        lineTotal = (amount * duties)/26;
                        totalA += lineTotal;

                        if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Off_M.Text = F(amount);
                            lbl_CS_Off_M_HC.Text = headCount.ToString();
                            lbl_CS_Off_M_Dut.Text = duties.ToString();
                            lbl_CS_Off_M_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_M.Text = F(amount);
                            lbl_CS_Sh_M_HC.Text = headCount.ToString();
                            lbl_CS_Sh_M_Dut.Text = duties.ToString();
                            lbl_CS_Sh_M_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Off_M.Text = F(amount);
                            lbl_S_Off_M_HC.Text = headCount.ToString();
                            lbl_S_Off_M_Dut.Text = duties.ToString();
                            lbl_S_Off_M_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_M.Text = F(amount);
                            lbl_S_Sh_M_HC.Text = headCount.ToString();
                            lbl_S_Sh_M_Dut.Text = duties.ToString();
                            lbl_S_Sh_M_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Off_M.Text = F(amount);
                            lbl_M_Off_M_HC.Text = headCount.ToString();
                            lbl_M_Off_M_Dut.Text = duties.ToString();
                            lbl_M_Off_M_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_M.Text = F(amount);
                            lbl_M_Sh_M_HC.Text = headCount.ToString();
                            lbl_M_Sh_M_Dut.Text = duties.ToString();
                            lbl_M_Sh_M_Total.Text = F(lineTotal);
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
                            lbl_CS_Sh_OT.Text = F(amount);
                            lbl_CS_Sh_OT_HC.Text = headCount.ToString();
                            lbl_CS_Sh_OT_Dut.Text = duties.ToString();
                            lbl_CS_Sh_OT_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_OT.Text = F(amount);
                            lbl_S_Sh_OT_HC.Text = headCount.ToString();
                            lbl_S_Sh_OT_Dut.Text = duties.ToString();
                            lbl_S_Sh_OT_Dut_Total.Text = F(lineTotal); // you used this ID in markup
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_OT.Text = F(amount);
                            lbl_M_Sh_OT_HC.Text = headCount.ToString();
                            lbl_M_Sh_OT_Dut.Text = duties.ToString();
                            lbl_M_Sh_OT_Total.Text = F(lineTotal);
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
                            lbl_CS_Off_D.Text = F(amount);
                            lbl_CS_Off_D_HC.Text = headCount.ToString();
                            lbl_CS_Off_D_Dut.Text = duties.ToString();
                            lbl_CS_Off_D_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("CHIEF SALESMAN", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_CS_Sh_D.Text = F(amount);
                            lbl_CS_Sh_D_HC.Text = headCount.ToString();
                            lbl_CS_Sh_D_Dut.Text = duties.ToString();
                            lbl_CS_Sh_D_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Off_D.Text = F(amount);
                            lbl_S_Off_D_HC.Text = headCount.ToString();
                            lbl_S_Off_D_Dut.Text = duties.ToString();
                            lbl_S_Off_D_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Salesman", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_S_Sh_D.Text = F(amount);
                            lbl_S_Sh_D_HC.Text = headCount.ToString();
                            lbl_S_Sh_D_Dut.Text = duties.ToString();
                            lbl_S_Sh_D_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Office", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Off_D.Text = F(amount);
                            lbl_M_Off_D_HC.Text = headCount.ToString();
                            lbl_M_Off_D_Dut.Text = duties.ToString();
                            lbl_M_Off_D_Total.Text = F(lineTotal);
                        }
                        else if (catNorm.Equals("Multipurpose", StringComparison.OrdinalIgnoreCase) && locNorm.Equals("Shop", StringComparison.OrdinalIgnoreCase))
                        {
                            lbl_M_Sh_D.Text = F(amount);
                            lbl_M_Sh_D_HC.Text = headCount.ToString();
                            lbl_M_Sh_D_Dut.Text = duties.ToString();
                            lbl_M_Sh_D_Total.Text = F(lineTotal);
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
                if (lblTotalA != null) lblTotalA.Text = F(totalA);
                if (lblTotalB != null) lblTotalB.Text = F(totalB);
                if (lblTotalC != null) lblTotalC.Text = F(totalC);

                //// Example downstream calculations (adjust percentages or label IDs as needed)
                decimal D_total = totalA + totalB + totalC; // as per your sheet A + B
                if (lblTotalD_AplusBplusC != null) lblTotalD_AplusBplusC.Text = F(D_total);

                decimal esi = D_total * 0.0325m;
                decimal epf = 3217113 * 0.13m;
                decimal agencyCharges = D_total * 0.09m;

                if (lblESIC != null) lblESIC.Text = F(esi);
                if (lblEPF != null) lblEPF.Text = F(epf);
                if (lblAgencyCharges != null) lblAgencyCharges.Text = F(agencyCharges);

                decimal totalE = D_total + esi + epf + agencyCharges;
                if (lblTotalE != null) lblTotalE.Text = F(totalE);

                decimal cgst = totalE * 0.09m;
                decimal sgst = totalE * 0.09m;
                if (lblCGST != null) lblCGST.Text = F(cgst);
                if (lblSGST != null) lblSGST.Text = F(sgst);

                decimal grandF = totalE + cgst + sgst;
                if (lblGrandTotal != null) lblGrandTotal.Text = F(grandF);

                decimal tds = totalE * 0.001m;
                decimal lessCgst = totalE * 0.01m;
                decimal lessSgst = totalE * 0.01m;

                if (lblTDS != null) lblTDS.Text = F(tds);
                if (lblLessCGST != null) lblLessCGST.Text = F(lessCgst);
                if (lblLessSGST != null) lblLessSGST.Text = F(lessSgst);

                decimal rounded = grandF - (tds + lessCgst + lessSgst);
                if (lblRoundedTotal != null) lblRoundedTotal.Text = F(Math.Round(rounded, 0, MidpointRounding.AwayFromZero));
            }
        }


        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDutyRateData();
        }
    }

}