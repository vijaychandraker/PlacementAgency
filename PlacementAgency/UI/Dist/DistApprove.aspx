<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DistApprove.aspx.cs" Inherits="PlacementAgency.UI.Dist.DistApprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container text-center">
        <div class="row">
           
            <div class="col">
                <label for="fy" class="col-sm-4 col-form-label text-sm-end">FY:</label>
                <asp:DropDownList ID="ddlFYdis" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFY_SelectedIndexChanged" class="form-select"></asp:DropDownList>
            </div>
            <div class="col">
                <label for="month" class="col-sm-4 col-form-label text-sm-end">Month:</label>
                <asp:DropDownList ID="ddlMonthdis" runat="server" class="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>
    </div>


    <asp:Label ID="lblmsg" runat="server" Text="Label" Visible="false"></asp:Label>
    <br />
    <div class="container text-center">

<div class="alert alert-danger d-flex align-items-center" role="alert">
    <div>
  LESS : TDS on (E) / 
   LESS : CGST  on  (E) / 
   LESS : SGST  on (E) / 
        All are LESS when State Admin Apprive.
  </div>
</div>


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
                    <asp:Label ID="lbl_CS_Off_Mdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Off_M_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Off_M_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Off_M_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>CHIEF SALESMAN (Shop)</td>
                <td><asp:Label ID="lbl_CS_Sh_Mdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_M_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_M_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_M_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Office)</td>
                 <td><asp:Label ID="lbl_S_Off_Mdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Off_M_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Off_M_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Off_M_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
               <td><asp:Label ID="lbl_S_Sh_Mdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_M_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_M_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_M_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Office)</td>
                 <td><asp:Label ID="lbl_M_Off_Mdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Off_M_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Off_M_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Off_M_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                  <td><asp:Label ID="lbl_M_Sh_Mdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_M_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_M_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_M_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4" >TOTAL (A)</td>
                <td><asp:Label ID="lblTotalAdis" runat="server"></asp:Label></td>
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
                <td><asp:Label ID="lbl_CS_Sh_OTdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_OT_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_OT_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_CS_Sh_OT_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
                <td><asp:Label ID="lbl_S_Sh_OTdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_OT_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_S_Sh_OT_Dutdis" runat="server"/></td>
                <td><asp:Label ID="lbl_S_Sh_OT_Dut_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                <td><asp:Label ID="lbl_M_Sh_OTdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_OT_HCdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_OT_Dutdis" runat="server"></asp:Label></td>
                <td><asp:Label ID="lbl_M_Sh_OT_Totaldis" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (B)</td>
                <td><asp:Label ID="lblTotalBdis" runat="server"></asp:Label></td>
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
         <asp:Label ID="lbl_CS_Off_Ddis" runat="server"></asp:Label>

     </td>
     <td><asp:Label ID="lbl_CS_Off_D_HCdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Off_D_Dutdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Off_D_Totaldis" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>CHIEF SALESMAN (Shop)</td>
     <td><asp:Label ID="lbl_CS_Sh_Ddis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Sh_D_HCdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Sh_D_Dutdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_CS_Sh_D_Totaldis" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>SALESMAN (Office)</td>
      <td><asp:Label ID="lbl_S_Off_Ddis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Off_D_HCdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Off_D_Dutdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Off_D_Totaldis" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>SALESMAN (Shop)</td>
    <td><asp:Label ID="lbl_S_Sh_Ddis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Sh_D_HCdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Sh_D_Dutdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_S_Sh_D_Totaldis" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>MULTIPURPOSE (Office)</td>
      <td><asp:Label ID="lbl_M_Off_Ddis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Off_D_HCdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Off_D_Dutdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Off_D_Totaldis" runat="server"></asp:Label></td>
 </tr>
 <tr>
     <td>MULTIPURPOSE (Shop)</td>
       <td><asp:Label ID="lbl_M_Sh_Ddis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Sh_D_HCdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Sh_D_Dutdis" runat="server"></asp:Label></td>
     <td><asp:Label ID="lbl_M_Sh_D_Totaldis" runat="server"></asp:Label></td>
 </tr>  



            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (C)</td>
                <td><asp:Label ID="lblTotalCdis" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4" >TOTAL - D (A)+(B)+(C)</td>
                <td><asp:Label ID="lblTotalD_AplusBplusCdis" runat="server"></asp:Label></td>
            </tr>
             <tr>
     <td colspan="3">ESIC (D )</td>
     <td>3.25%</td> <td> <asp:Label ID="lblESICdis" runat="server"></asp:Label></td>
 </tr>
                        <tr>
    <td colspan="3">Rs. 15000/- EPF ON Rs. 3217113/-</td>
    <td>13%</td> <td> <asp:Label ID="lblEPFdis" runat="server"></asp:Label></td>
</tr>
                                    <tr>
    <td colspan="3">AGENCY CHARGES  (C )</td>
    <td>9%</td> <td>  <asp:Label ID="lblAgencyChargesdis" runat="server"></asp:Label></td>
</tr>
             <tr class="alert alert-secondary fw-bold">
     <td colspan="4">TOTAL (E) (D+ ESI+EPF+AGENCY CHARGES)</td>
     <td> <asp:Label ID="lblTotalEdis" runat="server"></asp:Label></td>
 </tr>
                                    <tr>
    <td colspan="3">ADD: CGST (E)</td>
    <td>9%</td> <td>  <asp:Label ID="lblCGSTdis" runat="server"></asp:Label></td>
</tr>
                                    <tr>
    <td colspan="3">ADD: SGST (E)</td>
    <td>9%</td> <td> <asp:Label ID="lblSGSTdis" runat="server"></asp:Label></td>
</tr>
             <tr class="alert alert-secondary fw-bold">
     <td colspan="4">GRAND TOTAL - F (D+GST)</td>
     <td>  <asp:Label ID="lblGrandTotaldis" runat="server"></asp:Label></td>
 </tr>
                                                <tr>
    <td colspan="3">LESS : TDS on (E) </td>
    <td>Pending by State</td> <td> <asp:Label ID="lblTDSdis" runat="server"></asp:Label></td>
</tr>
                                                            <tr>
    <td colspan="3">LESS : CGST  on  (E) </td>
    <td>Pending by State</td> <td>  <asp:Label ID="lblLessCGSTdis" runat="server"></asp:Label></td>
</tr>
                                    <tr>
    <td colspan="3">LESS : SGST  on (E) </td>
    <td>Pending by Sate</td> <td> <asp:Label ID="lblLessSGSTdis" runat="server"></asp:Label></td>
</tr>
             <tr class="alert alert-secondary fw-bold">
     <td colspan="4">GRAND TOTAL - (Rounded off)</td>
     <td>   <asp:Label ID="lblRoundedTotaldis" runat="server"></asp:Label></td>
 </tr>

        </table>


    </div>
   <div class="col-sm-10 offset-sm-4 ">
           <asp:Button ID="btnApprove" CssClass="btn btn-success" runat="server" Text="Approve" OnClick="btnApprove_Click" />
<asp:Button ID="btnReject" CssClass="btn btn-danger" runat="server" Text="Reject" OnClick="btnReject_Click" /><br /> <br />

                <asp:TextBox ID="txtreasion" runat="server" TextMode="MultiLine"  Visible="false"></asp:TextBox>
              <asp:Button ID="btnSubmit" CssClass="btn btn-success" runat="server"  Visible="false" Text="Submit" OnClick="btnSubmit_Click" />
              </div>
</asp:Content>
