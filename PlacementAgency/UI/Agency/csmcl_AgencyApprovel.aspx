<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_AgencyApprovel.aspx.cs" Inherits="PlacementAgency.UI.Agency.csmcl_AgencyApprovel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
          <div class="card">
<div class="card-header alert alert-success">
  Search Record
</div>
<div class="card-body">
    <div class="container text-center">
    <div class="row g-3">

        <!-- District -->
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-geo-alt-fill"></i>&nbsp; District</span>
                <asp:DropDownList ID="ddldistrictAgent" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- FY -->
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-calendar-range"></i>&nbsp; FY</span>
                <asp:DropDownList ID="ddlFYAg" runat="server" CssClass="form-select" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlFY_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>

        <!-- Month -->
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-calendar3"></i>&nbsp; Month</span>
                <asp:DropDownList ID="ddlMonthAg" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Submit Button -->
        <div class="col-md-3 d-flex align-items-end">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSubmit_Click1" />&nbsp
            <asp:Button ID="btnclr" runat="server" Text="Submit" CssClass="btn btn-warning" />
        </div>

    </div>
        </div>
    </div>
              </div>

    <asp:Label ID="lblmsg" runat="server" Text="Label" Visible="false"></asp:Label>
    <br />
    <div runat="server" id="maincont" visible="false" class="container text-center">

        <div runat="server" id="divmsg" visible="false" class="alert alert-danger d-flex align-items-center" role="alert">
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
                    <asp:Label ID="lbl_CS_Off_MAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Off_M_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Off_M_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Off_M_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>CHIEF SALESMAN (Shop)</td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_MAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_M_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_M_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_M_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Office)</td>
                <td>
                    <asp:Label ID="lbl_S_Off_MAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Off_M_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Off_M_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Off_M_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
                <td>
                    <asp:Label ID="lbl_S_Sh_MAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_M_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_M_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_M_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Office)</td>
                <td>
                    <asp:Label ID="lbl_M_Off_MAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Off_M_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Off_M_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Off_M_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                <td>
                    <asp:Label ID="lbl_M_Sh_MAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_M_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_M_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_M_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (A)</td>
                <td>
                    <asp:Label ID="lblTotalAAg" runat="server"></asp:Label></td>
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
                <td>
                    <asp:Label ID="lbl_CS_Sh_OTAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_OT_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_OT_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_OT_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
                <td>
                    <asp:Label ID="lbl_S_Sh_OTAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_OT_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_OT_DutAg" runat="server" /></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_OT_Dut_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                <td>
                    <asp:Label ID="lbl_M_Sh_OTAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_OT_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_OT_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_OT_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (B)</td>
                <td>
                    <asp:Label ID="lblTotalBAg" runat="server"></asp:Label></td>
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
                    <asp:Label ID="lbl_CS_Off_DAg" runat="server"></asp:Label>

                </td>
                <td>
                    <asp:Label ID="lbl_CS_Off_D_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Off_D_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Off_D_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>CHIEF SALESMAN (Shop)</td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_DAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_D_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_D_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_CS_Sh_D_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Office)</td>
                <td>
                    <asp:Label ID="lbl_S_Off_DAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Off_D_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Off_D_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Off_D_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>SALESMAN (Shop)</td>
                <td>
                    <asp:Label ID="lbl_S_Sh_DAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_D_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_D_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_S_Sh_D_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Office)</td>
                <td>
                    <asp:Label ID="lbl_M_Off_DAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Off_D_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Off_D_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Off_D_TotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>MULTIPURPOSE (Shop)</td>
                <td>
                    <asp:Label ID="lbl_M_Sh_DAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_D_HCAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_D_DutAg" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lbl_M_Sh_D_TotalAg" runat="server"></asp:Label></td>
            </tr>



            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (C)</td>
                <td>
                    <asp:Label ID="lblTotalCAg" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL - D (A)+(B)+(C)</td>
                <td>
                    <asp:Label ID="lblTotalD_AplusBplusCAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">ESIC (D )</td>
                <td>3.25%</td>
                <td>
                    <asp:Label ID="lblESICAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">Rs. 15000/- EPF ON Rs. 3217113/-</td>
                <td>13%</td>
                <td>
                    <asp:Label ID="lblEPFAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">AGENCY CHARGES  (C )</td>
                <td>9%</td>
                <td>
                    <asp:Label ID="lblAgencyChargesAg" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">TOTAL (E) (D+ ESI+EPF+AGENCY CHARGES)</td>
                <td>
                    <asp:Label ID="lblTotalEAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">ADD: CGST (E)</td>
                <td>9%</td>
                <td>
                    <asp:Label ID="lblCGSTAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">ADD: SGST (E)</td>
                <td>9%</td>
                <td>
                    <asp:Label ID="lblSGSTAg" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">GRAND TOTAL - F (D+GST)</td>
                <td>
                    <asp:Label ID="lblGrandTotalAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">LESS : TDS on (E) </td>
                <td>Pending by State</td>
                <td>
                    <asp:Label ID="lblTDSAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">LESS : CGST  on  (E) </td>
                <td>Pending by State</td>
                <td>
                    <asp:Label ID="lblLessCGSTAg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">LESS : SGST  on (E) </td>
                <td>Pending by Sate</td>
                <td>
                    <asp:Label ID="lblLessSGSTAg" runat="server"></asp:Label></td>
            </tr>
            <tr class="alert alert-secondary fw-bold">
                <td colspan="4">GRAND TOTAL - (Rounded off)</td>
                <td>
                    <asp:Label ID="lblRoundedTotalAg" runat="server"></asp:Label></td>
            </tr>

        </table>



        <div class="col-sm-10 offset-sm-4 ">
            <asp:Button ID="btnApproveAg" CssClass="btn btn-success" runat="server" Text="Approve" OnClick="btnApprove_Click" />
            <asp:Button ID="btnReject" CssClass="btn btn-danger" runat="server" Text="Reject" OnClick="btnReject_Click" /><br />
            <br />

            <asp:TextBox ID="txtreasionAg" runat="server" TextMode="MultiLine" Visible="false"></asp:TextBox>
            <asp:Button ID="btnSubmitAg" CssClass="btn btn-success" runat="server" Visible="false" Text="Submit" OnClick="btnSubmit_Click" />
        </div>
    </div>
</asp:Content>

