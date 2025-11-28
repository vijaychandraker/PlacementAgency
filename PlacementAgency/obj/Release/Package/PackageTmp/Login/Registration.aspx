<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="PlacementAgency.Login.Registration" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - PlacementAgency</title>

    <%: Scripts.Render("~/bundles/modernizr") %>
    <webopt:BundleReference runat="server" Path="~/Content/css" />

    <!-- Bootstrap Icons (already included by you) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

   
</head>
<body >
    <form id="form1" runat="server" style="width:100%;display:flex;justify-content:center;" class="w-100">
       
            <div class="glass-card">
                <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-12">

                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Create New User</h5>
                    </div>

                    <div class="card-body">

                        <div class="mb-3">
                            <label class="form-label">Full Name *</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Username *</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password *</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mobile</label>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" TextMode="Phone" MaxLength="15" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Role *</label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>

                        <div class="mb-3 form-check">
                            <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label">Active</label>
                        </div>

                        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>

                        <div class="d-grid mt-3">
                            <asp:Button ID="btnSave" runat="server" Text="Save User" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
        </div>
    </form>

    <!-- scripts -->
    <%: Scripts.Render("~/bundles/jquery") %>
    <%: Scripts.Render("~/Scripts/bootstrap.js") %>

    
</body>
</html>

