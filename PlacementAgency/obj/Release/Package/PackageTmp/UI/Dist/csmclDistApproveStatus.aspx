<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmclDistApproveStatus.aspx.cs" Inherits="PlacementAgency.UI.Dist.csmclDistApproveStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    
                    <div class="row mb-3">
    <!-- FY -->
    <div class="col-md-4 d-flex align-items-center">
        <label for="ddlFYDapprove" class="col-sm-4 col-form-label text-sm-end mb-0">FY:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlFYDapprove" runat="server" OnSelectedIndexChanged="ddlFYDapprove_SelectedIndexChanged1" AutoPostBack="true"  class="form-select"></asp:DropDownList>
        </div>
    </div>

    <!-- Month -->
    <div class="col-md-4 d-flex align-items-center">
        <label for="ddlmonthDApprove" class="col-sm-4 col-form-label text-sm-end mb-0">Month:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlmonthDApprove" runat="server" class="form-select"></asp:DropDownList>
        </div>
    </div>
                     <div class="col-md-4 d-flex align-items-center">
     <div class="col-sm-8">
         <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="btnSearch_Click" />
     </div>
 </div>
</div>
     <asp:Label ID="lblmsgcheck" runat="server" ForeColor="Red" Visible="false"></asp:Label>
         <div id="maincontApprove" runat="server" visible="false"  class="container">

         <asp:GridView ID="gveDuty" runat="server"
    AutoGenerateColumns="false"
    CssClass="table table-bordered table-striped table-hover text-center mt-4"
    OnRowDataBound="gveDuty_RowDataBound">

    <Columns>
        <asp:TemplateField HeaderText="Approve By District">
            <ItemTemplate>
                <asp:Label ID="lblDis" runat="server" Text='<%# Eval("ApproveByDishead") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Approve By Agency">
            <ItemTemplate>
                <asp:Label ID="lblAgency" runat="server" Text='<%# Eval("ApproveByAgency") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Approve By State">
            <ItemTemplate>
                <asp:Label ID="lblState" runat="server" Text='<%# Eval("ApproveByState") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

             </div>



</asp:Content>
