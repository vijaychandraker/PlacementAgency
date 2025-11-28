<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PlacementAgency.UI.Dashboard.Dashboard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .card-color-1 {
            background: linear-gradient(135deg, #ff6a88, #ff99ac);
            box-shadow: 0 4px 18px rgba(255, 105, 135, 0.45);
        }

        .card-color-2 {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            box-shadow: 0 4px 18px rgba(79, 172, 254, 0.45);
        }

        .card-color-3 {
            background: linear-gradient(135deg, #43e97b, #38f9d7);
            box-shadow: 0 4px 18px rgba(67, 233, 123, 0.45);
        }

        .card-color-4 {
            background: linear-gradient(135deg, #fa709a, #fee140);
            box-shadow: 0 4px 18px rgba(250, 112, 154, 0.45);
        }

        .dashboard-wrapper {
            padding: 0.5rem 0.25rem 1.5rem;
        }

        .dashboard-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

            .dashboard-header-title {
                display: flex;
                align-items: center;
                gap: .65rem;
            }

            .dashboard-header h2 {
                margin: 0;
                font-size: 1.35rem;
                font-weight: 600;
            }

            .dashboard-header small {
                display: block;
                color: #6c757d;
                font-size: .8rem;
            }

        .dashboard-section-title {
            font-size: .9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .06em;
            color: #6c757d;
            margin-bottom: .25rem;
        }

        #cardsSection {
            margin-bottom: 1.5rem;
        }

        #tablesSection .card-title {
            font-weight: 600;
        }

        #tablesSection table {
            font-size: .85rem;
        }
    </style>
    <div class="dashboard-wrapper">
        <div class="dashboard-header">
            <div class="dashboard-header-title">
                <i class="bi bi-speedometer2 fs-4 text-primary"></i>
                <div>
                    <h2>Dashboard Overview</h2>
                    <small>Key statistics, charts and approval tracking</small>
                </div>
            </div>
        </div>

        <div class="dashboard-section-title">Summary</div>
        <!-- Cards -->
        <section id="cardsSection" class="mb-4">
        <div class="row g-3">
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card card-stats shadow-sm glass-card card-color-1">
                    <div class="card-body">
                        <div>
                            <h6 class="text-uppercase text-muted">Total Zone</h6>
                            <h3 class="mb-0">12</h3>
                        </div>
                        <div class="text-end">
                            <i class="bi bi-grid-3x3-gap fs-2"></i>
                        </div>
                    </div>
                </div>
            </div>


            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card card-stats shadow-sm glass-card card-color-2">
                    <div class="card-body">
                        <div>
                            <h6 class="text-uppercase text-muted">Total Agency</h6>
                            <h3 class="mb-0">12</h3>
                        </div>
                        <div class="text-end">
                            <i class="bi bi-building fs-2"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card card-stats shadow-sm glass-card card-color-3">
                    <div class="card-body">
                        <div>
                            <h6 class="text-uppercase text-muted">Total District</h6>
                            <h3 class="mb-0">33</h3>
                        </div>
                        <div class="text-end">
                            <i class="bi bi-geo-alt fs-2"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card card-stats shadow-sm glass-card card-color-4">
                    <div class="card-body">
                        <div>
                            <h6 class="text-uppercase text-muted">Total ManPower</h6>
                            <h3 class="mb-0">3726</h3>
                        </div>
                        <div class="text-end">
                            <i class="bi bi-people fs-2"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </section>
    </div>
    <!-- Charts -->
    <section class="row mb-4">
        <div class="container-fluid mt-3">
            <div class="row g-3">

                <!-- Bar Chart -->
                <div class="col-lg-8">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Zone Wise Total Manpower FY 2025-26</h5>
                            <canvas id="myBarChart" style="height: 380px;"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Donut Chart -->
                <div class="col-lg-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Post Wise Total</h5>
                            <canvas id="donutChart" style="height: 980px;"></canvas>

                            <div class="mt-2">
                                <span class="badge" style="background: rgba(0, 200, 150, 0.8);">Legal Officer</span>
                                <span class="badge" style="background: #ff6384;">Asst. Grade-03</span>
                                <span class="badge" style="background: #36a2eb;">Chief Salesman</span>
                                <span class="badge" style="background: #ffcd56;">Salesman</span>
                                <span class="badge" style="background: #9966ff;">MPW (Office)</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        </section>

        <div class="dashboard-section-title">Payment Approval Status</div>
        <!-- Table -->
        <section id="tablesSection" class="mb-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <h6 class="card-title">Payment Approvel Track</h6>
                <div class="table-responsive">
                    <table class="table table-hover table-sm align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>District Name</th>
                                <th>Dist Opt</th>
                                <th>District</th>
                                <th>Agency</th>
                                <th>District</th>
                                <th>State</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Raipur</td>
                                <td><span class="badge bg-success">Sumitted</span></td>
                                 <td><span class="badge bg-success">Approve</span></td>
                                <td><span class="badge bg-success">Approve</span></td>
                                <td><span class="badge bg-success">Approve</span></td>
                                 <td><span class="badge bg-warning text-dark">Pending</span></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Balodabazar-Bhatapara</td>
                                <td><span class="badge bg-warning">Not Submitted</span></td>
                                <td><span">-</span></td>
                                <td><span>-</span></td>
                                <td><span>-</span></td>
                                  <td><span>-</span></td>
                            </tr>
                            <!-- more rows... -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- DataLabels Plugin -->
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
    <script>
        // IMPORTANT: Register plugin
        Chart.register(ChartDataLabels);
        const ctx = document.getElementById('myBarChart').getContext('2d');
        const myBarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["Zone1", "Zone2", "Zone3", "Zone4", "Zone5", "Zone6", "Zone7", "Zone8", "Zone9", "Zone10", "Zone11", "Zone12"],
                datasets: [{
                    label: "Sales",
                    data: [595, 254, 377, 257, 242, 267, 293, 231, 297, 281, 275, 260],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(153, 102, 255, 0.8)',
                        'rgba(255, 159, 64, 0.8)',
                        'rgba(255, 140, 180, 0.8)',
                        'rgba(0, 200, 150, 0.8)',
                        'rgba(120, 94, 240, 0.8)',
                        'rgba(255, 80, 80, 0.8)',
                        'rgba(0, 180, 255, 0.8)',
                        'rgba(255, 220, 100, 0.8)'
                    ],
                    borderWidth: 1,
                    borderColor: '#fff',
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false },
                    datalabels: {
                        anchor: 'end',
                        align: 'top',
                        color: '#000',
                        font: { weight: 'bold', size: 12 },
                        formatter: (value) => value
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 700,
                        grid: { display: false }      // ← remove Y-axis gridlines
                    },
                    x: {
                        grid: { display: false }      // ← remove X-axis gridlines
                    }
                }
            }
        });
    </script>
    <script>
        const ctx2 = document.getElementById('donutChart').getContext('2d');
        new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ["Legal Officer", "Asst. Grade-03", "Chief Salesman", "Salesman", "MPW (Office)"],
                datasets: [{
                    data: [1, 25, 728, 2230, 741],
                    backgroundColor: [
                        'rgba(0, 200, 150, 0.8)',
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(153, 102, 255, 0.8)'
                    ],
                    borderWidth: 1,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                cutout: "50%"   // donut hole size
            }
        });
    </script>
   <%-- <script>
        Chart.register(ChartDataLabels);
        const ctx3 = document.getElementById('donutChart').getContext('2d');
        const myBarChart3 = new Chart(ctx3, {
            type: 'bar',
            data: {
                labels: [
                    "Zone1", "Zone2", "Zone3", "Zone4", "Zone5", "Zone6",
                    "Zone7", "Zone8", "Zone9", "Zone10", "Zone11", "Zone12"
                ],
                datasets: [{
                    label: "Sales",
                    data: [595, 254, 377, 257, 242, 267, 293, 231, 297, 281, 275, 260],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(153, 102, 255, 0.8)',
                        'rgba(255, 159, 64, 0.8)',
                        'rgba(255, 140, 180, 0.8)',
                        'rgba(0, 200, 150, 0.8)',
                        'rgba(120, 94, 240, 0.8)',
                        'rgba(255, 80, 80, 0.8)',
                        'rgba(0, 180, 255, 0.8)',
                        'rgba(255, 220, 100, 0.8)'
                    ],
                    borderColor: '#fff',
                    borderWidth: 1,

                }]
            },
            options: {
                responsive: true,
                indexAxis: 'y',
                plugins: {
                    legend: { display: false },
                    datalabels: {
                        anchor: 'end',
                        align: 'top',
                        color: '#000',
                        font: { weight: 'bold', size: 12 },
                        formatter: (value) => value}},
                scales: {
                    x:{
                        beginAtZero: true,
                        max: 700
                    },
                    y: {
                        ticks: {
                            autoSkip: false
                        }
                    }
                }
            }
        });
    </script>--%>
</asp:Content>
