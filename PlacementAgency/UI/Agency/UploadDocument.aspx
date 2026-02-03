<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Async="true"
    CodeBehind="UploadDocument.aspx.cs" Inherits="PlacementAgency.UI.Agency.UploadDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Bootstrap CSS (usually in <head>) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<!-- Bootstrap JS bundle (includes Popper) - MUST be before your modal JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<div class="card">
<div class="card-header alert alert-success">Search Record</div>
<div class="card-body">
<div class="container text-center">
<div class="row g-3">

    <!-- District -->
    <div class="col-md-3">
        <div class="input-group">
            <span class="input-group-text"><i class="bi bi-geo-alt-fill"></i>&nbsp; District</span>
            <asp:DropDownList ID="ddldistrictAgent" runat="server" CssClass="form-select" 
                AutoPostBack="true" OnSelectedIndexChanged="ddldistrictAgent_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>

    <!-- FY -->
    <div class="col-md-3">
        <div class="input-group">
            <span class="input-group-text"><i class="bi bi-calendar-range"></i>&nbsp; FY</span>
            <asp:DropDownList ID="ddlFYAg" runat="server" CssClass="form-select"
                AutoPostBack="true" OnSelectedIndexChanged="ddlFYAg_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>

    <!-- Month -->
    <div class="col-md-3">
        <div class="input-group">
            <span class="input-group-text"><i class="bi bi-calendar3"></i>&nbsp; Month</span>
            <asp:DropDownList ID="ddlMonthAg" runat="server" CssClass="form-select"
                AutoPostBack="true" OnSelectedIndexChanged="ddlMonthAg_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>

    <!-- Button -->
    <div class="col-md-3 d-flex align-items-end">
        <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-success" />
        &nbsp;
        <asp:Button ID="btnclr" runat="server" Text="Clear" CssClass="btn btn-warning" />
    </div>

</div>
</div>
</div>
</div>

<br /><br />

<div class="card">
<div class="card-header">Add/Update New Record</div>
<div class="card-body">
<div class="container">

<div class="row mb-3">
<div class="alert alert-warning" role="alert">
<h4 class="alert-heading">Alert!</h4>
<p>1. Only PDF, JPEG, JPG, or PNG files are allowed.<br />2. Minimum file size must be 100 KB, Max 2 MB.</p>
</div>
</div>

<!-- Row Template Applied to All 6 Docs -->

<!-- 1. EPF -->
<div class="row mb-3 alert alert-secondary">
<label class="col-md-3 col-form-label">1. EPF</label>

<div class="col-md-3">
    <asp:FileUpload ID="fuepf" runat="server" CssClass="form-control" />
    <asp:LinkButton ID="lnkEPF" runat="server" CssClass="text-primary" Visible="false"
        OnClick="lnk_Click"></asp:LinkButton>
</div>

<div class="col-md-3">
     <asp:label ID="lblepfdistcomment" runat="server" Text="comment"></asp:label>
   
</div>
    <div class="col-md-3">
    <asp:TextBox ID="txtepf" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
</div>
</div>

<!-- 2. ESIR -->
<div class="row mb-3 alert alert-secondary">
<label class="col-md-3 col-form-label">2. ESIR</label>

<div class="col-md-3">
    <asp:FileUpload ID="fuesir" runat="server" CssClass="form-control" />
    <asp:LinkButton ID="lnkESIR" runat="server" CssClass="text-primary" Visible="false"
        OnClick="lnk_Click"></asp:LinkButton>
</div>
    <div class="col-md-3">
     <asp:label ID="lblesirdistcomment" runat="server" Text="comment"></asp:label>
   
</div>
<div class="col-md-3">
    <asp:TextBox ID="txtesir" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
</div>
</div>

<!-- 3. GST -->
<div class="row mb-3 alert alert-secondary">
<label class="col-md-3 col-form-label">3. GST</label>

<div class="col-md-3">
    <asp:FileUpload ID="fugst" runat="server" CssClass="form-control" />
    <asp:LinkButton ID="lnkGST" runat="server" CssClass="text-primary" Visible="false"
        OnClick="lnk_Click"></asp:LinkButton>
</div>
    <div class="col-md-3">
     <asp:label ID="lblgstdistcomment" runat="server" Text="comment"></asp:label>
   
</div>
<div class="col-md-3">
    <asp:TextBox ID="txtgst" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
</div>
</div>

<!-- 4. Name of Employees -->
<div class="row mb-3 alert alert-secondary">
<label class="col-md-3 col-form-label">4. Name of Employees</label>

<div class="col-md-3">
    <asp:FileUpload ID="fuename" runat="server" CssClass="form-control" />
    <asp:LinkButton ID="lnkNEmployees" runat="server" CssClass="text-primary" Visible="false"
        OnClick="lnk_Click"></asp:LinkButton>
</div>
    <div class="col-md-3">
     <asp:label ID="lblNEmploydistcomment" runat="server" Text="comment"></asp:label>
   
</div>
<div class="col-md-3">
    <asp:TextBox ID="txtename" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
</div>
</div>

<!-- 5. Salary Payment Certificate -->
<div class="row mb-3 alert alert-secondary">
<label class="col-md-3 col-form-label">5. Employees Salary Payment Certificate</label>

<div class="col-md-3">
    <asp:FileUpload ID="fuespc" runat="server" CssClass="form-control" />
    <asp:LinkButton ID="lnkESPC" runat="server" CssClass="text-primary" Visible="false"
        OnClick="lnk_Click"></asp:LinkButton>
</div>
    <div class="col-md-3">
     <asp:label ID="lblESPCdistcomment" runat="server" Text="comment"></asp:label>
   
</div>
<div class="col-md-3">
    <asp:TextBox ID="txtespc" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
</div>
</div>

<!-- 6. SOP -->
<div class="row mb-3 alert alert-secondary">
<label class="col-md-3 col-form-label">6. SOP</label>

<div class="col-md-3">
    <asp:FileUpload ID="fusop" runat="server" CssClass="form-control" />
    <asp:LinkButton ID="lnkSOP" runat="server" CssClass="text-primary" Visible="false"
        OnClick="lnk_Click"></asp:LinkButton>
</div>
    <div class="col-md-3">
     <asp:label ID="lblSOPdistcomment" runat="server" Text="comment"></asp:label>
   
</div>
<div class="col-md-3">
    <asp:TextBox ID="txtsop" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
</div>
</div>

<br />
<asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

<!-- Buttons -->
<div class="row mt-4">
<div class="col-md-8 offset-md-4">
    <asp:Button ID="btnSubmit" runat="server" Visible="false" CssClass="btn btn-success me-2" Text="Submit"
        OnClick="btnSubmit_Click" />
    <asp:Button ID="btnCancel" runat="server" Visible="false" CssClass="btn btn-secondary" Text="Cancel" />
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
