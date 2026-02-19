<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Async="true"
    CodeBehind="UploadDocument.aspx.cs" Inherits="PlacementAgency.UI.Agency.UploadDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .upload-page {
            background: linear-gradient(180deg, #f6fbff 0%, #ffffff 100%);
            border: 1px solid #d9e9f7;
            border-radius: 16px;
            padding: 1.25rem;
        }

        .upload-card {
            border: 1px solid #d7e7f5;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(19, 66, 109, 0.08);
        }

        .upload-card .card-header {
            background: linear-gradient(90deg, #1f8ef1 0%, #0a65c9 100%);
            color: #fff;
            font-weight: 700;
            border: 0;
            padding: .8rem 1rem;
        }

        .search-group .input-group-text {
            background: #f0f7ff;
            border-color: #cae1f6;
            color: #174a74;
            font-weight: 700;
        }

        .search-group .form-select,
        .doc-row .form-control {
            border-color: #cfe1f3;
        }

        .doc-help {
            border-radius: 12px;
            border: 1px solid #ffe2a6;
            background: #fff9e8;
            color: #6b4a00;
            padding: .85rem 1rem;
            font-weight: 600;
        }

        .doc-row {
            margin-bottom: .85rem;
            padding: .75rem .5rem;
            border-radius: 12px;
            border: 1px solid #dce9f5;
            background: #f9fcff;
            align-items: center;
        }

        .doc-label {
            font-weight: 700;
            color: #153e62;
        }

        .dist-comment {
            display: block;
            min-height: 38px;
            padding: .45rem .6rem;
            background: #ffffff;
            border: 1px dashed #c9def1;
            border-radius: 8px;
            color: #284d6d;
            font-weight: 600;
        }

        .doc-link {
            display: inline-flex;
            margin-top: .4rem;
            font-weight: 700;
            text-decoration: none;
        }

        @media (max-width: 767.98px) {
            .upload-page {
                padding: .8rem;
            }

            .doc-row {
                padding: .75rem;
            }
        }
    </style>

    <div class="upload-page">
        <div class="card upload-card mb-4">
            <div class="card-header">
                <i class="bi bi-funnel-fill me-2"></i>Search Record
            </div>
            <div class="card-body">
                <div class="row g-3 search-group">
                    <div class="col-lg-3 col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-geo-alt-fill me-1"></i>District</span>
                            <asp:DropDownList ID="ddldistrictAgent" runat="server" CssClass="form-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddldistrictAgent_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar-range me-1"></i>FY</span>
                            <asp:DropDownList ID="ddlFYAg" runat="server" CssClass="form-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlFYAg_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar3 me-1"></i>Month</span>
                            <asp:DropDownList ID="ddlMonthAg" runat="server" CssClass="form-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlMonthAg_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6 d-flex align-items-end gap-2">
                        <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-success px-4" />
                        <asp:Button ID="btnclr" runat="server" Text="Clear" CssClass="btn btn-outline-warning px-4" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card upload-card">
            <div class="card-header">
                <i class="bi bi-cloud-upload-fill me-2"></i>Add or Update Document Record
            </div>
            <div class="card-body">
                <div class="doc-help mb-3">
                    1. Allowed formats: PDF, JPEG, JPG, PNG.
                    <br />
                    2. Allowed size range: 100 KB to 2 MB.
                </div>

                <div class="row doc-row">
                    <label class="col-lg-3 col-md-4 col-form-label doc-label">1. EPF</label>
                    <div class="col-lg-3 col-md-8">
                        <asp:FileUpload ID="fuepf" runat="server" CssClass="form-control" />
                        <asp:LinkButton ID="lnkEPF" runat="server" CssClass="doc-link text-primary" Visible="false"
                            OnClick="lnk_Click"></asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:Label ID="lblepfdistcomment" runat="server" CssClass="dist-comment" Text="comment"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:TextBox ID="txtepf" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <div class="row doc-row">
                    <label class="col-lg-3 col-md-4 col-form-label doc-label">2. ESIR</label>
                    <div class="col-lg-3 col-md-8">
                        <asp:FileUpload ID="fuesir" runat="server" CssClass="form-control" />
                        <asp:LinkButton ID="lnkESIR" runat="server" CssClass="doc-link text-primary" Visible="false"
                            OnClick="lnk_Click"></asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:Label ID="lblesirdistcomment" runat="server" CssClass="dist-comment" Text="comment"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:TextBox ID="txtesir" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <div class="row doc-row">
                    <label class="col-lg-3 col-md-4 col-form-label doc-label">3. GST</label>
                    <div class="col-lg-3 col-md-8">
                        <asp:FileUpload ID="fugst" runat="server" CssClass="form-control" />
                        <asp:LinkButton ID="lnkGST" runat="server" CssClass="doc-link text-primary" Visible="false"
                            OnClick="lnk_Click"></asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:Label ID="lblgstdistcomment" runat="server" CssClass="dist-comment" Text="comment"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:TextBox ID="txtgst" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <div class="row doc-row">
                    <label class="col-lg-3 col-md-4 col-form-label doc-label">4. Name of Employees</label>
                    <div class="col-lg-3 col-md-8">
                        <asp:FileUpload ID="fuename" runat="server" CssClass="form-control" />
                        <asp:LinkButton ID="lnkNEmployees" runat="server" CssClass="doc-link text-primary" Visible="false"
                            OnClick="lnk_Click"></asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:Label ID="lblNEmploydistcomment" runat="server" CssClass="dist-comment" Text="comment"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:TextBox ID="txtename" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <div class="row doc-row">
                    <label class="col-lg-3 col-md-4 col-form-label doc-label">5. Employees Salary Payment Certificate</label>
                    <div class="col-lg-3 col-md-8">
                        <asp:FileUpload ID="fuespc" runat="server" CssClass="form-control" />
                        <asp:LinkButton ID="lnkESPC" runat="server" CssClass="doc-link text-primary" Visible="false"
                            OnClick="lnk_Click"></asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:Label ID="lblESPCdistcomment" runat="server" CssClass="dist-comment" Text="comment"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:TextBox ID="txtespc" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <div class="row doc-row">
                    <label class="col-lg-3 col-md-4 col-form-label doc-label">6. SOP</label>
                    <div class="col-lg-3 col-md-8">
                        <asp:FileUpload ID="fusop" runat="server" CssClass="form-control" />
                        <asp:LinkButton ID="lnkSOP" runat="server" CssClass="doc-link text-primary" Visible="false"
                            OnClick="lnk_Click"></asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:Label ID="lblSOPdistcomment" runat="server" CssClass="dist-comment" Text="comment"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <asp:TextBox ID="txtsop" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                    </div>
                </div>

                <div class="mt-3">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-semibold"></asp:Label>
                </div>

                <div class="row mt-4">
                    <div class="col-lg-8 offset-lg-4 d-flex flex-wrap gap-2">
                        <asp:Button ID="btnSubmit" runat="server" Visible="false" CssClass="btn btn-success px-4" Text="Submit"
                            OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnCancel" runat="server" Visible="false" CssClass="btn btn-secondary px-4" Text="Cancel" />
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

                 <iframe id="previewFrame" style="width:100%; height:80vh; display:none;" frameborder="0"></iframe>

                 <img id="previewImage" style="max-width:100%; max-height:80vh; display:none;" />

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
