<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmclInvoiceReport.aspx.cs" Inherits="PlacementAgency.UI.Admin.csmclInvoiceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container text-center">
        <div class="row">
            <div class="col">
                <label for="zone" class="col-sm-4 col-form-label text-sm-end">Zone:</label>
                <asp:DropDownList ID="ddlZone" runat="server" class="form-select"></asp:DropDownList>
            </div>
            <div class="col">
                <label for="fy" class="col-sm-4 col-form-label text-sm-end">FY:</label>
                <asp:DropDownList ID="ddlFY" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFY_SelectedIndexChanged" class="form-select"></asp:DropDownList>
            </div>
            <div class="col">
                <label for="month" class="col-sm-4 col-form-label text-sm-end">Month:</label>
                <asp:DropDownList ID="ddlMonth" runat="server" class="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>
    </div>
    <br />
    <div class="container text-center">

        <table class="table table-bordered">
            <tr class="alert alert-warning fw-bold">
                <td>PARTICULARS</td>
                <td>Rate / Pay Per Month</td>
                <td>Head Count</td>
                <td>Duties</td>
                <td>Amount(Rs)</td>
            </tr>
            <tr>
                <td>CHIEF SALESMAN(Office)</td>
                <td>
                    <asp:Label ID="lbl_CS_Off_M" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Off_M_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Off_M_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Off_M_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>CHIEF SALESMAN (Shop)</td>
                <td><asp:Label ID="lbl_CS_Sh_M" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_M_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_M_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_M_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Office)</td>
                 <td><asp:Label ID="lbl_S_Off_M" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Off_M_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Off_M_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Off_M_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
               <td><asp:Label ID="lbl_S_Sh_M" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_M_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_M_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_M_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Office)</td>
                 <td><asp:Label ID="lbl_M_Off_M" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Off_M_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Off_M_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Off_M_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                  <td><asp:Label ID="lbl_M_Sh_M" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_M_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_M_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_M_Total" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4" >TOTAL (A)</td>
                <td><asp:Label ID="lblTotalA" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-warning fw-bold">
                <td>PARTICULARS</td>
                <td>OT Rate/ Hr.</td>
                <td>Head Count</td>
                <td>Total OT Hrs.</td>
                <td>Amount(Rs)</td>
            </tr>
            <tr>
                <td>CHIEF SALESMAN (Shop)</td>
                <td><asp:Label ID="lbl_CS_Sh_OT" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_OT_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_OT_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_OT_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
                <td><asp:Label ID="lbl_S_Sh_OT" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_OT_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_OT_Dut" runat="server"/></td>
                <td><asp:Label ID="lbl_S_Sh_OT_Dut_Total" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                <td><asp:Label ID="lbl_M_Sh_OT" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_OT_HC" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_OT_Dut" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_OT_Total" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (B)</td>
                <td><asp:Label ID="lblTotalB" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-warning fw-bold">
                <td>PARTICULARS</td>
                <td>Per day Rate</td>
                <td>Head Count</td>
                <td>Total Week off 4 Days</td>
                <td>Amount(Rs)</td>
            </tr>
           
           <tr>
     <td>CHIEF SALESMAN (Office)</td>
     <td>
         <asp:Label ID="lbl_CS_Off_D" runat="server"></asp:Label>

     </td>
     <td><asp:Label ID="lbl_CS_Off_D_HC" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Off_D_Dut" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Off_D_Total" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>CHIEF SALESMAN (Shop)</td>
     <td><asp:Label ID="lbl_CS_Sh_D" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Sh_D_HC" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Sh_D_Dut" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Sh_D_Total" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>SALESMAN (Office)</td>
      <td><asp:Label ID="lbl_S_Off_D" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Off_D_HC" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Off_D_Dut" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Off_D_Total" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>SALESMAN (Shop)</td>
    <td><asp:Label ID="lbl_S_Sh_D" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Sh_D_HC" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Sh_D_Dut" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Sh_D_Total" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>MULTIPURPOSE (Office)</td>
      <td><asp:Label ID="lbl_M_Off_D" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Off_D_HC" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Off_D_Dut" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Off_D_Total" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>MULTIPURPOSE (Shop)</td>
       <td><asp:Label ID="lbl_M_Sh_D" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Sh_D_HC" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Sh_D_Dut" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Sh_D_Total" runat="server"></asp:Label></td>
 </tr>  



            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (C)</td>
                <td><asp:Label ID="lblTotalC" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4" >TOTAL - D (A)+(B)+(C)</td>
                <td><asp:Label ID="lblTotalD_AplusBplusC" runat="server"></asp:Label></td>
            </tr>
             <tr>
     <td colspan="3">ESIC (D )</td>
     <td>3.25%</td> <td> <asp:Label ID="lblESIC" runat="server"></asp:Label></td>
 </tr>
                        <tr>
    <td colspan="3">Rs. 15000/- EPF ON Rs. 3217113/-</td>
    <td>13%</td> <td> <asp:Label ID="lblEPF" runat="server"></asp:Label></td>
</tr>
                                    <tr>
    <td colspan="3">AGENCY CHARGES  (C )</td>
    <td>9%</td> <td>  <asp:Label ID="lblAgencyCharges" runat="server"></asp:Label></td>
</tr>
             <tr class="alert alert-secondary fw-bold">
     <td colspan="4">TOTAL (E) (D+ ESI+EPF+AGENCY CHARGES)</td>
     <td> <asp:Label ID="lblTotalE" runat="server"></asp:Label></td>
 </tr>
                                    <tr>
    <td colspan="3">ADD: CGST (E)</td>
    <td>9%</td> <td>  <asp:Label ID="lblCGST" runat="server"></asp:Label></td>
</tr>
                                    <tr>
    <td colspan="3">ADD: SGST (E)</td>
    <td>9%</td> <td> <asp:Label ID="lblSGST" runat="server"></asp:Label></td>
</tr>
             <tr class="alert alert-secondary fw-bold">
     <td colspan="4">GRAND TOTAL - F (D+GST)</td>
     <td>  <asp:Label ID="lblGrandTotal" runat="server"></asp:Label></td>
 </tr>
                                                <tr>
    <td colspan="3">LESS : TDS on (E) </td>
    <td>0.10%</td> <td> <asp:Label ID="lblTDS" runat="server"></asp:Label></td>
</tr>
                                                            <tr>
    <td colspan="3">LESS : CGST  on  (E) </td>
    <td>1%</td> <td>  <asp:Label ID="lblLessCGST" runat="server"></asp:Label></td>
</tr>
                                    <tr>
    <td colspan="3">LESS : SGST  on (E) </td>
    <td>1%</td> <td> <asp:Label ID="lblLessSGST" runat="server"></asp:Label></td>
</tr>
             <tr class="alert alert-secondary fw-bold">
     <td colspan="4">GRAND TOTAL - (Rounded off)</td>
     <td>   <asp:Label ID="lblRoundedTotal" runat="server"></asp:Label></td>
 </tr>

        </table>


    </div>

</asp:Content>
