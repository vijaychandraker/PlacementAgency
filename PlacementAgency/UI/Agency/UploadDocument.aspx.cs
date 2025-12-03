using PlacementAgency.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementAgency.UI.Agency
{
    public partial class UploadDocument : Page
    {
        private readonly DatabaseHelper _db = new DatabaseHelper("conn", 60, ex =>
        {
            System.Diagnostics.Debug.WriteLine(ex);
        });

        private static readonly HashSet<string> AllowedExt = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            ".pdf", ".jpg", ".jpeg", ".png"
        };

        private const int MinFileSizeBytes = 100 * 1024;       // 100 KB
        private const int MaxFileSizeBytes = 2 * 1024 * 1024;  // 2 MB

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDistrict();
                BindFY();
                ResetUploadUI();
                SetCommentPlaceholders();
            }
        }

        #region Bind helpers
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
                ddlMonthAg.Items.Add(new ListItem(new DateTime(startYear, m, 1).ToString("MMMM"), m.ToString()));

            for (int m = 1; m <= 3; m++)
                ddlMonthAg.Items.Add(new ListItem(new DateTime(endYear, m, 1).ToString("MMMM"), m.ToString()));
        }

        public void BindDistrict()
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Agency_ID", "AG1")
           };

            DataTable dtct = _db.ExecuteQuery("csmcl_sp_GetDistrictByAgency", param);
            ddldistrictAgent.DataSource = dtct;
            ddldistrictAgent.DataTextField = "District_Name";
            ddldistrictAgent.DataValueField = "District_ID";
            ddldistrictAgent.DataBind();

            ddldistrictAgent.Items.Insert(0, new ListItem("-- Select District --", ""));
        }
        #endregion

        #region Dropdown change handlers -> try load existing
        protected void ddlFYAg_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMonthByFY(ddlFYAg.SelectedValue);
            ClearAllComments();
            TryLoadExisting();
        }

        protected void ddlMonthAg_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearAllComments();
            TryLoadExisting();
        }

        protected void ddldistrictAgent_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearAllComments();
            TryLoadExisting();
        }

        private void TryLoadExisting()
        {
            if (string.IsNullOrEmpty(ddldistrictAgent.SelectedValue) ||
                string.IsNullOrEmpty(ddlFYAg.SelectedValue) ||
                string.IsNullOrEmpty(ddlMonthAg.SelectedValue))
            {
                ResetUploadUI();
                return;
            }

            if (!int.TryParse(ddldistrictAgent.SelectedValue, out int districtId))
            {
                ResetUploadUI();
                return;
            }

            string fy = ddlFYAg.SelectedValue;
            string month = ddlMonthAg.SelectedValue;

            var dt = GetExistingDocuments(districtId, fy, month);
            ApplyExistingStateToUI(dt);
        }
        #endregion

        #region Get & Apply existing state (with status badges)
        private DataTable GetExistingDocuments(int districtId, string fy, string month)
        {
            var dt = _db.ExecuteQuery("usp_GetDocumentsByFilters", new[]
            {
                DatabaseHelper.Param("@District_ID", districtId),
                DatabaseHelper.Param("@FY", fy),
                DatabaseHelper.Param("@Month", month)
            });
            return dt;
        }

        private void ApplyExistingStateToUI(DataTable dt)
        {
            var map = new Dictionary<string, DataRow>(StringComparer.OrdinalIgnoreCase);
            foreach (DataRow r in dt.Rows)
            {
                var name = r["D_name"]?.ToString();
                if (!string.IsNullOrEmpty(name) && !map.ContainsKey(name))
                    map[name] = r;
            }

            // helper to set status label HTML (Bootstrap badges)
            string StatusHtml(int approve, string distComment)
            {
                switch (approve)
                {
                    case 1:
                        return $"<span class='badge bg-success'>Approved</span>";
                    case 2:
                        // include district comment (escape minimal)
                        string safe = string.IsNullOrEmpty(distComment) ? "" : System.Net.WebUtility.HtmlEncode(distComment);
                        return $"<span class='badge bg-danger'>Rejected</span>&nbsp;<small class='text-danger'>{safe}</small>";
                    default:
                        return $"<span class='badge bg-warning text-dark'>Pending</span>";
                }
            }

            void SetState(string docName, FileUpload fu, LinkButton link, TextBox commentBox, Label statusLabel)
            {
                if (map.TryGetValue(docName, out DataRow row))
                {
                    int approve = row["ApproveByDistrict"] == DBNull.Value ? 0 : Convert.ToInt32(row["ApproveByDistrict"]);
                    string distComment = row["Dist_Comment"] == DBNull.Value ? "" : row["Dist_Comment"].ToString();
                    string filename = row["Filename"] == DBNull.Value ? "" : row["Filename"].ToString();
                    string id = row["ID"]?.ToString() ?? "";

                    // set status label HTML (same as you used before)
                    statusLabel.Text = (approve == 1)
                        ? "<span class='badge bg-success'>Approved</span>"
                        : (approve == 2)
                            ? $"<span class='badge bg-danger'>Rejected</span>&nbsp;<small class='text-danger'>{System.Net.WebUtility.HtmlEncode(distComment)}</small>"
                            : "<span class='badge bg-warning text-dark'>Pending</span>";

                    if (approve == 1)
                    {
                        // APPROVED: show link only, hide everything else
                        link.Visible = true;
                        link.Text = string.IsNullOrEmpty(filename) ? "View File" : filename;
                        link.CommandArgument = id;

                        fu.Visible = false;
                        fu.Enabled = false;

                        commentBox.Visible = false;
                    }

                    else if (approve == 2)
                    {
                        // REJECTED -> allow re-upload, show district comment in commentBox
                        link.Visible = false;

                        fu.Visible = true;
                        fu.Enabled = true;

                        commentBox.Visible = true;
                       // commentBox.Text = string.Empty; // show district reason so agency can fix
                    }
                    else
                    {
                        // PENDING -> allow upload and show any agency comment
                        link.Visible = false;

                        fu.Visible = true;
                        fu.Enabled = true;

                        commentBox.Visible = true;
                        commentBox.Text = row["Comment"] == DBNull.Value ? string.Empty : row["Comment"].ToString();
                    }
                }
                else
                {
                    // No record
                    statusLabel.Text = "<span class='badge bg-secondary'>No Record</span>";
                    link.Visible = false;

                    fu.Visible = true;
                    fu.Enabled = true;

                    commentBox.Visible = true;

                    // FULL CLEAR
                    commentBox.Text = string.Empty;
                    commentBox.Attributes["placeholder"] = string.Empty;
                }

            }


            // call for each document, passing the status label controls you added in markup
            SetState("EPF", fuepf, lnkEPF, txtepf, lblepfdistcomment);
            SetState("ESIR", fuesir, lnkESIR, txtesir, lblesirdistcomment);
            SetState("GST", fugst, lnkGST, txtgst, lblgstdistcomment);
            SetState("Name of Employees", fuename, lnkNEmployees, txtename, lblNEmploydistcomment);
            SetState("Employees Salary Payment Certificate", fuespc, lnkESPC, txtespc, lblESPCdistcomment);
            SetState("SOP", fusop, lnkSOP, txtsop, lblSOPdistcomment);
        }

        private void ResetUploadUI()
        {
            // default labels and UI
            lblepfdistcomment.Text = "";
            lblesirdistcomment.Text = "";
            lblgstdistcomment.Text = "";
            lblNEmploydistcomment.Text = "";
            lblESPCdistcomment.Text = "";
            lblSOPdistcomment.Text = "";

            lnkEPF.Visible = false; fuepf.Visible = true; fuepf.Enabled = true; txtepf.Visible = true; txtepf.Text = "";
            lnkESIR.Visible = false; fuesir.Visible = true; fuesir.Enabled = true; txtesir.Visible = true; txtesir.Text = "";
            lnkGST.Visible = false; fugst.Visible = true; fugst.Enabled = true; txtgst.Visible = true; txtgst.Text = "";
            lnkNEmployees.Visible = false; fuename.Visible = true; fuename.Enabled = true; txtename.Visible = true; txtename.Text = "";
            lnkESPC.Visible = false; fuespc.Visible = true; fuespc.Enabled = true; txtespc.Visible = true; txtespc.Text = "";
            lnkSOP.Visible = false; fusop.Visible = true; fusop.Enabled = true; txtsop.Visible = true; txtsop.Text = "";
            SetCommentPlaceholders();
        }
        #endregion

        #region preview/download existing file
        protected void lnk_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            if (!string.IsNullOrEmpty(btn.CommandArgument))
                DownloadFile(Convert.ToInt32(btn.CommandArgument));
        }

        private void DownloadFile(int docId)
        {
            var dt = _db.ExecuteQuery("csmcl_GetDocumentFile", new[]
            {
                DatabaseHelper.Param("@ID", docId)
            });

            if (dt.Rows.Count == 0)
                return;

            var row = dt.Rows[0];
            string filename = row["Filename"].ToString();
            string ext = row["D_type"].ToString().ToLower();
            byte[] fileBytes = (byte[])row["D_file"];

            Response.Clear();
            Response.ContentType = GetContentType(ext);
            Response.AddHeader("Content-Disposition", $"inline; filename=\"{filename}\"");
            Response.BinaryWrite(fileBytes);
            Response.End();
        }

        private string GetContentType(string ext)
        {
            switch (ext)
            {
                case "pdf": return "application/pdf";
                case "jpg":
                case "jpeg": return "image/jpeg";
                case "png": return "image/png";
                default: return "application/octet-stream";
            }
        }
        #endregion

        #region submit (async)
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.RegisterAsyncTask(new PageAsyncTask(SubmitAsync));
        }

        private async Task SubmitAsync()
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = string.Empty;

            var items = new List<UploadItem>
            {
                new UploadItem { FileUpload = fuepf, DocName = "EPF", CommentControl = txtepf },
                new UploadItem { FileUpload = fuesir, DocName = "ESIR", CommentControl = txtesir },
                new UploadItem { FileUpload = fugst, DocName = "GST", CommentControl = txtgst },
                new UploadItem { FileUpload = fuename, DocName = "Name of Employees", CommentControl = txtename },
                new UploadItem { FileUpload = fuespc, DocName = "Employees Salary Payment Certificate", CommentControl = txtespc },
                new UploadItem { FileUpload = fusop, DocName = "SOP", CommentControl = txtsop }
            };

            bool anyAction = false;
            foreach (var it in items) { if (it.FileUpload.HasFile) { anyAction = true; break; } }
            if (!anyAction)
            {
                lblMessage.Text = "No files selected for upload. Select file(s) to upload or re-upload rejected documents.";
                return;
            }

            string uploadedBy = (Session["UserName"] as string) ?? (User?.Identity?.Name) ?? "anonymous";
            DateTime uploadedAt = DateTime.Now;
            int districtId = 0;
            int.TryParse(ddldistrictAgent.SelectedValue ?? "0", out districtId);
            string fy = ddlFYAg.SelectedValue;
            string month = ddlMonthAg.SelectedValue;
            string agencyId = (Session["AgencyID"] as string) ?? "AG1";
            string zoneId = (Session["ZoneID"] as string) ?? "Z1";

            var insertedIds = new List<long>();
            var sbErrors = new StringBuilder();

            var existingDt = GetExistingDocuments(districtId, fy, month);
            var existingMap = new Dictionary<string, DataRow>(StringComparer.OrdinalIgnoreCase);
            foreach (DataRow r in existingDt.Rows) existingMap[r["D_name"].ToString()] = r;

            try
            {
                await _db.ExecuteTransactionAsync(async (conn, tran) =>
                {
                    foreach (var it in items)
                    {
                        string docName = it.DocName;

                        if (!it.FileUpload.HasFile) continue;

                        var posted = it.FileUpload.PostedFile;
                        string filename = Path.GetFileName(posted.FileName);
                        string ext = Path.GetExtension(filename ?? "").ToLowerInvariant();

                        if (!AllowedExt.Contains(ext))
                        {
                            sbErrors.AppendLine($"{docName}: '{filename}' has invalid file type.");
                            continue;
                        }
                        if (posted.ContentLength < MinFileSizeBytes)
                        {
                            sbErrors.AppendLine($"{docName}: '{filename}' must be at least {MinFileSizeBytes / 1024} KB.");
                            continue;
                        }
                        if (posted.ContentLength > MaxFileSizeBytes)
                        {
                            sbErrors.AppendLine($"{docName}: '{filename}' must be <= {MaxFileSizeBytes / (1024 * 1024)} MB.");
                            continue;
                        }

                        byte[] bytes;
                        using (var ms = new MemoryStream())
                        {
                            await posted.InputStream.CopyToAsync(ms);
                            bytes = ms.ToArray();
                        }
                        long fileSize = bytes.LongLength;
                        string agencyComment = (it.CommentControl?.Text ?? string.Empty).Trim();

                        if (existingMap.TryGetValue(docName, out DataRow existingRow))
                        {
                            int approve = existingRow["ApproveByDistrict"] == DBNull.Value ? 0 : Convert.ToInt32(existingRow["ApproveByDistrict"]);
                            int existingId = Convert.ToInt32(existingRow["ID"]);

                            if (approve == 1)
                            {
                                sbErrors.AppendLine($"{docName}: already approved; upload skipped.");
                                continue;
                            }

                            // update existing
                            using (var cmd = new SqlCommand("usp_UpdateDocumentFile", conn, tran))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.CommandTimeout = 60;

                                cmd.Parameters.Add(DatabaseHelper.Param("@ID", existingId, SqlDbType.Int));
                                cmd.Parameters.Add(DatabaseHelper.Param("@D_type", ext.TrimStart('.'), SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@file_size", fileSize, SqlDbType.BigInt));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Filename", filename, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@D_file", bytes, SqlDbType.VarBinary));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Comment", string.IsNullOrEmpty(agencyComment) ? (object)DBNull.Value : agencyComment, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@uploaded_by", uploadedBy, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@uploaded_at", uploadedAt, SqlDbType.DateTime2));
                                cmd.Parameters.Add(DatabaseHelper.Param("@ApproveByDistrict", 0, SqlDbType.Int)); // reset to pending
                                cmd.Parameters.Add(DatabaseHelper.Param("@Dist_Comment", DBNull.Value, SqlDbType.VarChar));

                                cmd.ExecuteNonQuery();
                                insertedIds.Add(existingId);
                            }
                        }
                        else
                        {
                            // insert new
                            using (var cmd = new SqlCommand("usp_InsertDocument", conn, tran))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.CommandTimeout = 60;

                                cmd.Parameters.Add(DatabaseHelper.Param("@D_name", docName, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@D_type", ext.TrimStart('.'), SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@file_size", fileSize, SqlDbType.BigInt));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Filename", filename, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@D_file", bytes, SqlDbType.VarBinary));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Comment", string.IsNullOrEmpty(agencyComment) ? (object)DBNull.Value : agencyComment, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@uploaded_by", uploadedBy, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@uploaded_at", uploadedAt, SqlDbType.DateTime2));
                                cmd.Parameters.Add(DatabaseHelper.Param("@District_ID", districtId, SqlDbType.Int));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Agency_ID", agencyId, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Zone_ID", zoneId, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Month", month, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@FY", fy, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@ApproveByDistrict", 0, SqlDbType.Int));
                                cmd.Parameters.Add(DatabaseHelper.Param("@Dist_Comment", DBNull.Value, SqlDbType.VarChar));
                                cmd.Parameters.Add(DatabaseHelper.Param("@ApproveByState", 0, SqlDbType.Int));
                                cmd.Parameters.Add(DatabaseHelper.Param("@State_Comment", DBNull.Value, SqlDbType.VarChar));

                                using (var reader = await cmd.ExecuteReaderAsync())
                                {
                                    if (reader != null && reader.HasRows)
                                    {
                                        if (await reader.ReadAsync())
                                        {
                                            object idObj = null;
                                            try
                                            {
                                                int idx = -1;
                                                try { idx = reader.GetOrdinal("NewId"); } catch { idx = -1; }
                                                idObj = idx >= 0 ? reader.GetValue(idx) : reader.GetValue(0);
                                            }
                                            catch { idObj = null; }

                                            if (idObj != null && idObj != DBNull.Value)
                                            {
                                                if (long.TryParse(idObj.ToString(), out long newid))
                                                    insertedIds.Add(newid);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } // foreach

                    if (sbErrors.Length > 0 && insertedIds.Count == 0)
                        throw new ApplicationException("No files were uploaded. See details: " + sbErrors.ToString());
                });

                // result message
                if (insertedIds.Count > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    var sb = new StringBuilder();
                    sb.Append("Uploaded/Updated successfully. IDs: ");
                    sb.Append(string.Join(", ", insertedIds));
                    if (sbErrors.Length > 0)
                    {
                        sb.Append("<br/>Warnings:<br/>");
                        sb.Append(sbErrors.ToString().Replace(Environment.NewLine, "<br/>"));
                    }
                    lblMessage.Text = sb.ToString();
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "No files were uploaded. " + sbErrors.ToString().Replace(Environment.NewLine, "<br/>");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error uploading files: " + ex.Message;
            }
            finally
            {
                // reload to reflect status changes
                TryLoadExisting();
            }
        }
        #endregion

        private class UploadItem
        {
            public FileUpload FileUpload { get; set; }
            public string DocName { get; set; }
            public TextBox CommentControl { get; set; }
        }
        private void SetCommentPlaceholders()
{
    txtepf.Attributes["placeholder"] = "Comment";
    txtesir.Attributes["placeholder"] = "Comment";
    txtgst.Attributes["placeholder"] = "Comment";
    txtename.Attributes["placeholder"] = "Comment";
    txtespc.Attributes["placeholder"] = "Comment";
    txtsop.Attributes["placeholder"] = "Comment";
}
        private void ClearAllComments()
        {
            txtepf.Text = "";
            txtesir.Text = "";
            txtgst.Text = "";
            txtename.Text = "";
            txtespc.Text = "";
            txtsop.Text = "";

            // Ensure placeholders are visible for upload states
            SetCommentPlaceholders();
        }
    }
}
