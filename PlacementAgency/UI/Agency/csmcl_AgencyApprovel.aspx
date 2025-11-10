<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_AgencyApprovel.aspx.cs" Inherits="PlacementAgency.UI.Agency.csmcl_AgencyApprovel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    
                    <div class="row mb-3">
    <!-- FY -->
    <div class="col-md-3 d-flex align-items-center">
        <label for="ddlFYDapproveAgent" class="col-sm-4 col-form-label text-sm-end mb-0">FY:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlFYDapproveAgent" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="ddlFYDapprove_SelectedIndexChanged"  class="form-select"></asp:DropDownList>
        </div>
    </div>

    <!-- Month -->
    <div class="col-md-3 d-flex align-items-center">
        <label for="ddlmonthDApproveAgent" class="col-sm-4 col-form-label text-sm-end mb-0">Month:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlmonthDApproveAgent" runat="server" class="form-select"></asp:DropDownList>
        </div>
    </div>
                        <!-- Dist -->
<div class="col-md-3 d-flex align-items-center">
    <label for="ddlmonthDApproveAgent" class="col-sm-4 col-form-label text-sm-end mb-0">District:&nbsp&nbsp&nbsp</label>
    <div class="col-sm-8">
        <asp:DropDownList ID="ddldistrictAgent" runat="server" class="form-select"></asp:DropDownList>
    </div>
</div>
                     <div class="col-md-3 d-flex align-items-center">
     <div class="col-sm-8">
         <asp:Button ID="btnSearchAgent" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="btnSearchAgent_Click" />
     </div>
 </div>
</div>


    <nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Duties</button>
    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Document Upload</button>
   
    
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">

          <asp:GridView ID="gveDutyAgent" runat="server" 
    AutoGenerateColumns="false"
    CssClass="table table-bordered table-striped table-hover text-center mt-4">

    <Columns>
        <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        <asp:BoundField DataField="LocationName" HeaderText="Location" />
        <asp:BoundField DataField="RateTypeName" HeaderText="Rate Type" />
        <asp:BoundField DataField="HeadCount" HeaderText="Head Count" />
        <asp:BoundField DataField="NoOfDuties" HeaderText="Duties" />
     
    </Columns>
</asp:GridView>



  </div>
  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">

         
 
  
    <div class="container text-center">
  <div class="row align-items-start">
    <div class="col">
        1. EPF
    </div>
    <div class="col">
        <asp:FileUpload ID="fuepf" runat="server" />
    </div>
  </div>
        <div class="row align-items-start">
  <div class="col">
      1. ECR
  </div>
  <div class="col">
      <asp:FileUpload ID="FileUpload1" runat="server" />
  </div>
</div>
        <div class="row align-items-start">
  <div class="col">
      2. GST
  </div>
  <div class="col">
      <asp:FileUpload ID="FileUpload2" runat="server" />
  </div>
</div>
        <div class="row align-items-start">
  <div class="col">
      3. Name of Employees
  </div>
  <div class="col">
      <asp:FileUpload ID="FileUpload3" runat="server" />
  </div>
</div>
        <div class="row align-items-start">
  <div class="col">
      4. Employees Salary Payment Certificate
  </div>
  <div class="col">
      <asp:FileUpload ID="FileUpload4" runat="server" />
  </div>
</div>
        <div class="row align-items-start">
  <div class="col">
      5. EPF
  </div>
  <div class="col">
      <asp:FileUpload ID="FileUpload5" runat="server" />
  </div>
</div>
</div>
  
  </div>

</div>




         




    


</asp:Content>
