<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApproveDocument.aspx.cs" Inherits="PlacementAgency.UI.Dist.ApproveDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card">
        <div class="card-header alert alert-success">
            Search Record
        </div>
        <div class="card-body">
            <div class="container text-center">
                <div class="row g-3">

                    <!-- FY -->
                    <div class="col-md-4">
                        <div class="input-group mb-3">
                            <label class="input-group-text">
                                <i class="bi bi-calendar-range"></i>&nbsp; FY
                            </label>
                            <asp:DropDownList ID="ddlFYAg" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFYAg_SelectedIndexChanged" CssClass="form-select"></asp:DropDownList>
                        </div>
                    </div>

                    <!-- Month -->
                    <div class="col-md-4">
                        <div class="input-group mb-3">
                            <label class="input-group-text">
                                <i class="bi bi-calendar3"></i>&nbsp; Month
                            </label>
                            <asp:DropDownList ID="ddlMonthAg" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlMonthAg_SelectedIndexChanged"
                                CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <br />
    <br />

    <div class="card">
        <div class="card-header alert alert-warning">
            Approve/Reject Documents
        </div>

        <div class="card-body">
            <div class="container">

                <!-- Row 1 - EPF -->
                <div class="row mb-3 align-items-center alert alert-secondary">
                    <label class="col-md-3 col-form-label">1. EPF</label>

                    <div class="col-md-3">
                        <asp:LinkButton ID="lnkEPF" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                        <asp:Label ID="lblEPFAgComment" runat="server" Text="Comment"></asp:Label>
                    </div>

                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlEPF" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlEPF_SelectedIndexChanged">
                            <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                            <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <asp:TextBox ID="txtepf" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 2 - ESIR -->
                <div class="row mb-3 align-items-center alert alert-secondary">
                    <label class="col-md-3 col-form-label">2. ESIR</label>

                    <div class="col-md-3">
                        <asp:LinkButton ID="lnkESIR" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                        <asp:Label ID="lblESIRAgComment" runat="server" Text="Comment"></asp:Label>
                    </div>

                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlESIR" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlESIR_SelectedIndexChanged">
                            <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                            <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <asp:TextBox ID="txtesir" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 3 - GST -->
                <div class="row mb-3 align-items-center alert alert-secondary">
                    <label class="col-md-3 col-form-label">3. GST</label>

                    <div class="col-md-3">
                        <asp:LinkButton ID="lnkGST" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                        <asp:Label ID="lblGSTAgComment" runat="server" Text="Comment"></asp:Label>
                    </div>

                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlGST" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlGST_SelectedIndexChanged">
                            <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                            <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <asp:TextBox ID="txtgst" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 4 - Name of Employees -->
                <div class="row mb-3 align-items-center alert alert-secondary">
                    <label class="col-md-3 col-form-label">4. Name of Employees</label>

                    <div class="col-md-3">
                        <asp:LinkButton ID="lnkNEmployees" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                        <asp:Label ID="lblNEmployeeAgComment" runat="server" Text="Comment"></asp:Label>
                    </div>

                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlNEmpoy" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlNEmpoy_SelectedIndexChanged">
                            <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                            <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <asp:TextBox ID="txtnemply" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 5 - Salary Payment Cert -->
                <div class="row mb-3 align-items-center alert alert-secondary">
                    <label class="col-md-3 col-form-label">5. Employees Salary Payment Certificate</label>

                    <div class="col-md-3">
                        <asp:LinkButton ID="lnkESPC" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                        <asp:Label ID="lblESPCAgComment" runat="server" Text="Comment"></asp:Label>
                    </div>

                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlspcerti" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlspcerti_SelectedIndexChanged">
                            <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                            <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <asp:TextBox ID="txtespc" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 6 - SOP -->
                <div class="row mb-3 align-items-center alert alert-secondary">
                    <label class="col-md-3 col-form-label">6. SOP</label>



                    <div class="col-md-3">
                        <asp:LinkButton ID="lnkSOP" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                        <asp:Label ID="lblSOPAgComment" runat="server" Text="Comment"></asp:Label>
                    </div>

                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlSOP" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlSOP_SelectedIndexChanged">
                            <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
                            <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <asp:TextBox ID="txtsop" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                    </div>
                </div>
                <asp:Label ID="lblMessage" runat="server" />
                <!-- Buttons -->
                <div class="row mt-4">
                    <div class="col-12 text-end">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success me-2" Text="Submit" OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- File Preview Modal -->
    <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Document Preview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body text-center">

                    <iframe id="previewFrame" style="width: 100%; height: 80vh; display: none;" frameborder="0"></iframe>

                    <img id="previewImage" style="max-width: 100%; max-height: 80vh; display: none;" />

                </div>

            </div>
        </div>
    </div>

    <script>
        function showPdfPreview(src) {
            document.getElementById("previewImage").style.display = "none";
            document.getElementById("previewFrame").style.display = "block";
            document.getElementById("previewFrame").src = src;

            var modal = new bootstrap.Modal(document.getElementById('previewModal'));
            modal.show();
        }

        function showImagePreview(src) {
            document.getElementById("previewFrame").style.display = "none";
            document.getElementById("previewImage").style.display = "block";
            document.getElementById("previewImage").src = src;

            var modal = new bootstrap.Modal(document.getElementById('previewModal'));
            modal.show();
        }
    </script>

</asp:Content>
