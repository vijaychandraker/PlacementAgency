<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_AdminDashboard.aspx.cs" Inherits="PlacementAgency.UI.Admin.csmcl_AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <div class="container mt-4">
    <div class="row text-center">

      <!-- Total Zone -->
      <div class="col">
        <div class="card text-bg-primary mb-3" style="max-width: 18rem;">
          <div class="card-body">
            <h5 class="card-title">
              <i class="bi bi-geo-alt-fill me-2"></i> Total Zone
            </h5>
            <p class="card-text fs-4 fw-bold">10</p>
          </div>
        </div>
      </div>

      <!-- Total Agency -->
      <div class="col">
        <div class="card text-bg-secondary mb-3" style="max-width: 18rem;">
          <div class="card-body">
            <h5 class="card-title">
              <i class="bi bi-building-fill me-2"></i> Total Agency
            </h5>
            <p class="card-text fs-4 fw-bold">10</p>
          </div>
        </div>
      </div>

      <!-- Total District -->
      <div class="col">
        <div class="card text-bg-success mb-3" style="max-width: 18rem;">
          <div class="card-body">
            <h5 class="card-title">
              <i class="bi bi-map-fill me-2"></i> Total District
            </h5>
            <p class="card-text fs-4 fw-bold">33</p>
          </div>
        </div>
      </div>

      <!-- Total Manpower -->
      <div class="col">
        <div class="card text-bg-danger mb-3" style="max-width: 18rem;">
          <div class="card-body">
            <h5 class="card-title">
              <i class="bi bi-people-fill me-2"></i> Total Manpower
            </h5>
            <p class="card-text fs-4 fw-bold">3726</p>
          </div>
        </div>
      </div>

    </div>
  </div>
</asp:Content>
