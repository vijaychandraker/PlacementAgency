using PlacementAgency.Helpers;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Dist
{
    public partial class ApproveDocument : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFY();
            }
        }

        // ------------------ FY BINDING ------------------

        public void BindFY()
        {
            ddlFYAg.Items.Clear();

            DateTime now = DateTime.Now;
            int currentYear = now.Month >= 4 ? now.Year : now.Year - 1;

            for (int year = currentYear - 2; year <= currentYear; year++)
            {
                string fy = $"{year}-{(year + 1).ToString().Substring(2)}";
                ddlFYAg.Items.Add(new ListItem(fy, fy));
            }

            ddlFYAg.Items.Insert(0, new ListItem("-- Select Financial Year --", ""));
            ddlMonthAg.Items.Insert(0, new ListItem("-- Select Month --", ""));
        }

        public void BindMonthByFY(string selectedFY)
        {
            ddlMonthAg.Items.Clear();

            if (string.IsNullOrEmpty(selectedFY))
            {
                ddlMonthAg.Items.Insert(0, new ListItem("-- Select Month --", ""));
                return;
            }

            int startYear = int.Parse(selectedFY.Substring(0, 4));
            int endYear = startYear + 1;

            for (int m = 4; m <= 12; m++)
            {
                ddlMonthAg.Items.Add(new ListItem(
                    new DateTime(startYear, m, 1).ToString("MMMM"),
                    m.ToString()
                ));
            }

            for (int m = 1; m <= 3; m++)
            {
                ddlMonthAg.Items.Add(new ListItem(
                    new DateTime(endYear, m, 1).ToString("MMMM"),
                    m.ToString()
                ));
            }
        }

        protected void ddlFYAg_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFYAg.SelectedValue);
        }

        protected void ddlMonthAg_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadDocuments();
        }

        // ------------------ LOAD DOCUMENTS ------------------

        private void LoadDocuments()
        {
            if (string.IsNullOrEmpty(ddlFYAg.SelectedValue) ||
                string.IsNullOrEmpty(ddlMonthAg.SelectedValue))
                return;

            int districtId = 101; // TEMP — replace with Session["DistrictID"]

            var dt = db.ExecuteQuery("usp_GetDocumentsByFilters", new[]
            {
                DatabaseHelper.Param("@District_ID", districtId),
                DatabaseHelper.Param("@FY", ddlFYAg.SelectedValue),
                DatabaseHelper.Param("@Month", ddlMonthAg.SelectedValue)
            });

            ResetLinks();

            foreach (DataRow row in dt.Rows)
            {
                string doc = row["D_name"].ToString();
                string file = row["Filename"].ToString();
                string id = row["ID"].ToString();

                // *** NEW: load Comment safely ***
                string agencyComment = "";
                if (dt.Columns.Contains("Comment") && row["Comment"] != DBNull.Value)
                    agencyComment = row["Comment"].ToString();

                switch (doc)
                {
                    case "EPF":
                        SetLink(lnkEPF, file, id);
                        lblEPFAgComment.Text = string.IsNullOrWhiteSpace(agencyComment) ? "-" : agencyComment;
                        break;

                    case "ESIR":
                        SetLink(lnkESIR, file, id);
                        lblESIRAgComment.Text = string.IsNullOrWhiteSpace(agencyComment) ? "-" : agencyComment;
                        break;

                    case "GST":
                        SetLink(lnkGST, file, id);
                        lblGSTAgComment.Text = string.IsNullOrWhiteSpace(agencyComment) ? "-" : agencyComment;
                        break;

                    case "Name of Employees":
                        SetLink(lnkNEmployees, file, id);
                        lblNEmployeeAgComment.Text = string.IsNullOrWhiteSpace(agencyComment) ? "-" : agencyComment;
                        break;

                    case "Employees Salary Payment Certificate":
                        SetLink(lnkESPC, file, id);
                        lblESPCAgComment.Text = string.IsNullOrWhiteSpace(agencyComment) ? "-" : agencyComment;
                        break;

                    case "SOP":
                        SetLink(lnkSOP, file, id);
                        lblSOPAgComment.Text = string.IsNullOrWhiteSpace(agencyComment) ? "-" : agencyComment;
                        break;
                }
            }
        }

        private void ResetLinks()
        {
            lnkEPF.Text = "No Document Found"; lnkEPF.CommandArgument = ""; lblEPFAgComment.Text = "-";
            lnkESIR.Text = "No Document Found"; lnkESIR.CommandArgument = ""; lblESIRAgComment.Text = "-";
            lnkGST.Text = "No Document Found"; lnkGST.CommandArgument = ""; lblGSTAgComment.Text = "-";
            lnkNEmployees.Text = "No Document Found"; lnkNEmployees.CommandArgument = ""; lblNEmployeeAgComment.Text = "-";
            lnkESPC.Text = "No Document Found"; lnkESPC.CommandArgument = ""; lblESPCAgComment.Text = "-";
            lnkSOP.Text = "No Document Found"; lnkSOP.CommandArgument = ""; lblSOPAgComment.Text = "-";
        }

        private void SetLink(LinkButton link, string fileName, string docId)
        {
            link.Text = fileName;
            link.CommandArgument = docId;
        }

        // ------------------ REJECT COMMENT VISIBILITY ------------------

        protected void ddlEPF_SelectedIndexChanged(object sender, EventArgs e)
        { txtepf.Visible = ddlEPF.SelectedValue == "Reject"; }

        protected void ddlESIR_SelectedIndexChanged(object sender, EventArgs e)
        { txtesir.Visible = ddlESIR.SelectedValue == "Reject"; }

        protected void ddlGST_SelectedIndexChanged(object sender, EventArgs e)
        { txtgst.Visible = ddlGST.SelectedValue == "Reject"; }

        protected void ddlNEmpoy_SelectedIndexChanged(object sender, EventArgs e)
        { txtnemply.Visible = ddlNEmpoy.SelectedValue == "Reject"; }

        protected void ddlspcerti_SelectedIndexChanged(object sender, EventArgs e)
        { txtespc.Visible = ddlspcerti.SelectedValue == "Reject"; }

        protected void ddlSOP_SelectedIndexChanged(object sender, EventArgs e)
        { txtsop.Visible = ddlSOP.SelectedValue == "Reject"; }

        // ------------------ PREVIEW DOCUMENT ------------------

        protected void lnk_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;

            if (!string.IsNullOrEmpty(btn.CommandArgument))
            {
                PreviewDocument(Convert.ToInt32(btn.CommandArgument));
            }
        }

        private void PreviewDocument(int docId)
        {
            var dt = db.ExecuteQuery("csmcl_GetDocumentFile", new[]
            {
                DatabaseHelper.Param("@ID", docId)
            });

            if (dt.Rows.Count == 0)
                return;

            var row = dt.Rows[0];
            string filename = row["Filename"].ToString();
            string ext = row["D_type"].ToString().ToLower();
            byte[] fileBytes = (byte[])row["D_file"];

            string base64 = Convert.ToBase64String(fileBytes);

            if (ext == "pdf")
            {
                string src = "data:application/pdf;base64," + base64;
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "Preview", $"showPdfPreview('{src}');", true);
            }
            else if (ext == "jpg" || ext == "jpeg" || ext == "png")
            {
                string src = $"data:image/{ext};base64,{base64}";
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "Preview", $"showImagePreview('{src}');", true);
            }
        }

        // ------------------ SUBMIT APPROVALS ------------------

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            {
                var items = new[]
                {
                    new { DocId = lnkEPF.CommandArgument, Action = ddlEPF.SelectedValue, Comment = txtepf.Text },
                    new { DocId = lnkESIR.CommandArgument, Action = ddlESIR.SelectedValue, Comment = txtesir.Text },
                    new { DocId = lnkGST.CommandArgument, Action = ddlGST.SelectedValue, Comment = txtgst.Text },
                    new { DocId = lnkNEmployees.CommandArgument, Action = ddlNEmpoy.SelectedValue, Comment = txtnemply.Text },
                    new { DocId = lnkESPC.CommandArgument, Action = ddlspcerti.SelectedValue, Comment = txtespc.Text },
                    new { DocId = lnkSOP.CommandArgument, Action = ddlSOP.SelectedValue, Comment = txtsop.Text }
                };

                bool anyToProcess = false;
                foreach (var it in items)
                {
                    if (!string.IsNullOrEmpty(it.DocId) && !string.IsNullOrEmpty(it.Action))
                    {
                        anyToProcess = true;
                        break;
                    }
                }

                if (!anyToProcess)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "No changes to submit. Select Accept or Reject for documents.";
                    return;
                }

                string connStr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (var tran = conn.BeginTransaction())
                    {
                        try
                        {
                            foreach (var it in items)
                            {
                                if (string.IsNullOrEmpty(it.DocId) || string.IsNullOrEmpty(it.Action))
                                    continue;

                                int id = Convert.ToInt32(it.DocId);

                                if (it.Action.Equals("Accept", StringComparison.OrdinalIgnoreCase))
                                {
                                    using (var cmd = new SqlCommand("csmcl_sp_ApproveDocument", conn, tran))
                                    {
                                        cmd.CommandType = CommandType.StoredProcedure;
                                        cmd.Parameters.AddWithValue("@ID", id);
                                        cmd.ExecuteNonQuery();
                                    }
                                }
                                else if (it.Action.Equals("Reject", StringComparison.OrdinalIgnoreCase))
                                {
                                    using (var cmd = new SqlCommand("csmcl_sp_RejectDocument", conn, tran))
                                    {
                                        cmd.CommandType = CommandType.StoredProcedure;
                                        cmd.Parameters.AddWithValue("@ID", id);
                                        string comment = it.Comment ?? string.Empty;
                                        cmd.Parameters.AddWithValue("@Dist_Comment", comment);
                                        cmd.ExecuteNonQuery();
                                    }
                                }
                            }

                            tran.Commit();

                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Text = "Approvals updated successfully.";
                            LoadDocuments();
                        }
                        catch (Exception ex)
                        {
                            try { tran.Rollback(); } catch { }

                            System.Diagnostics.Debug.WriteLine(ex);

                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "Error saving approvals: " + ex.Message;
                        }
                    }
                }
            }
        }
    }
}
