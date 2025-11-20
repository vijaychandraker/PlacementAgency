<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApproveDocument.aspx.cs" Inherits="PlacementAgency.UI.Dist.ApproveDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container text-center">
    <div class="row g-3">
        <!-- FY -->
        <div class="col-md-3">
            <label for="ddlFYAg" class="form-label">FY</label>
            <asp:DropDownList ID="ddlFYAg" runat="server" AutoPostBack="true"
                CssClass="form-select">
            </asp:DropDownList>
        </div>
        <!-- Month -->
        <div class="col-md-3">
            <label for="ddlMonthAg" class="form-label">Month</label>
            <asp:DropDownList ID="ddlMonthAg" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlMonthAg_SelectedIndexChanged"></asp:DropDownList>
        </div>

        <!-- Button -->
        <div class="col-md-3 d-flex align-items-end">
            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary w-100"/>
        </div>
    </div>
</div>
    <br />
    <br />
        <div class="card">
    <div class="card-header">
        Add/Update New Record
    </div>

    <div class="card-body">
        <div class="container">
  <!-- Row 1 -->
  <div class="row mb-3 align-items-center">
    <label class="col-md-3 col-form-label">1. EPF</label>

    <div class="col-md-3">
      <asp:Label ID="Label1" runat="server" Text="Uploaded Document" CssClass="form-label"></asp:Label>
    </div>

    <div class="col-md-3">
      <asp:DropDownList ID="ddlEPF" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlEPF_SelectedIndexChanged">
        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="col-md-3">
      <asp:TextBox ID="txtepf" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
    </div>
  </div>

  <!-- Row 2 -->
  <div class="row mb-3 align-items-center">
    <label class="col-md-3 col-form-label">2. ESIR</label>

    <div class="col-md-3">
      <asp:Label ID="Label2" runat="server" Text="Uploaded Document" CssClass="form-label" ></asp:Label>
    </div>

    <div class="col-md-3">
      <asp:DropDownList ID="ddlESIR" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlESIR_SelectedIndexChanged">
        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="col-md-3">
      <asp:TextBox ID="txtesir" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
    </div>
  </div>

  <!-- Row 3 -->
  <div class="row mb-3 align-items-center">
    <label class="col-md-3 col-form-label">3. GST</label>

    <div class="col-md-3">
      <asp:Label ID="Label3" runat="server" Text="Uploaded Document" CssClass="form-label"></asp:Label>
    </div>

    <div class="col-md-3">
      <asp:DropDownList ID="ddlGST" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlGST_SelectedIndexChanged">
        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="col-md-3">
      <asp:TextBox ID="txtgst" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
    </div>
  </div>

  <!-- Row 4 -->
  <div class="row mb-3 align-items-center">
    <label class="col-md-3 col-form-label">4. Name of Employees</label>

    <div class="col-md-3">
      <asp:Label ID="Label4" runat="server" Text="Uploaded Document" CssClass="form-label" ></asp:Label>
    </div>

    <div class="col-md-3">
      <asp:DropDownList ID="ddlNEmpoy" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlNEmpoy_SelectedIndexChanged">
        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="col-md-3">
      <asp:TextBox ID="txtnemply" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
    </div>
  </div>

  <!-- Row 5 -->
  <div class="row mb-3 align-items-center">
    <label class="col-md-3 col-form-label">5. Employees Salary Payment Certificate</label>

    <div class="col-md-3">
      <asp:Label ID="Label5" runat="server" Text="Uploaded Document" CssClass="form-label"></asp:Label>
    </div>

    <div class="col-md-3">
      <asp:DropDownList ID="ddlspcerti" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlspcerti_SelectedIndexChanged">
        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="col-md-3">
      <asp:TextBox ID="txtespc" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
    </div>
  </div>

  <!-- Row 6 -->
  <div class="row mb-3 align-items-center">
    <label class="col-md-3 col-form-label">6. SOP</label>

    <div class="col-md-3">
      <asp:Label ID="Label6" runat="server" Text="Uploaded Document" CssClass="form-label"></asp:Label>
    </div>

    <div class="col-md-3">
      <asp:DropDownList ID="ddlSOP" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlSOP_SelectedIndexChanged">
        <asp:ListItem Text="Select Action" Value=""></asp:ListItem>
        <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
        <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="col-md-3">
      <asp:TextBox ID="txtsop" runat="server" CssClass="form-control" Visible="false" TextMode="MultiLine" Placeholder="Comment"></asp:TextBox>
    </div>
  </div>

  <!-- Buttons -->
  <div class="row mt-4">
    <div class="col-12 text-end">
      <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success me-2" Text="Submit" />
      <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" />
    </div>
  </div>
</div>

</div>
            </div>
</asp:Content>
