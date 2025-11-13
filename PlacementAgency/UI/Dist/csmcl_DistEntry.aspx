<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="csmcl_DistEntry.aspx.cs" Inherits="PlacementAgency.UI.Dist.csmcl_DistEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card w-100">
        <div class="card-body">
            <h5 class="card-title alert alert-primary mb-4">Month/OT/Day Duties Entry</h5>
            <div class="container">

                 <!-- Year -->
 <div class="row mb-3">
     <label for="month" class="col-sm-4 col-form-label text-sm-end">FY:</label>
     <div class="col-sm-6">
         <asp:DropDownList ID="ddlFY" runat="server" class="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFY_SelectedIndexChanged"></asp:DropDownList>    
     </div>
 </div>

                <!-- Month -->
                <div class="row mb-3">
                    <label for="month" class="col-sm-4 col-form-label text-sm-end">Month:</label>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddlmonth" runat="server" class="form-select"></asp:DropDownList>    
                    </div>
                </div>
                <!-- Location -->
                <div class="row mb-3">
                    <label for="Location" class="col-sm-4 col-form-label text-sm-end">Location:</label>
                    <div class="col-sm-6">
                       <asp:DropDownList ID="ddllocation" runat="server" class="form-select"></asp:DropDownList>   
                    </div>
                </div>
                <!-- Category -->
                <div class="row mb-3">
                    <label for="Category" class="col-sm-4 col-form-label text-sm-end">Category:</label>
                    <div class="col-sm-6">
                       <asp:DropDownList ID="ddlcategory" runat="server" class="form-select"></asp:DropDownList> 
                    </div>
                </div>
                <!-- Rate Type -->
                <div class="row mb-3">
                    <label for="RateType" class="col-sm-4 col-form-label text-sm-end">RateType:</label>
                    <div class="col-sm-6">
                      <asp:DropDownList ID="ddlrtype" runat="server" class="form-select"></asp:DropDownList> 
                    </div>
                </div>
                 <!-- HeadCount -->
 <div class="row mb-3">
     <label for="duties" class="col-sm-4 col-form-label text-sm-end">Total Head Count:</label>
     <div class="col-sm-6">

         <asp:TextBox ID="txtheadcount" runat="server" class="form-control" TextMode="Number"></asp:TextBox>
       
     </div>
 </div>




                <!-- Duties -->
                <div class="row mb-3">
                    <label for="duties" class="col-sm-4 col-form-label text-sm-end">Number of Duties:</label>
                    <div class="col-sm-6">

                        <asp:TextBox ID="duties" runat="server" class="form-control" TextMode="Number"></asp:TextBox>
                      
                    </div>
                </div>
                <!-- Actions -->
                <div class="row mt-4">
                    <div class="col-sm-10 offset-sm-4 ">
                         <asp:Button ID="btnSubmit" CssClass="btn btn-success" runat="server" Text="Submit" OnClick="btnSubmit_Click"/>
                       <asp:Button ID="btnreset" CssClass="btn btn-success" runat="server" Text="Reset"/>
                        <asp:Button ID="btnshow" CssClass="btn btn-success" runat="server" Text="Show Data"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
