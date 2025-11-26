<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApproveDocument.aspx.cs" Inherits="PlacementAgency.UI.Dist.ApproveDocument" %>
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
                <asp:DropDownList ID="ddlFYAg" runat="server" AutoPostBack="true" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Month -->
        <div class="col-md-4">
            <div class="input-group mb-3">
                <label class="input-group-text">
                    <i class="bi bi-calendar3"></i>&nbsp; Month
                </label>
                <asp:DropDownList ID="ddlMonthAg" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlMonthAg_SelectedIndexChanged"
                    CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Buttons -->
        <div class="col-md-4 d-flex justify-content-center align-items-center">
            <asp:Button ID="Button1" runat="server" Text="Submit" class="btn btn-success me-2" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-info" />
        </div>

    </div>
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
