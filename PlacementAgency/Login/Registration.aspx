<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="PlacementAgency.Login.Registration" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>User Registration - PlacementAgency</title>

    <%: Scripts.Render("~/bundles/modernizr") %>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

    <style>
        :root {
            --bg-top: #eaf5ff;
            --bg-bottom: #d7ebff;
            --panel: #ffffff;
            --line: #d2e3f4;
            --title: #16324d;
            --muted: #5f7891;
            --primary: #0d6efd;
        }

        html, body {
            height: 100%;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(160deg, var(--bg-top) 0%, var(--bg-bottom) 100%);
            color: var(--title);
        }

        .page-wrap {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .reg-card {
            width: 100%;
            max-width: 560px;
            border: 1px solid var(--line);
            border-radius: 18px;
            background: var(--panel);
            box-shadow: 0 18px 38px rgba(22, 50, 77, .11);
            overflow: hidden;
        }

        .reg-head {
            background: linear-gradient(135deg, #ebf5ff, #f4faff);
            border-bottom: 1px solid var(--line);
            padding: .95rem 1rem;
        }

        .reg-head h5 {
            margin: 0;
            font-weight: 800;
            color: #15324d;
            display: flex;
            align-items: center;
            gap: .5rem;
        }

        .reg-head p {
            margin: .2rem 0 0;
            font-size: .82rem;
            color: var(--muted);
        }

        .reg-body {
            padding: 1rem;
        }

        .form-label {
            font-size: .82rem;
            font-weight: 700;
            color: #35526f;
            margin-bottom: .35rem;
        }

        .form-control,
        .form-select {
            border-color: #d4e3f2;
            min-height: 40px;
            border-radius: 10px;
            box-shadow: none !important;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #a8caeb;
            box-shadow: 0 0 0 .2rem rgba(13, 110, 253, .11) !important;
        }

        .btn-save {
            border-radius: 10px;
            font-weight: 700;
            background: linear-gradient(145deg, var(--primary), #0b5ed7);
            border: 0;
            padding: .58rem .9rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrap">
            <div class="reg-card">
                <div class="reg-head">
                    <h5><i class="bi bi-person-plus-fill"></i>Create New User</h5>
                    <p>Fill details below to register a new application user.</p>
                </div>

                <div class="reg-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name *</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Username *</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Password *</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Mobile</label>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" TextMode="Phone" MaxLength="15" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Role *</label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-12">
                            <div class="form-check">
                                <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label">Active</label>
                            </div>
                        </div>

                        <div class="col-12">
                            <asp:Label ID="lblMsg" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>

                        <div class="col-12 d-grid">
                            <asp:Button ID="btnSave" runat="server" Text="Save User" CssClass="btn btn-primary btn-save" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <%: Scripts.Render("~/bundles/jquery") %>
    <%: Scripts.Render("~/Scripts/bootstrap.js") %>
</body>
</html>
