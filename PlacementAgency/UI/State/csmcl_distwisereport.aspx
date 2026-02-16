<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_distwisereport.aspx.cs" Inherits="PlacementAgency.UI.State.csmcl_distwisereport" %>
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
 <asp:Button ID="btnclr" runat="server" Text="Clear" CssClass="btn btn-warning" />
 <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn btn-primary ms-2" OnClientClick="printElement('<%= maincont.ClientID %>','<%= ddldistrictAgent.ClientID %>','<%= ddlFYAg.ClientID %>','<%= ddlMonthAg.ClientID %>'); return false;" CausesValidation="false" />
 </div>

 </div>
 </div>
 </div>
 </div>

 <asp:Label ID="lblmsg" runat="server" Text="Label" Visible="false"></asp:Label>
 <br />
 <asp:Panel ID="maincont" runat="server" CssClass="card" Visible="false">
<div class="card-header alert alert-success">
 Search Record
</div>
<div class="card-body">
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
 <td>0.10%</td>
 <td>
 <asp:Label ID="lblTDSAg" runat="server"></asp:Label></td>
 </tr>
 <tr>
 <td colspan="3">LESS : CGST  on  (E) </td>
 <td>1%</td>
 <td>
 <asp:Label ID="lblLessCGSTAg" runat="server"></asp:Label></td>
 </tr>
 <tr>
 <td colspan="3">LESS : SGST  on (E) </td>
 <td>1%</td>
 <td>
 <asp:Label ID="lblLessSGSTAg" runat="server"></asp:Label></td>
 </tr>
 <tr class="alert alert-secondary fw-bold">
 <td colspan="4">GRAND TOTAL - (Rounded off)</td>
 <td>
 <asp:Label ID="lblRoundedTotalAg" runat="server"></asp:Label></td>
 </tr>

 </table>

 </div>
 </div>
</asp:Panel>
 <br />
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
       <div class="card" runat="server" id="document" visible="false">
       <div class="card-header alert alert-warning">
           Approved
       </div>

       <div class="card-body">
           <div class="container">

               <!-- Row 1 - EPF -->
               <div class="row mb-3 align-items-center alert alert-secondary">
                   <label class="col-md-3 col-form-label">1. EPF</label>

                   <div class="col-md-3">
                       <asp:LinkButton ID="lnkEPF" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                       <asp:Label ID="lblEPFAgComment" runat="server" Text="Comment"></asp:Label>
                   </div>

                  

                   <div class="col-md-3">
                       <asp:TextBox ID="txtepf" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                   </div>
               </div>

               <!-- Row 2 - ESIR -->
               <div class="row mb-3 align-items-center alert alert-secondary">
                   <label class="col-md-3 col-form-label">2. ESIR</label>

                   <div class="col-md-3">
                       <asp:LinkButton ID="lnkESIR" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                       <asp:Label ID="lblESIRAgComment" runat="server" Text="Comment"></asp:Label>
                   </div>

                  

                   <div class="col-md-3">
                       <asp:TextBox ID="txtesir" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                   </div>
               </div>

               <!-- Row 3 - GST -->
               <div class="row mb-3 align-items-center alert alert-secondary">
                   <label class="col-md-3 col-form-label">3. GST</label>

                   <div class="col-md-3">
                       <asp:LinkButton ID="lnkGST" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                       <asp:Label ID="lblGSTAgComment" runat="server" Text="Comment"></asp:Label>
                   </div>

                  

                   <div class="col-md-3">
                       <asp:TextBox ID="txtgst" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                   </div>
               </div>

               <!-- Row 4 - Name of Employees -->
               <div class="row mb-3 align-items-center alert alert-secondary">
                   <label class="col-md-3 col-form-label">4. Name of Employees</label>

                   <div class="col-md-3">
                       <asp:LinkButton ID="lnkNEmployees" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                       <asp:Label ID="lblNEmployeeAgComment" runat="server" Text="Comment"></asp:Label>
                   </div>

                  

                   <div class="col-md-3">
                       <asp:TextBox ID="txtnemply" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                   </div>
               </div>

               <!-- Row 5 - Salary Payment Cert -->
               <div class="row mb-3 align-items-center alert alert-secondary">
                   <label class="col-md-3 col-form-label">5. Employees Salary Payment Certificate</label>

                   <div class="col-md-3">
                       <asp:LinkButton ID="lnkESPC" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                       <asp:Label ID="lblESPCAgComment" runat="server" Text="Comment"></asp:Label>
                   </div>

                 

                   <div class="col-md-3">
                       <asp:TextBox ID="txtespc" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                   </div>
               </div>

               <!-- Row 6 - SOP -->
               <div class="row mb-3 align-items-center alert alert-secondary">
                   <label class="col-md-3 col-form-label">6. SOP</label>



                   <div class="col-md-3">
                       <asp:LinkButton ID="lnkSOP" runat="server" CssClass="form-label" OnClick="lnk_Click"></asp:LinkButton><br />
                       <asp:Label ID="lblSOPAgComment" runat="server" Text="Comment"></asp:Label>
                   </div>

                

                   <div class="col-md-3">
                       <asp:TextBox ID="txtsop" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
                   </div>
               </div>
               <asp:Label ID="lblMessage" runat="server" />
               <!-- Buttons -->
               

           </div>
       </div>
   </div>
          </ContentTemplate>
</asp:UpdatePanel>
   <!-- File Preview Modal -->
   <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
       <div class="modal-dialog modal-xl modal-dialog-centered">
           <div class="modal-content">

               <div class="modal-header bg-primary text-white">
                   <h5 class="modal-title">Document Preview</h5>
                   <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
               </div>

               <div class="modal-body text-center">

                   <iframe id="previewFrame" style="width: 100%; height: 80vh; display: none;" frameborder="0"></iframe>

                   <img id="previewImage" style="max-width:100%; max-height:80vh; display: none;" />

 </div>

 </div>
 </div>
 </div>

 <script>
 function showPdfPreview(src) {
 document.getElementById("previewImage").style.display = "none";
 document.getElementById("previewFrame").style.display = "block";
 document.getElementById("previewFrame").src = src;

 var modal = new bootstrap.Modal(document.getElementById('previewModal'));
 modal.show();
 }

 function showImagePreview(src) {
 document.getElementById("previewFrame").style.display = "none";
 document.getElementById("previewImage").style.display = "block";
 document.getElementById("previewImage").src = src;

 var modal = new bootstrap.Modal(document.getElementById('previewModal'));
 modal.show();
 }

 // Print the contents of an element by id (preserves page styles)
 function printElement(id, districtId, fyId, monthId) {
 var el = document.getElementById(id);
 if (!el) {
 alert('Nothing to print. Element with id "' + id + '" not found.');
 return;
 }

 // read filter text values
 var districtText = '';
 var fyText = '';
 var monthText = '';
 try { districtText = document.getElementById(districtId).options[document.getElementById(districtId).selectedIndex].text; } catch(e){}
 try { fyText = document.getElementById(fyId).options[document.getElementById(fyId).selectedIndex].text; } catch(e){}
 try { monthText = document.getElementById(monthId).options[document.getElementById(monthId).selectedIndex].text; } catch(e){}

 // Clone the element so we can remove items that should not be printed
 var clone = el.cloneNode(true);
 try {
 // Remove any headers with the exact classes used for the green 'Search Record' bars
 var headers = clone.querySelectorAll('.card-header.alert.alert-success');
 headers.forEach(function(h) { if (h && h.parentNode) h.parentNode.removeChild(h); });
 } catch(e) { /* ignore */ }

 // Gather styles from the current page
 var styles = '';
 var nodes = document.querySelectorAll('link[rel="stylesheet"], style');
 nodes.forEach(function(n) { styles += n.outerHTML; });

 var printWindow = window.open('', '_blank');
 printWindow.document.open();
 printWindow.document.write('<!doctype html><html><head><meta charset="utf-8" /><title>Print</title>' + styles + '</head><body>');

 // Add header with selected filters
 printWindow.document.write('<div style="margin-bottom:12px; font-family:inherit;">');
 printWindow.document.write('<strong>District:</strong> ' + districtText + ' &nbsp;&nbsp; ');
 printWindow.document.write('<strong>FY:</strong> ' + fyText + ' &nbsp;&nbsp; ');
 printWindow.document.write('<strong>Month:</strong> ' + monthText + '</div>');

 // Write cloned content (without removed headers)
 printWindow.document.write(clone.innerHTML);
 printWindow.document.write('</body></html>');
 printWindow.document.close();
 printWindow.focus();

 // Delay print slightly to ensure resources/styles are applied
 setTimeout(function() {
 printWindow.print();
 // optionally close after printing
 // printWindow.close();
 },250);
 }
 </script>
</asp:Content>
