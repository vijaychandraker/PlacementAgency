<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_ratemaster.aspx.cs" Inherits="PlacementAgency.UI.Dashboard.csmcl_ratemaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <!-- Bootstrap Icons CDN (remove if already included in MasterPage) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

  <style>
    /* Row container that aligns label + control horizontally */
    .form-row-item { display: flex; align-items: center; gap: 12px; }

    /* Fixed label width so labels align vertically in each column */
    .form-row-item .field-label {
      width: 140px;          /* adjust if needed */
      text-align: right;
      padding-right: 10px;
      font-weight: 600;
      white-space: nowrap;
    }

    /* Uniform icon box and control heights */
    .input-group .input-group-text {
      width: 44px;
      min-width: 44px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
      background: #f4f6f8;
    }

    .input-group .form-select,
    .input-group .form-control {
      min-height: 44px;
      height: 44px;
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
    }

    /* Let the input-group stretch to fill the remaining space */
    .form-row-item .input-group { flex: 1; }

    /* Blank column keeps height for symmetry */
    .blank-col { min-height: 44px; }

    /* Buttons */
    .btn { min-width: 100px; }

    /* Responsive: on small screens labels stack above controls */
    @media (max-width: 575.98px) {
      .form-row-item { flex-direction: column; align-items: stretch; gap: 6px; }
      .form-row-item .field-label { width: auto; text-align: left; padding-right: 0; }
      .input-group .input-group-text { width: 40px; min-width: 40px; }
      .input-group .form-control, .input-group .form-select { height: 42px; min-height: 42px; }
    }
  </style>

  <div class="card">
    <h5 class="card-header alert alert-success mb-0">Add Per Month Rate</h5>
    <div class="card-body">
      <div class="container">

        <!-- Row 1 -->
        <div class="row mb-3">
          <div class="col-md-6">
            <div class="form-row-item">
              <span class="field-label">FY <span class="text-danger">*</span></span>
              <div class="input-group">
                <span class="input-group-text" title="Financial Year"><i class="bi bi-calendar-range"></i></span>
                <asp:DropDownList ID="ddlFY" runat="server"
                   CssClass="form-select"
                  aria-label="Financial Year"></asp:DropDownList>
              </div>
            </div>
          </div>

          <div class="col-md-6">
             <div class="form-row-item">
   <span class="field-label">Location <span class="text-danger">*</span></span>
   <div class="input-group">
     <span class="input-group-text" title="Location"><i class="bi bi-geo-alt"></i></span>
     <asp:DropDownList ID="ddllocation" runat="server" CssClass="form-select" aria-label="Location"></asp:DropDownList>
   </div>
 </div>
          </div>
        </div>

        <!-- Row 2 -->
        <div class="row mb-3">
          <div class="col-md-6">
           <div class="form-row-item">
  <span class="field-label">Category <span class="text-danger">*</span></span>
  <div class="input-group">
    <span class="input-group-text" title="Category"><i class="bi bi-tags"></i></span>
    <asp:DropDownList ID="ddlcategory" runat="server" CssClass="form-select" aria-label="Category"></asp:DropDownList>
  </div>
</div>
          </div>

          <div class="col-md-6">
             <div class="form-row-item">
   <span class="field-label">Rate Type <span class="text-danger">*</span></span>
   <div class="input-group">
     <span class="input-group-text" title="Rate Type"><i class="bi bi-currency-rupee"></i></span>
     <asp:DropDownList ID="ddlrtype" runat="server" CssClass="form-select" aria-label="Rate Type"></asp:DropDownList>
   </div>
 </div>
          </div>
        </div>

        <!-- Row 3 -->
        <div class="row mb-3">
          <div class="col-md-6">
           <div class="form-row-item">
  <span class="field-label">Amount <span class="text-danger">*</span></span>
  <div class="input-group">
    <span class="input-group-text" title="Head Count"><i class="bi bi-currency-rupee"></i></span>
    <asp:TextBox ID="txtheadcount" runat="server" TextMode="Number" CssClass="form-control" aria-label="Total Head Count"></asp:TextBox>
  </div>
</div>
          </div>

          <div class="col-md-6">
            
          </div>
        </div>

        <!-- Row 4 -->
      

        <!-- Buttons -->
        <div class="row mt-4">
          <div class="col-md-12 text-center">
            <asp:Button ID="btnSubmit" CssClass="btn btn-success me-2" runat="server" Text="Submit" />
            <asp:Button ID="btnreset" CssClass="btn btn-secondary" runat="server" Text="Reset" />
          </div>
        </div>

      </div> <!-- container -->
    </div> <!-- card-body -->
  </div> <!-- card -->
    <br />
    <div class="card">
  <h5 class="card-header alert alert-success mb-0">Report</h5>
  <div class="card-body">
   <asp:GridView ID="gv_ratemsater"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped"
    DataKeyNames="RtypeID"
    OnRowEditing="gv_ratemsater_RowEditing"
    OnRowUpdating="gv_ratemsater_RowUpdating"
    OnRowCancelingEdit="gv_ratemsater_RowCancelingEdit"
    OnRowDeleting="gv_ratemsater_RowDeleting"
    OnRowDataBound="gv_ratemsater_RowDataBound">

    <Columns>

        <asp:BoundField DataField="FY" HeaderText="Financial Year" ReadOnly="true" />

      
        <asp:TemplateField HeaderText="Category">
            <ItemTemplate>
                <%# Eval("CategoryName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlEditCategory"
                    runat="server"
                    CssClass="form-select"
                    DataTextField="CategoryName"
                    DataValueField="CategoryID">
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

       
        <asp:TemplateField HeaderText="Location">
            <ItemTemplate>
                <%# Eval("LocationName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlEditLocation"
                    runat="server"
                    CssClass="form-select"
                    DataTextField="LocationName"
                    DataValueField="LocationID">
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

   
        <asp:TemplateField HeaderText="Rate Type">
            <ItemTemplate>
                <%# Eval("RateTypeName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlEditRateType"
                    runat="server"
                    CssClass="form-select"
                    DataTextField="RateTypeName"
                    DataValueField="RtypeID">
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

       
        <asp:TemplateField HeaderText="Amount">
            <ItemTemplate>
                <%# Eval("Amount","{0:N2}") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditAmount"
                    runat="server"
                    CssClass="form-control"
                    Text='<%# Bind("Amount") %>'>
                </asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:LinkButton ID="lnkEdit"
                    runat="server"
                    CommandName="Edit"
                    CssClass="btn btn-sm btn-outline-primary me-1">
                    <i class="bi bi-pencil-square"></i> Edit
                </asp:LinkButton>
                <asp:LinkButton ID="lnkDelete"
                    runat="server"
                    CommandName="Delete"
                    CssClass="btn btn-sm btn-outline-danger"
                    OnClientClick="return confirm('Are you sure you want to delete this record?');">
                    <i class="bi bi-trash"></i> Delete
                </asp:LinkButton>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:LinkButton ID="lnkUpdate"
                    runat="server"
                    CommandName="Update"
                    CssClass="btn btn-sm btn-success me-1">
                    <i class="bi bi-check-circle"></i> Update
                </asp:LinkButton>
                <asp:LinkButton ID="lnkCancel"
                    runat="server"
                    CommandName="Cancel"
                    CssClass="btn btn-sm btn-secondary">
                    <i class="bi bi-x-circle"></i> Cancel
                </asp:LinkButton>
            </EditItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>


      </div>
  </div>








</asp:Content>
