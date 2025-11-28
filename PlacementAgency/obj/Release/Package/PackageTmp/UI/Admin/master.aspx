<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master.aspx.cs" Inherits="PlacementAgency.UI.Admin.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        /* ---------- Base ---------- */
        .card .card-body { padding: 1rem; }

        .field-group .input-group {
            display: flex;
            align-items: center;
            gap: 0;
        }

        /* left label "pill" */
        .field-group .input-group-text.label {
            width: 110px;                /* narrower so input has more room */
            min-width: 110px;
            background: #f1f5f8;
            border: 1px solid #d6e1ea;
            font-weight: 600;
            color: #16324a;
            justify-content: flex-start;
            padding-left: .75rem;
            display: inline-flex;
            align-items: center;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        /* input */
        .field-group .form-control,
        .field-group .form-select {
            height: 44px;
            padding: .375rem .6rem;
            border-left: 0;
            border-right: 0;
            border-top: 1px solid #d6e1ea;
            border-bottom: 1px solid #d6e1ea;
            border-radius: 0;
            box-shadow: none;
            -webkit-appearance: none;
            appearance: none;
            background: white;
        }

        /* percent suffix (less intrusive) */
        .field-group .input-group-text.suffix {
            width: 48px;
            min-width: 48px;
            max-width: 48px;
            justify-content: center;
            background: #f1f5f8;
            border: 1px solid #d6e1ea;
            font-weight: 600;
            color: #16324a;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        /* focus */
        .field-group .form-control:focus,
        .field-group .form-select:focus {
            outline: none;
            border-color: #b6d0e8;
            box-shadow: none;
        }

        /* spacing between columns */
        .field-group .col-md-4 { margin-bottom: .6rem; }

        /* Buttons desktop */
        .form-actions .btn { min-width: 120px; }

        /* ---------- Mobile: stacked, touch-first ---------- */
        @media (max-width: 767.98px) {
            .field-group .input-group {
                flex-direction: column;
                align-items: stretch;
                gap: .35rem;
            }

            /* label becomes full-width pill above input */
            .field-group .input-group-text.label {
                width: 100%;
                min-width: 0;
                border-radius: .45rem;
                padding: .6rem .75rem;
            }

            /* input becomes normal rounded box */
            .field-group .form-control,
            .field-group .form-select {
                border-left: 1px solid #d6e1ea;
                border-right: 1px solid #d6e1ea;
                border-radius: .375rem;
            }

            /* suffix moves underneath input and right aligned */
            .field-group .input-group-text.suffix {
                width: 100%;
                min-width: 0;
                text-align: right;
                padding: .45rem .75rem;
                border-radius: .35rem;
            }

            /* buttons full width and stacked */
            .form-actions { display: flex; flex-direction: column-reverse; gap: .5rem; }
            .form-actions .btn { width: 100%; }
        }

        /* Very small phones tweak */
        @media (max-width: 360px) {
            .field-group .input-group-text.label { padding-left: .5rem; padding-right: .5rem; }
        }
    </style>

    <div class="card">
        <div class="card-header">Add/Update New Record</div>

        <div class="card-body">
            <div class="container">
                <div class="row g-3">

                    <!-- FY (no suffix) -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-calendar"></i>&nbsp;FY</span>
                            <asp:DropDownList ID="ddlFYAg" runat="server" CssClass="form-select" />
                        </div>
                    </div>

                    <!-- ESIC -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-percent"></i>&nbsp;ESIC</span>
                            <asp:TextBox ID="txtheadcount" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- EPF -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-percent"></i>&nbsp;EPF</span>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- Agency Charges -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-gear"></i>&nbsp;Agency</span>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- Add CGST -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-plus-square"></i>&nbsp;Add CGST</span>
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- Less TDS -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-dash-square"></i>&nbsp;Less TDS</span>
                            <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- Less CGST -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-arrow-left"></i>&nbsp;Less CGST</span>
                            <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- Less SGST -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-arrow-right"></i>&nbsp;Less SGST</span>
                            <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                    <!-- Add SGST -->
                    <div class="col-12 col-md-4 field-group">
                        <div class="input-group">
                            <span class="input-group-text label"><i class="bi bi-plus"></i>&nbsp;Add SGST</span>
                            <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" TextMode="Number"
                                         inputmode="decimal" oninput="this.value=this.value.replace(/[^0-9.]/g,'');" />
                            <span class="input-group-text suffix">%</span>
                        </div>
                    </div>

                </div> <!-- /.row -->

                <!-- Buttons -->
                <div class="row mt-4">
                    <div class="col-12 d-flex justify-content-end form-actions">
                        <asp:Button ID="btnSubmit" CssClass="btn btn-success me-2" Text="Submit" runat="server" />
                        <asp:Button ID="btnCancel" CssClass="btn btn-secondary" Text="Cancel" runat="server" />
                    </div>
                </div>
            </div> <!-- /.container -->
        </div> <!-- /.card-body -->
    </div> <!-- /.card -->
</asp:Content>




