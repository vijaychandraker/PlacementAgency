<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadDocument.aspx.cs" Inherits="PlacementAgency.UI.Agency.UploadDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container text-center">
    <div class="row g-3">
        <!-- District -->
        <div class="col-md-3">
            <label for="ddldistrictAgent" class="form-label">District</label>
            <asp:DropDownList ID="ddldistrictAgent" runat="server" CssClass="form-select"></asp:DropDownList>
        </div>

        <!-- FY -->
        <div class="col-md-3">
            <label for="ddlFYAg" class="form-label">FY</label>
            <asp:DropDownList ID="ddlFYAg" runat="server" AutoPostBack="true"
                CssClass="form-select">
            </asp:DropDownList>
        </div>
        <!-- Month -->
        <div class="col-md-3">
            <label for="ddlMonthAg" class="form-label">Month</label>
            <asp:DropDownList ID="ddlMonthAg" runat="server" CssClass="form-select"></asp:DropDownList>
        </div>

        <!-- Button -->
        <div class="col-md-3 d-flex align-items-end">
            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary w-100"/>
        </div>
    </div>
</div>
    <br />
    <br />
        <div class="card">
    <div class="card-header">
        Add/Update New Record
    </div>

    <div class="card-body">
        <div class="container">

            <!-- Row 1 -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">1. EPF</label>
                <div class="col-md-4">
                    <asp:FileUpload ID="fuepf" runat="server" class="form-control" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                </div>
            </div>

            <!-- Row 2 -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">2. ESIR</label>
                <div class="col-md-4">
                    <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                </div>
            </div>

            <!-- Row 3 -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">3. GST</label>
                <div class="col-md-4">
                    <asp:FileUpload ID="FileUpload2" runat="server" class="form-control" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                </div>
            </div>

            <!-- Row 4 -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">4. Name of Employees</label>
                <div class="col-md-4">
                    <asp:FileUpload ID="FileUpload3" runat="server" class="form-control" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                </div>
            </div>

            <!-- Row 5 -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">5. Employees Salary Payment Certificate</label>
                <div class="col-md-4">
                    <asp:FileUpload ID="FileUpload4" runat="server" class="form-control" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                </div>
            </div>

            <!-- Row 6 -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">6. SOP</label>
                <div class="col-md-4">
                    <asp:FileUpload ID="FileUpload5" runat="server" class="form-control" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
                </div>
            </div>
            <!-- Buttons -->
<div class="row mt-4">
    <div class="col-md-8 offset-md-4">
        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success me-2" Text="Submit" />
        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" />
    </div>
</div>

        </div>
    </div>
</div>

</asp:Content>
