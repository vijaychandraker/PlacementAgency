<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_EntryReport.aspx.cs" Inherits="PlacementAgency.UI.Dist.csmcl_EntryReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
                <div class="row mb-3">
    <!-- FY -->
    <div class="col-md-4 d-flex align-items-center">
        <label for="ddlFY" class="col-sm-4 col-form-label text-sm-end mb-0">FY:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlFYreport" runat="server" class="form-select"></asp:DropDownList>
        </div>
    </div>

    <!-- Month -->
    <div class="col-md-4 d-flex align-items-center">
        <label for="ddlmonth" class="col-sm-4 col-form-label text-sm-end mb-0">Month:&nbsp&nbsp&nbsp</label>
        <div class="col-sm-8">
            <asp:DropDownList ID="ddlmonthreport" runat="server" class="form-select"></asp:DropDownList>
        </div>
    </div>
                     <div class="col-md-4 d-flex align-items-center">
     <div class="col-sm-8">
         <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="btnSearch_Click" />
     </div>
 </div>
</div>
    <br />
   
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Visible="false"></asp:Label>
      <asp:Label ID="lblrejectMSG" runat="server" ForeColor="Red" Visible="false"></asp:Label>

      <div id="maincont" runat="server" visible="false" class="container text-center">


<table class="table table-bordered">
     
  <thead>
          
    <tr  class="alert alert-primary">
      <th scope="col"> S.no</th>
      <th scope="col">  PARTICULARS</th>  
      <th scope="col">Duties</th>
    </tr>
  </thead>
  <tbody> 
                <tr style="background-color:#dcedff">
    <td colspan="3">Month</td>
</tr>
    <tr>
      <th scope="row">1</th>
      <td>CHIEF SALESMAN (Office)</td>
    
        <td>  <asp:TextBox ID="txtMCLOffic" runat="server"></asp:TextBox></td>
 
    </tr>
      <tr>
  <th scope="row">2</th>
  <td>CHIEF SALESMAN (Shop)</td>
  
    <td> <asp:TextBox ID="txtMCLShop" runat="server"></asp:TextBox> </td>
   
</tr>
      <tr>
  <th scope="row">3</th>
  <td>SALESMAN (Office)</td>
 
    <td>  <asp:TextBox ID="txtMSoffice" runat="server"></asp:TextBox></td>
  
</tr>
      <tr>
  <th scope="row">4</th>
  <td>SALESMAN (Shop)</td>
 
    <td> <asp:TextBox ID="txtMSShop" runat="server"></asp:TextBox> </td>
 
</tr>
      <tr>
  <th scope="row">5</th>
  <td>MULTIPURPOSE (Office)</td>
 
    <td> <asp:TextBox ID="txtMMOffice" runat="server"></asp:TextBox></td>
   
</tr>
      <tr>
  <th scope="row">6</th>
  <td>MULTIPURPOSE (Shop)</td>
 
    <td> <asp:TextBox ID="txtMMShop" runat="server"></asp:TextBox> </td>
   
</tr>
       <tr style="background-color:#dcedff">
    <td colspan="3" >OT</td>
</tr>
    <tr>
      <th scope="row">1</th>
      <td>CHIEF SALESMAN (Shop)</td>
   
        <td> <asp:TextBox ID="txtOTCLShop" runat="server"></asp:TextBox> </td>
      
    </tr>
      <tr>
  <th scope="row">2</th>
  <td>SALESMAN (Shop)</td>
 
    <td> <asp:TextBox ID="txtOTSShop" runat="server"></asp:TextBox></td>

</tr>
      <tr>
  <th scope="row">3</th>
  <td>MULTIPURPOSE (Shop)</td>
    <td> <asp:TextBox ID="txtOTMShop" runat="server"></asp:TextBox> </td>
 
</tr> 
             <tr style="background-color:#dcedff">
    <td colspan="3">Day(Total Week off 4 Days)</td>
</tr>
    <tr>
      <th scope="row">1</th>
      <td>CHIEF SALESMAN (Office)</td>
      
        <td><asp:TextBox ID="txtDCSOffice" runat="server"></asp:TextBox> </td>
        
    </tr>
      <tr>
  <th scope="row">2</th>
  <td>CHIEF SALESMAN (Shop)</td>
 
    <td>  <asp:TextBox ID="txtDCSShop" runat="server"></asp:TextBox></td>

</tr>
      <tr>
  <th scope="row">3</th>
  <td>SALESMAN (Office)</td>
  
    <td>  <asp:TextBox ID="txtDSOffice" runat="server"></asp:TextBox></td>
  
</tr>
      <tr>
  <th scope="row">4</th>
  <td>SALESMAN (Shop)</td>
 
    <td> <asp:TextBox ID="txtDSShop" runat="server"></asp:TextBox></td>
 
</tr>
      <tr>
  <th scope="row">5</th>
  <td>MULTIPURPOSE (Office)</td>
  
    <td> <asp:TextBox ID="txtDMOffice" runat="server"></asp:TextBox> </td>
   
</tr>
      <tr>
  <th scope="row">6</th>
  <td>MULTIPURPOSE (Shop)</td>
 
    <td> <asp:TextBox ID="txtDMShop" runat="server"></asp:TextBox></td>
   
</tr>
    
       
   <tr>
     
     
       <td colspan="3">
           <asp:Button ID="btnupdate" runat="server" Text="Update" OnClick="btnupdate_Click" />&nbsp&nbsp&nbsp
           <asp:Button ID="btncancel" runat="server" Text="Cancel" />
        
   </tr>
   
  </tbody>
</table>
</div>
</asp:Content>































 <%--<div class="card w-100">
     <div class="card-body">
         <h5 class="card-title alert alert-primary mb-4">Entry Detail</h5>
         <div class="container">


          <asp:GridView ID="gveDuty" runat="server" 
    AutoGenerateColumns="false"
    CssClass="table table-bordered table-striped table-hover text-center mt-4">

    <Columns>
        <asp:BoundField DataField="Zone_Name" HeaderText="Zone" />
        <asp:BoundField DataField="Agency_Name" HeaderText="Agency" />
        <asp:BoundField DataField="District_Name" HeaderText="District" />
        <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        <asp:BoundField DataField="LocationName" HeaderText="Location" />
        <asp:BoundField DataField="RateTypeName" HeaderText="Rate Type" />
        <asp:BoundField DataField="NoOfDuties" HeaderText="Duties" />
        <asp:BoundField DataField="MonthName" HeaderText="Month" />
       <asp:TemplateField HeaderText="Approve By Dist">
    <ItemTemplate>
        <asp:Label ID="lblDishead" runat="server" 
                   Text='<%# Eval("ApproveByDishead") %>' 
                   CssClass="text-danger fw-bold"></asp:Label>
    </ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Approve By Agency">
    <ItemTemplate>
        <asp:Label ID="lblAgency" runat="server" 
                   Text='<%# Eval("ApproveByAgency") %>' 
                   CssClass="text-danger fw-bold"></asp:Label>
    </ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Approve By State">
    <ItemTemplate>
        <asp:Label ID="lblState" runat="server" 
                   Text='<%# Eval("ApproveByState") %>' 
                   CssClass="text-danger fw-bold"></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
    </Columns>
</asp:GridView>



             </div>
         </div>
     </div>--%>






