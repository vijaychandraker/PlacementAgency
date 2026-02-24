<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_DistReport.aspx.cs" Inherits="PlacementAgency.UI.Dist.csmcl_DistReport" %>
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
                <asp:DropDownList ID="ddlFYreportdist" runat="server"   class="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Month -->
        <div class="col-md-4">
            <div class="input-group mb-3">
                <label class="input-group-text">
                    <i class="bi bi-calendar3"></i>&nbsp; Month
                </label>
               <asp:DropDownList ID="ddlmonthreportdist" runat="server" class="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Buttons -->
        <div class="col-md-4 d-flex justify-content-center align-items-center">
            <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success" OnClick="btnSearch_Click"  />&nbsp;
            <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-warning" />
        </div>

    </div>
</div>
  </div>
</div>
</asp:Content>
