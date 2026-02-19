<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PlacementAgency.UI.Dashboard.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        :root {
            --dash-bg: linear-gradient(180deg, #f5f9ff 0%, #eef6ff 55%, #fdfefe 100%);
            --panel-bg: #ffffff;
            --text-main: #19324d;
            --text-muted: #5b7289;
            --line-soft: #dbe7f3;
            --accent-1: #1f8ef1;
            --accent-2: #00a896;
            --accent-3: #f59f00;
            --accent-4: #f76707;
        }

        .dashboard-shell {
            background: var(--dash-bg);
            border: 1px solid #e6eef7;
            border-radius: 16px;
            padding: 1.1rem;
        }

        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            background: linear-gradient(135deg, #eff6ff 0%, #e7f8ff 100%);
            border: 1px solid #d9e7f5;
            border-radius: 14px;
            padding: .95rem 1.1rem;
            margin-bottom: 1rem;
            animation: rise .45s ease-out;
        }

        .hero h2 {
            margin: 0;
            font-size: 1.35rem;
            color: var(--text-main);
            font-weight: 700;
        }

        .hero p {
            margin: .1rem 0 0;
            color: var(--text-muted);
            font-size: .88rem;
        }

        .hero-badge {
            background: #fff;
            border: 1px solid #d8e8f8;
            color: #2f4f6d;
            border-radius: 999px;
            padding: .35rem .75rem;
            font-size: .78rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .kpi-card {
            border: 0;
            border-radius: 14px;
            color: #fff;
            overflow: hidden;
            position: relative;
            min-height: 118px;
            animation: rise .45s ease-out;
        }

        .kpi-card .card-body {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: .6rem;
        }

        .kpi-title {
            margin: 0 0 .2rem;
            text-transform: uppercase;
            letter-spacing: .05em;
            font-size: .72rem;
            font-weight: 700;
            opacity: .95;
        }

        .kpi-value {
            margin: 0;
            font-size: 1.5rem;
            line-height: 1.1;
            font-weight: 800;
        }

        .kpi-icon {
            font-size: 2rem;
            opacity: .9;
        }

        .kpi-1 {
            background: linear-gradient(135deg, #0ea5e9, #2563eb);
            box-shadow: 0 12px 24px rgba(37, 99, 235, .28);
        }

        .kpi-2 {
            background: linear-gradient(135deg, #00a896, #2dc653);
            box-shadow: 0 12px 24px rgba(45, 198, 83, .24);
        }

        .kpi-3 {
            background: linear-gradient(135deg, #f59f00, #f76707);
            box-shadow: 0 12px 24px rgba(245, 159, 0, .24);
        }

        .kpi-4 {
            background: linear-gradient(135deg, #ef4444, #f43f5e);
            box-shadow: 0 12px 24px rgba(244, 63, 94, .24);
        }

        .panel-card {
            border: 1px solid var(--line-soft);
            border-radius: 14px;
            box-shadow: 0 8px 22px rgba(16, 58, 97, .06);
            animation: rise .55s ease-out;
        }

        .panel-card .card-title {
            margin-bottom: .25rem;
            font-weight: 700;
            font-size: 1rem;
            color: var(--text-main);
        }

        .panel-sub {
            color: var(--text-muted);
            font-size: .8rem;
            margin-bottom: .8rem;
        }

        .chart-wrap {
            position: relative;
            height: 330px;
        }

        .chart-wrap-sm {
            position: relative;
            height: 330px;
        }

        .legend-chips {
            display: flex;
            flex-wrap: wrap;
            gap: .4rem;
            margin-top: .75rem;
        }

        .legend-chip {
            border-radius: 999px;
            padding: .25rem .55rem;
            font-size: .74rem;
            font-weight: 600;
            color: #fff;
        }

        .approval-table thead th {
            font-size: .79rem;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: .04em;
        }

        .approval-table tbody td {
            font-size: .84rem;
            vertical-align: middle;
        }

        .status-pill {
            border-radius: 999px;
            padding: .2rem .55rem;
            font-size: .72rem;
            font-weight: 700;
            display: inline-block;
        }

        .status-ok {
            background: #d1fae5;
            color: #065f46;
        }

        .status-pending {
            background: #fee2e2;
            color: #b91c1c;
        }

        .status-na {
            background: #e5e7eb;
            color: #374151;
        }

        .gv-pager {
            text-align: left;
            background: #f8fbff;
            padding-left: .55rem;
        }

        .gv-pager table {
            margin: .35rem 0;
            border-collapse: separate;
            border-spacing: 6px 0;
        }

        .gv-pager td {
            border: 0 !important;
            padding: 0;
        }

        .gv-pager a,
        .gv-pager span {
            display: inline-block;
            min-width: 34px;
            height: 34px;
            line-height: 34px;
            text-align: center;
            border-radius: 10px;
            font-size: .83rem;
            font-weight: 700;
            text-decoration: none;
            border: 1px solid #cfe1f3;
            background: #ffffff;
            color: #15507d;
            padding: 0 .45rem;
        }

        .gv-pager a:hover {
            background: #e7f3ff;
            border-color: #9ec6e8;
            color: #0e3f64;
        }

        .gv-pager span {
            background: #1f8ef1;
            border-color: #1f8ef1;
            color: #fff;
        }

        @keyframes rise {
            from {
                opacity: 0;
                transform: translateY(8px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 767.98px) {
            .dashboard-shell {
                padding: .75rem;
            }

            .hero {
                flex-direction: column;
                align-items: flex-start;
            }

            .chart-wrap,
            .chart-wrap-sm {
                height: 280px;
            }
        }
    </style>

    <div class="dashboard-shell">
        <div class="hero">
            <div>
                <h2><i class="bi bi-speedometer2 me-2"></i>Dashboard Overview</h2>
                <p>Snapshot of zone, agency, district manpower and payment workflow status.</p>
            </div>
            <span class="hero-badge"><i class="bi bi-calendar-week me-1"></i>FY 2025-26</span>
        </div>

        <section class="mb-4">
            <div class="row g-3">
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card kpi-card kpi-1">
                        <div class="card-body">
                            <div>
                                <p class="kpi-title">Total Zone</p>
                                <h3 class="kpi-value">12</h3>
                            </div>
                            <i class="bi bi-grid-3x3-gap-fill kpi-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card kpi-card kpi-2">
                        <div class="card-body">
                            <div>
                                <p class="kpi-title">Total Agency</p>
                                <h3 class="kpi-value">12</h3>
                            </div>
                            <i class="bi bi-building kpi-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card kpi-card kpi-3">
                        <div class="card-body">
                            <div>
                                <p class="kpi-title">Total District</p>
                                <h3 class="kpi-value">33</h3>
                            </div>
                            <i class="bi bi-geo-alt-fill kpi-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card kpi-card kpi-4">
                        <div class="card-body">
                            <div>
                                <p class="kpi-title">Total Manpower</p>
                                <h3 class="kpi-value">3726</h3>
                            </div>
                            <i class="bi bi-people-fill kpi-icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="mb-4">
            <div class="row g-3">
                <div class="col-lg-8">
                    <div class="card panel-card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Zone Wise Total Manpower</h5>
                            <p class="panel-sub">Comparative manpower distribution by zone for FY 2025-26</p>
                            <div class="chart-wrap">
                                <canvas id="myBarChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card panel-card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Post Wise Total</h5>
                            <p class="panel-sub">Current manpower split by post category</p>
                            <div class="chart-wrap-sm">
                                <canvas id="donutChart"></canvas>
                            </div>
                            <div class="legend-chips">
                                <span class="legend-chip" style="background:#00a896;">Legal Officer</span>
                                <span class="legend-chip" style="background:#ef4444;">Asst. Grade-03</span>
                                <span class="legend-chip" style="background:#1f8ef1;">Chief Salesman</span>
                                <span class="legend-chip" style="background:#f59f00;">Salesman</span>
                                <span class="legend-chip" style="background:#8b5cf6;">MPW (Office)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section>
            <div class="card panel-card">
                <div class="card-body">
                    <h5 class="card-title">Payment Approval Track (<asp:Label ID="lblmonth" runat="server"></asp:Label>)</h5>
                    <p class="panel-sub">District to state approval progression overview </p>
                 

   <asp:GridView ID="GV_approveStatus"
    runat="server"
    AutoGenerateColumns="False"
    AllowPaging="True"
    PageSize="5"
    OnPageIndexChanging="GV_approveStatus_PageIndexChanging"
    CssClass="table table-bordered table-striped approval-table"
    DataKeyNames="District_ID">
    <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />
    <PagerStyle CssClass="gv-pager" />

    <Columns>
        <asp:BoundField DataField="Zone_Name" HeaderText="Zone_Name" ReadOnly="true" />
        <asp:HyperLinkField
            HeaderText="District_Name"
            DataTextField="District_Name"
            DataNavigateUrlFields="District_ID,District_Name"
            DataNavigateUrlFormatString="~/UI/Dashboard/csmcl_Filetrack.aspx?District_ID={0}&District_Name={1}" />
        <asp:TemplateField HeaderText="Final Approve">
            <ItemTemplate>
                <span class='<%# Convert.ToString(Eval("ApproveByDishead")) == "5" ? "status-pill status-ok" : "status-pill status-pending" %>'>
                    <%# Convert.ToString(Eval("ApproveByDishead")) == "5" ? "Approved" : "Pending" %>
                </span>
            </ItemTemplate>
        </asp:TemplateField>
      
       
    </Columns>

</asp:GridView>



                </div>
            </div>
        </section>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
    <script>
        Chart.register(ChartDataLabels);

        const barCtx = document.getElementById('myBarChart').getContext('2d');
        new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: ["Zone1", "Zone2", "Zone3", "Zone4", "Zone5", "Zone6", "Zone7", "Zone8", "Zone9", "Zone10", "Zone11", "Zone12"],
                datasets: [{
                    label: "Manpower",
                    data: [595, 254, 377, 257, 242, 267, 293, 231, 297, 281, 275, 260],
                    backgroundColor: [
                        'rgba(31, 142, 241, 0.82)',
                        'rgba(0, 168, 150, 0.82)',
                        'rgba(245, 159, 0, 0.82)',
                        'rgba(247, 103, 7, 0.82)',
                        'rgba(14, 165, 233, 0.82)',
                        'rgba(239, 68, 68, 0.82)',
                        'rgba(21, 128, 61, 0.82)',
                        'rgba(2, 132, 199, 0.82)',
                        'rgba(251, 146, 60, 0.82)',
                        'rgba(132, 204, 22, 0.82)',
                        'rgba(217, 70, 239, 0.82)',
                        'rgba(59, 130, 246, 0.82)'
                    ],
                    borderRadius: 6,
                    borderSkipped: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    datalabels: {
                        anchor: 'end',
                        align: 'end',
                        color: '#0f172a',
                        font: { weight: '700', size: 11 },
                        formatter: (value) => value
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 700,
                        grid: { color: 'rgba(148, 163, 184, 0.18)' }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        });

        const donutCtx = document.getElementById('donutChart').getContext('2d');
        new Chart(donutCtx, {
            type: 'doughnut',
            data: {
                labels: ["Legal Officer", "Asst. Grade-03", "Chief Salesman", "Salesman", "MPW (Office)"],
                datasets: [{
                    data: [1, 25, 728, 2230, 741],
                    backgroundColor: [
                        'rgba(0, 168, 150, 0.88)',
                        'rgba(239, 68, 68, 0.88)',
                        'rgba(31, 142, 241, 0.88)',
                        'rgba(245, 159, 0, 0.88)',
                        'rgba(139, 92, 246, 0.88)'
                    ],
                    borderColor: '#fff',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                cutout: "58%"
            }
        });
    </script>
</asp:Content>
