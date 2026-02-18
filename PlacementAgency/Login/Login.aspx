<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PlacementAgency.Login.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - PlacementAgency</title>

    <%: Scripts.Render("~/bundles/modernizr") %>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

    <style>
        :root {
            --bg-top: #e9f4ff;
            --bg-bottom: #d8ebff;
            --panel-bg: #ffffff;
            --line: #d2e3f4;
            --title: #16324d;
            --muted: #5f7891;
            --primary: #0d6efd;
            --primary-dark: #0b5ed7;
            --brand-1: #1f8ef1;
            --brand-2: #00a896;
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

        .login-layout {
            min-height: 100vh;
            display: grid;
            grid-template-columns: 1.05fr .95fr;
        }

        .brand-panel {
            position: relative;
            overflow: hidden;
            padding: 2.25rem 2.35rem;
            background: radial-gradient(circle at 20% 20%, rgba(31, 142, 241, .19), transparent 40%), radial-gradient(circle at 75% 70%, rgba(0, 168, 150, .19), transparent 45%), linear-gradient(160deg, #f5faff 0%, #e7f2ff 100%);
            border-right: 1px solid #d5e6f7;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand-badge {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(145deg, var(--brand-1), var(--brand-2));
            color: #fff;
            font-size: 1.35rem;
            box-shadow: 0 14px 26px rgba(13, 110, 253, .24);
            margin-bottom: 1rem;
        }

        .brand-title {
            margin: 0;
            font-size: 1.85rem;
            line-height: 1.2;
            font-weight: 800;
            color: #13314d;
            max-width: 520px;
        }

        .brand-sub {
            margin-top: .75rem;
            color: var(--muted);
            max-width: 520px;
            line-height: 1.55;
            font-size: .95rem;
        }

        .brand-meta {
            margin-top: 1.25rem;
            display: flex;
            flex-wrap: wrap;
            gap: .5rem;
        }

        .meta-pill {
            border-radius: 999px;
            border: 1px solid #c6ddf3;
            background: rgba(255,255,255,.72);
            color: #264761;
            padding: .32rem .7rem;
            font-size: .76rem;
            font-weight: 700;
        }

        .form-panel-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.35rem;
        }

        .form-panel {
            width: 100%;
            max-width: 430px;
            border: 1px solid var(--line);
            border-radius: 18px;
            background: var(--panel-bg);
            box-shadow: 0 18px 38px rgba(22, 50, 77, .11);
            padding: 1.35rem 1.2rem 1.2rem;
        }

        .form-head {
            text-align: center;
            margin-bottom: .95rem;
        }

        .form-head h4 {
            margin: 0;
            font-weight: 800;
            color: #16324d;
            letter-spacing: .01em;
        }

        .form-head p {
            margin: .35rem 0 0;
            color: var(--muted);
            font-size: .85rem;
        }

        .input-group-text {
            border-right: 0;
            background: #f4f8fd;
            border-color: #d5e3f1;
            color: #31597c;
        }

        .form-control {
            border-left: 0;
            border-color: #d5e3f1;
            box-shadow: none !important;
        }

        .form-control:focus {
            border-color: #b8d2ec;
        }

        .captcha-box {
            border: 1px dashed #c9dcf0;
            border-radius: 10px;
            background: #f8fbff;
            padding: .7rem;
            text-align: center;
        }

        .captcha-box img {
            max-width: 170px;
            width: 100%;
            height: auto;
            border-radius: 6px;
            border: 1px solid #d5e3f1;
            background: #fff;
        }

        .captcha-link {
            display: inline-flex;
            align-items: center;
            gap: .3rem;
            color: #1a64a8;
            font-size: .8rem;
            font-weight: 700;
            text-decoration: none;
            margin-top: .45rem;
        }

        .captcha-link:hover {
            color: #0f4f87;
            text-decoration: underline;
        }

        .btn-signin {
            border-radius: 10px;
            font-weight: 700;
            padding: .56rem .85rem;
            background: linear-gradient(145deg, var(--primary), var(--primary-dark));
            border: 0;
        }

        .remember-row {
            font-size: .84rem;
            color: var(--muted);
        }

        .summary-error {
            margin-bottom: .65rem;
            padding: .55rem .7rem;
            border-radius: 8px;
            border: 1px solid #f4c8cd;
            background: #fff5f6;
            color: #9b1c1c;
            font-size: .82rem;
        }

        @media (max-width: 991.98px) {
            .login-layout {
                grid-template-columns: 1fr;
            }

            .brand-panel {
                display: none;
            }

            .form-panel-wrap {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-layout">
            <section class="brand-panel">
                <span class="brand-badge"><i class="bi bi-briefcase-fill"></i></span>
                <h1 class="brand-title">Placement Agency Management System</h1>
                <p class="brand-sub">Secure access for district, agency and state users to manage manpower, payroll approvals and operational reporting.</p>
                <div class="brand-meta">
                    <span class="meta-pill"><i class="bi bi-shield-lock me-1"></i>Secure Login</span>
                    <span class="meta-pill"><i class="bi bi-speedometer2 me-1"></i>Unified Dashboard</span>
                    <span class="meta-pill"><i class="bi bi-diagram-3 me-1"></i>Role Based Access</span>
                </div>
            </section>

            <section class="form-panel-wrap">
                <div class="form-panel">
                    <div class="form-head">
                        <h4>Sign In</h4>
                        <p>Enter your credentials and captcha to continue.</p>
                    </div>

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="summary-error" />

                    <div class="mb-3 input-group">
                        <span class="input-group-text"><i class="bi bi-person-circle"></i></span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Username or Email" />
                    </div>

                    <div class="mb-3 input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password" />
                    </div>

                    <div class="mb-3 captcha-box">
                        <asp:Image ID="imgCaptcha" runat="server" ImageUrl='<%= ResolveUrl("~/helpers/Captcha.ashx") %>' AlternateText="captcha" />
                        <div>
                            <a href="javascript:void(0)" class="captcha-link" onclick="refreshCaptcha(); return false;">
                                <i class="bi bi-arrow-clockwise"></i>Refresh Captcha
                            </a>
                        </div>
                    </div>

                    <div class="mb-3 input-group">
                        <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                        <asp:TextBox ID="txtCaptcha" runat="server" CssClass="form-control" placeholder="Enter Captcha" />
                    </div>

                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-2 text-danger small" />

                    <div class="d-grid mb-2">
                        <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="btn btn-primary btn-signin" OnClick="btnSignIn_Click" />
                    </div>

                    <div class="remember-row">
                        <div class="form-check">
                            <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label" for="<%= chkRemember.ClientID %>">Remember me</label>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </form>

    <%: Scripts.Render("~/bundles/jquery") %>
    <%: Scripts.Render("~/Scripts/bootstrap.js") %>

    <script type="text/javascript">
        function refreshCaptcha() {
            var img = document.getElementById('<%= imgCaptcha.ClientID %>');
            if (!img) return;
            img.src = '<%= ResolveUrl("~/helpers/Captcha.ashx") %>?t=' + new Date().getTime();
        }
    </script>
</body>
</html>
