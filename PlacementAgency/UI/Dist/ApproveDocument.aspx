<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApproveDocument.aspx.cs" Inherits="PlacementAgency.UI.Dist.ApproveDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .approve-shell {
            background: linear-gradient(180deg, #f6fbff 0%, #ffffff 100%);
            border: 1px solid #e2edf8;
            border-radius: 16px;
            padding: 1rem;
        }

        .section-card {
            border: 1px solid #dce9f5;
            border-radius: 14px;
            box-shadow: 0 8px 22px rgba(16, 58, 97, .06);
        }

        .section-header {
            border-bottom: 1px solid #e3eef9;
            background: linear-gradient(90deg, #edf6ff 0%, #f6fbff 100%);
            border-radius: 14px 14px 0 0;
            padding: .8rem 1rem;
        }

        .section-title {
            margin: 0;
            font-size: 1rem;
            font-weight: 700;
            color: #15324d;
        }

        .section-sub {
            margin: .15rem 0 0;
            font-size: .8rem;
            color: #5c758e;
        }

        .filter-label {
            display: block;
            margin-bottom: .35rem;
            font-size: .78rem;
            font-weight: 700;
            color: #3c5975;
            text-transform: uppercase;
            letter-spacing: .04em;
        }

        .doc-table thead th {
            font-size: .77rem;
            letter-spacing: .04em;
            text-transform: uppercase;
            white-space: nowrap;
            color: #425f7c;
            background: #f4f9ff;
        }

        .doc-table tbody td {
            vertical-align: middle;
            font-size: .88rem;
        }

        .doc-name {
            font-weight: 700;
            color: #16324d;
            margin: 0;
        }

        .doc-link {
            font-size: .84rem;
            font-weight: 600;
            word-break: break-all;
            text-decoration: none;
        }

        .comment-chip {
            display: inline-block;
            border: 1px solid #d7e5f3;
            background: #f8fbff;
            border-radius: 8px;
            padding: .38rem .5rem;
            font-size: .8rem;
            color: #526d87;
            min-width: 170px;
        }

        .reject-comment {
            min-height: 42px;
            resize: vertical;
        }

        .status-note {
            font-size: .8rem;
            color: #56728d;
        }

        .preview-frame {
            width: 100%;
            height: 75vh;
            display: none;
            border: 0;
            border-radius: 8px;
        }

        .preview-image {
            max-width: 100%;
            max-height: 75vh;
            display: none;
            border-radius: 8px;
        }

        @media (max-width: 767.98px) {
            .approve-shell {
                padding: .7rem;
            }

            .comment-chip {
                min-width: auto;
                width: 100%;
            }
        }
    </style>

    <div class="approve-shell">
        <div class="card section-card mb-3">
            <div class="section-header">
                <h5 class="section-title"><i class="bi bi-funnel-fill me-2"></i>Search Record</h5>
                <p class="section-sub">Select financial year and month to load uploaded documents.</p>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="filter-label">Financial Year</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar-range"></i></span>
                            <asp:DropDownList ID="ddlFYAg" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFYAg_SelectedIndexChanged" CssClass="form-select"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <label class="filter-label">Month</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar3"></i></span>
                            <asp:DropDownList ID="ddlMonthAg" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonthAg_SelectedIndexChanged" CssClass="form-select"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card section-card">
            <div class="section-header">
                <h5 class="section-title"><i class="bi bi-check2-square me-2"></i>Approve or Reject Documents</h5>
                <p class="section-sub">Review each uploaded file, select action, and add reject comments when needed.</p>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle doc-table mb-0">
                        <thead>
                            <tr>
                                <th style="width: 18%;">Document</th>
                                <th style="width: 26%;">Uploaded File</th>
                                <th style="width: 22%;">Agency Comment</th>
                                <th style="width: 16%;">Action</th>
                                <th style="width: 18%;">Reject Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><p class="doc-name">1. EPF</p></td>
                                <td><asp:LinkButton ID="lnkEPF" runat="server" CssClass="doc-link" OnClick="lnk_Click"></asp:LinkButton></td>
                                <td><asp:Label ID="lblEPFAgComment" runat="server" CssClass="comment-chip" Text="-"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddlEPF" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm" OnSelectedIndexChanged="ddlEPF_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><asp:TextBox ID="txtepf" runat="server" CssClass="form-control form-control-sm reject-comment" Visible="false" TextMode="MultiLine" Placeholder="Reject reason"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><p class="doc-name">2. ESIR</p></td>
                                <td><asp:LinkButton ID="lnkESIR" runat="server" CssClass="doc-link" OnClick="lnk_Click"></asp:LinkButton></td>
                                <td><asp:Label ID="lblESIRAgComment" runat="server" CssClass="comment-chip" Text="-"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddlESIR" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm" OnSelectedIndexChanged="ddlESIR_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><asp:TextBox ID="txtesir" runat="server" CssClass="form-control form-control-sm reject-comment" Visible="false" TextMode="MultiLine" Placeholder="Reject reason"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><p class="doc-name">3. GST</p></td>
                                <td><asp:LinkButton ID="lnkGST" runat="server" CssClass="doc-link" OnClick="lnk_Click"></asp:LinkButton></td>
                                <td><asp:Label ID="lblGSTAgComment" runat="server" CssClass="comment-chip" Text="-"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddlGST" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm" OnSelectedIndexChanged="ddlGST_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><asp:TextBox ID="txtgst" runat="server" CssClass="form-control form-control-sm reject-comment" Visible="false" TextMode="MultiLine" Placeholder="Reject reason"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><p class="doc-name">4. Name of Employees</p></td>
                                <td><asp:LinkButton ID="lnkNEmployees" runat="server" CssClass="doc-link" OnClick="lnk_Click"></asp:LinkButton></td>
                                <td><asp:Label ID="lblNEmployeeAgComment" runat="server" CssClass="comment-chip" Text="-"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddlNEmpoy" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm" OnSelectedIndexChanged="ddlNEmpoy_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><asp:TextBox ID="txtnemply" runat="server" CssClass="form-control form-control-sm reject-comment" Visible="false" TextMode="MultiLine" Placeholder="Reject reason"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><p class="doc-name">5. Employees Salary Payment Certificate</p></td>
                                <td><asp:LinkButton ID="lnkESPC" runat="server" CssClass="doc-link" OnClick="lnk_Click"></asp:LinkButton></td>
                                <td><asp:Label ID="lblESPCAgComment" runat="server" CssClass="comment-chip" Text="-"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddlspcerti" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm" OnSelectedIndexChanged="ddlspcerti_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><asp:TextBox ID="txtespc" runat="server" CssClass="form-control form-control-sm reject-comment" Visible="false" TextMode="MultiLine" Placeholder="Reject reason"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><p class="doc-name">6. SOP</p></td>
                                <td><asp:LinkButton ID="lnkSOP" runat="server" CssClass="doc-link" OnClick="lnk_Click"></asp:LinkButton></td>
                                <td><asp:Label ID="lblSOPAgComment" runat="server" CssClass="comment-chip" Text="-"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddlSOP" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm" OnSelectedIndexChanged="ddlSOP_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><asp:TextBox ID="txtsop" runat="server" CssClass="form-control form-control-sm reject-comment" Visible="false" TextMode="MultiLine" Placeholder="Reject reason"></asp:TextBox></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex flex-wrap justify-content-between align-items-center mt-3 gap-2">
                    <asp:Label ID="lblMessage" runat="server" CssClass="status-note" />
                    <div>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success me-2" Text="Submit" OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-outline-secondary" Text="Cancel" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title"><i class="bi bi-file-earmark-text me-2"></i>Document Preview</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <iframe id="previewFrame" class="preview-frame"></iframe>
                    <img id="previewImage" class="preview-image" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function showPdfPreview(src) {
            document.getElementById("previewImage").style.display = "none";
            document.getElementById("previewFrame").style.display = "block";
            document.getElementById("previewFrame").src = src;
            new bootstrap.Modal(document.getElementById('previewModal')).show();
        }

        function showImagePreview(src) {
            document.getElementById("previewFrame").style.display = "none";
            document.getElementById("previewImage").style.display = "block";
            document.getElementById("previewImage").src = src;
            new bootstrap.Modal(document.getElementById('previewModal')).show();
        }
    </script>
</asp:Content>
