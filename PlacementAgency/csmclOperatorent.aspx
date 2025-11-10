<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmclOperatorent.aspx.cs" Inherits="PlacementAgency.csmclOperatorent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">










    <div class="card" style="width: 100%;">
        <div class="card-body">

            <h5 class="card-title alert alert-primary">Month/OT/Day Duties Entry</h5>

            <div class="container text-center">
                <div class="row">
                    <div class="col">

                        <label for="month">Select Month:</label>
                        <select id="month" name="month" class="form-select">
                            <option value="">-- Select Month --</option>
                            <option value="1">January</option>
                            <option value="2">February</option>
                            <option value="3">March</option>
                            <option value="4">April</option>
                            <option value="5">May</option>
                            <option value="6">June</option>
                            <option value="7">July</option>
                            <option value="8">August</option>
                            <option value="9">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                    </div>
                    <div class="col">

                        <label for="month">Select Location:</label>
                        <select id="Location" name="Location" class="form-select">
                            <option value="">-- Select Location --</option>
                            <option value="1">Shop</option>
                            <option value="2">Office</option>

                        </select>
                    </div>
                    <div class="col">

                        <label for="month">Select Category:</label>
                        <select id="Category" name="Category" class="form-select">
                            <option value="">-- Select Category --</option>
                            <option value="1">CHIEF SALESMAN</option>
                            <option value="2">SALESMAN</option>
                            <option value="3">MULTIPURPOSE</option>

                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col">

                        <label for="month">Select RateType:</label>
                        <select id="RateType" name="RateType" class="form-select">
                            <option value="">-- Select RateType --</option>
                            <option value="1">Month</option>
                            <option value="2">OT</option>
                            <option value="3">Day</option>
                        </select>
                    </div>
                    <div class="col">

                        <label for="month">Enter Number of Duties:</label>
                        <input type="text" id="duties" name="duties" class="form-control" placeholder="Enter duties count" />

                    </div>
                    <div class="col">
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                    </div>
                    <div class="col">
                    </div>
                    <div class="col">
                        <button type="submit" class="btn btn-success">Submit</button>&nbsp&nbsp&nbsp
                        <button type="submit" class="btn btn-warning">Reset</button>
                    </div>

                </div>
            </div>




        </div>
    </div>
</asp:Content>
