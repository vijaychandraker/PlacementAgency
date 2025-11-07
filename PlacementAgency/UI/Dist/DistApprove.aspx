<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DistApprove.aspx.cs" Inherits="PlacementAgency.UI.Dist.DistApprove" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

                    <div class="row mb-3">
    <!-- FY -->
    <div class="col-md-4 d-flex align-items-center">
        <label for="ddlFYDapprove" class="col-sm-4 col-form-label text-sm-end mb-0">FY:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlFYDapprove" runat="server" class="form-select"></asp:DropDownList>
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
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Visible="false"></asp:Label>

    
         <div id="maincontApprove" runat="server" visible="false"  class="container">
 
          <asp:GridView ID="gveDuty" runat="server" 
    AutoGenerateColumns="false"
    CssClass="table table-bordered table-striped table-hover text-center mt-4">

    <Columns>
        <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        <asp:BoundField DataField="LocationName" HeaderText="Location" />
        <asp:BoundField DataField="RateTypeName" HeaderText="Rate Type" />
        <asp:BoundField DataField="NoOfDuties" HeaderText="Duties" />
     
    </Columns>
</asp:GridView>
                       <div class="col-sm-10 offset-sm-4 ">
           <asp:Button ID="btnApprove" CssClass="btn btn-success" runat="server" Text="Approve" OnClick="btnApprove_Click"/>
<asp:Button ID="btnReject" CssClass="btn btn-danger" runat="server" Text="Reject" OnClick="btnReject_Click"/><br /> <br />

                <asp:TextBox ID="txtreasion" runat="server" TextMode="MultiLine"  Visible="false"></asp:TextBox>
              <asp:Button ID="btnSubmit" CssClass="btn btn-success" runat="server"  Visible="false" Text="Submit" OnClick="btnSubmit_Click"/>
              </div>
             </div>
          
      
</asp:Content>
