<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_EntryReport.aspx.cs" Inherits="PlacementAgency.UI.Dist.csmcl_EntryReport" %>

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
                <asp:DropDownList ID="ddlFYreport" runat="server"  class="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Month -->
        <div class="col-md-4">
            <div class="input-group mb-3">
                <label class="input-group-text">
                    <i class="bi bi-calendar3"></i>&nbsp; Month
                </label>
               <asp:DropDownList ID="ddlmonthreport" runat="server" class="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Buttons -->
        <div class="col-md-4 d-flex justify-content-center align-items-center">
            <asp:Button ID="btnSearch" runat="server" Text="Submit" class="btn btn-success" OnClick="btnSearch_Click" />&nbsp;
            <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-warning" />
        </div>

    </div>
</div>
  </div>
</div>  
    <br />

    <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Visible="false"></asp:Label>
<asp:Label ID="lblrejectMSG" runat="server" ForeColor="Red" Visible="false"></asp:Label>
          <div class="card" id="maincont" runat="server" visible="false" >
<div class="card-header alert alert-success">
  Search Record
</div>
<div class="card-body">
    
    <div class="alert alert-warning" role="alert">
  Approvel Pending From District Office
</div>
    <div class="container text-center">


        <table class="table table-bordered">

            <thead>

                <tr class="alert alert-primary">
                    <th scope="col">S.no</th>
                    <th scope="col">PARTICULARS</th>
                     <th scope="col">Head Count</th>
                    <th scope="col">Duties</th>
                </tr>
            </thead>
            <tbody>
                <tr style="background-color: #dcedff">
                    <td colspan="4">Month</td>
                </tr>
                <tr>
                    <th scope="row">1</th>
                    <td>CHIEF SALESMAN (Office)</td>
                    <td><asp:TextBox ID="txtMCLOffic_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtMCLOffic" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>CHIEF SALESMAN (Shop)</td>
                    <td><asp:TextBox ID="txtMCLShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtMCLShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>SALESMAN (Office)</td>
                    <td><asp:TextBox ID="txtMSoffice_HC" runat="server"></asp:TextBox></td>
                   <td><asp:TextBox ID="txtMSoffice" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">4</th>
                    <td>SALESMAN (Shop)</td>
                     <td><asp:TextBox ID="txtMSShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtMSShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">5</th>
                    <td>MULTIPURPOSE (Office)</td>
                     <td><asp:TextBox ID="txtMMOffice_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtMMOffice" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">6</th>
                    <td>MULTIPURPOSE (Shop)</td>
                    <td><asp:TextBox ID="txtMMShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtMMShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr style="background-color: #dcedff">
                    <td colspan="4">OT</td>
                </tr>
                <tr>
                    <th scope="row">1</th>
                    <td>CHIEF SALESMAN (Shop)</td>
                     <td><asp:TextBox ID="txtOTCLShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtOTCLShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>SALESMAN (Shop)</td>
                     <td><asp:TextBox ID="txtOTSShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtOTSShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>MULTIPURPOSE (Shop)</td>
                    <td><asp:TextBox ID="txtOTMShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtOTMShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr style="background-color: #dcedff">
                    <td colspan="4">Day(Total Week off 4 Days)</td>
                </tr>
                <tr>
                    <th scope="row">1</th>
                    <td>CHIEF SALESMAN (Office)</td>
                     <td><asp:TextBox ID="txtDCSOffice_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtDCSOffice" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>CHIEF SALESMAN (Shop)</td>
                    <td><asp:TextBox ID="txtDCSShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtDCSShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>SALESMAN (Office)</td>
                    <td><asp:TextBox ID="txtDSOffice_HC" runat="server"></asp:TextBox></td>
                   <td><asp:TextBox ID="txtDSOffice" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">4</th>
                    <td>SALESMAN (Shop)</td>
                    
                    <td><asp:TextBox ID="txtDSShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtDSShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">5</th>
                    <td>MULTIPURPOSE (Office)</td>
                    <td><asp:TextBox ID="txtDMOffice_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtDMOffice" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th scope="row">6</th>
                    <td>MULTIPURPOSE (Shop)</td>
                    <td><asp:TextBox ID="txtDMShop_HC" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtDMShop" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Button ID="btnupdate" runat="server" Text="Update" Visible="false" OnClick="btnupdate_Click" />&nbsp&nbsp&nbsp
           <asp:Button ID="btncancel" runat="server" Visible="false" Text="Cancel" />
                </tr>

            </tbody>
        </table>
    </div>
    </div>
              </div>
    
</asp:Content>






































