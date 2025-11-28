<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PlacementAgency.Login.Login" %>

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

    <style>
        :root {
            --bg1: #0f2027;
            --bg2: #203a43;
            --bg3: #2c5364;
            --glass-bg: rgba(255,255,255,0.06);
            --glass-border: rgba(255,255,255,0.08);
        }
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--bg1), var(--bg2), var(--bg3));
            color: #fff;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial;
        }
        .login-box {
            width: 100%;
            max-width: 440px;
            margin: 16px;
        }
        .glass-card {
            background: linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0.02));
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
            border-radius: 12px;
            padding: 22px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.45);
        }
        .glass-input {
            background: transparent;
            border: 1px solid rgba(255,255,255,0.12);
            color: #fff;
        }
        .glass-input::placeholder { color: rgba(255,255,255,0.6); }
        .glass-addon {
            background: transparent;
            border-left: 0;
            color: rgba(255,255,255,0.9);
        }
        .glass-btn {
            width: 100%;
            padding: 10px 14px;
            border-radius: 8px;
        }
        .captcha-wrap img { max-width: 180px; height: auto; border-radius: 6px; border: 1px solid rgba(255,255,255,0.08); }
        .helper-links { font-size: 0.9rem; color: rgba(255,255,255,0.75); }
        .text-muted-light { color: rgba(255,255,255,0.6); }
    </style>
</head>
<body style="
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
">
    <form id="form1" runat="server" style="width:100%;display:flex;justify-content:center;" class="w-100">
        <div class="login-box">
            <div class="glass-card">
                <div class="text-center mb-3">
                    <!-- Optional logo -->
                    <img src="<%= ResolveUrl("~/Content/images/logo.png") %>" alt="Logo" style="max-height:48px; display:block; margin:0 auto 8px;" onerror="this.style.display='none'" />
                    <h4 class="mb-0">Login</h4>
                   
                </div>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger mb-2" />

                <!-- Email -->
                <div class="mb-3 input-group">
                    <span class="input-group-text glass-addon"><i class="bi bi-envelope-fill"></i></span>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control glass-input" placeholder="Email" TextMode="Email" />
                </div>

                <!-- Password -->
                <div class="mb-3 input-group">
                    <span class="input-group-text glass-addon"><i class="bi bi-lock-fill"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control glass-input" placeholder="Password" TextMode="Password" />
                </div>

                <!-- Captcha -->
                <div class="mb-3 text-center captcha-wrap">
                    <asp:Image ID="imgCaptcha" runat="server" ImageUrl='<%= ResolveUrl("~/helpers/Captcha.ashx") %>' AlternateText="captcha" CssClass="mb-2" />
                    <div class="d-flex justify-content-center gap-2">
                        <a href="javascript:void(0)" class="helper-links" onclick="refreshCaptcha(); return false;">Refresh</a>
                        
                    </div>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text glass-addon"><i class="bi bi-shield-lock-fill"></i></span>
                    <asp:TextBox ID="txtCaptcha" runat="server" CssClass="form-control glass-input" Placeholder="Enter Captcha" />
                </div>

                <!-- Server message -->
                <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-2" />

                <!-- Submit -->
                <div class="d-grid gap-2 mb-2">
                    <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="btn btn-primary glass-btn" OnClick="btnSignIn_Click" />
                </div>

                <div class="d-flex justify-content-between align-items-center mt-2">
                    <div class="form-check">
                        <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label text-muted-light" for="<%= chkRemember.ClientID %>">Remember me</label>
                    </div>
                   
                </div>
            </div>
        </div>
    </form>

    <!-- scripts -->
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
