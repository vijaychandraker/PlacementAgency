<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master.aspx.cs" Inherits="PlacementAgency.UI.Admin.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
    <div class="card-header">
        Add/Update New Record
    </div>

    <div class="card-body">
        <div class="container">

            <!-- ESIC -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">ESIC %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- EPF -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">EPF %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Agency Charges -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">AGENCY CHARGES %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Add CGST -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">ADD: CGST %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Less TDS -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">LESS: TDS %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Less CGST -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">LESS: CGST %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Less SGST -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">LESS: SGST %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Add SGST -->
            <div class="row mb-3">
                <label class="col-md-4 col-form-label">ADD: SGST %</label>
                <div class="col-md-8">
                    <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control"></asp:TextBox>
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
