<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PlacementAgency.Login.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <%: Scripts.Render("~/bundles/modernizr") %>
     <webopt:BundleReference runat="server" Path="~/Content/css" />
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container text-center ">
        <div class="card text-center">
  <div class="card-header">
   Login
  </div>
  <div class="card-body">
   <div class="mb-3 row">
  <label for="staticEmail" class="col-sm-2 col-form-label">UserID</label>
  <div class="col-sm-10">
      <asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
  </div>
</div>
<div class="mb-3 row">
  <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
  <div class="col-sm-10">
      <asp:TextBox ID="TextBox2" runat="server" class="form-control"></asp:TextBox>
  </div>
</div>
  </div>
  <div class="card-footer text-body-secondary">
      <asp:Button ID="btnSubmit" runat="server" Text="Login" />
       <asp:Button ID="btnCancel" runat="server" Text="Clear" />
  </div>
</div>
            </div>
    </form>
     <%: Scripts.Render("~/Scripts/bootstrap.js") %>
</body>
</html>
