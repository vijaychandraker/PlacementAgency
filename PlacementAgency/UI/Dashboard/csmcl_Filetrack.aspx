<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_Filetrack.aspx.cs" Inherits="PlacementAgency.UI.Dashboard.csmcl_Filetrack" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        :root {
            --trk-bg: linear-gradient(180deg, #f6fbff 0%, #ffffff 100%);
            --trk-line: #d7e6f6;
            --trk-text: #19324d;
            --trk-muted: #5f7892;
            --trk-done-bg: #dcfce7;
            --trk-done-fg: #166534;
            --trk-pending-bg: #fee2e2;
            --trk-pending-fg: #b91c1c;
            --trk-chip-bg: #e8f3ff;
            --trk-chip-fg: #11446f;
        }

        .track-shell {
            background: var(--trk-bg);
            border: 1px solid #dbe9f7;
            border-radius: 16px;
            padding: 1rem;
        }

        .track-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: .6rem;
            flex-wrap: wrap;
            border: 1px solid #dbe9f7;
            background: #f5faff;
            border-radius: 12px;
            padding: .75rem .9rem;
            margin-bottom: .95rem;
        }

        .track-title {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--trk-text);
        }

        .track-sub {
            margin: .1rem 0 0;
            color: var(--trk-muted);
            font-size: .85rem;
        }

        .district-chip {
            border-radius: 999px;
            border: 1px solid #c8ddf3;
            background: var(--trk-chip-bg);
            color: var(--trk-chip-fg);
            padding: .35rem .7rem;
            font-size: .8rem;
            font-weight: 700;
            white-space: nowrap;
        }

        .track-card {
            border: 1px solid #d7e5f4;
            border-radius: 14px;
            background: #fff;
            box-shadow: 0 10px 26px rgba(21, 66, 108, .08);
            padding: 1rem;
        }

        .timeline-wrap {
            position: relative;
        }

        .timeline-wrap::before {
            content: "";
            position: absolute;
            left: 29px;
            top: 10px;
            bottom: 10px;
            width: 2px;
            background: var(--trk-line);
        }

        .timeline-step {
            position: relative;
            display: grid;
            grid-template-columns: 58px 1fr;
            gap: .85rem;
            padding: .35rem 0 .95rem;
        }

        .timeline-step:last-child {
            padding-bottom: 0;
        }

        .step-icon {
            width: 58px;
            height: 58px;
            border-radius: 14px;
            border: 1px solid #d8e5f3;
            background: #f4f8fd;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            z-index: 2;
        }

        .timeline-step.done .step-icon {
            background: #e9fced;
            border-color: #9de6b0;
        }

        .step-dot {
            position: absolute;
            left: 23px;
            top: 48px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            border: 2px solid #b7cae0;
            background: #fff;
            z-index: 3;
        }

        .timeline-step.done .step-dot {
            border-color: #16a34a;
            background: #16a34a;
        }

        .step-icon svg {
            width: 30px;
            height: 30px;
            stroke: #6a839d;
        }

        .timeline-step.done .step-icon svg {
            stroke: #15803d;
        }

        .step-title {
            margin: 0;
            color: var(--trk-text);
            font-size: .98rem;
            font-weight: 700;
        }

        .step-meta {
            margin-top: .25rem;
            display: flex;
            flex-wrap: wrap;
            gap: .4rem;
            color: var(--trk-muted);
            font-size: .8rem;
        }

        .step-pill {
            border-radius: 999px;
            padding: .2rem .6rem;
            font-size: .75rem;
            font-weight: 700;
            display: inline-block;
        }

        .step-pill.done {
            background: var(--trk-done-bg);
            color: var(--trk-done-fg);
        }

        .step-pill.pending {
            background: var(--trk-pending-bg);
            color: var(--trk-pending-fg);
        }

        @media (max-width: 767.98px) {
            .track-shell {
                padding: .75rem;
            }

            .timeline-wrap::before {
                left: 23px;
            }

            .timeline-step {
                grid-template-columns: 46px 1fr;
                gap: .65rem;
            }

            .step-icon {
                width: 46px;
                height: 46px;
            }

            .step-icon svg {
                width: 24px;
                height: 24px;
            }

            .step-dot {
                left: 16px;
                top: 39px;
            }
        }
    </style>
    <div class="track-shell">
        <div class="track-head">
            <div>
                <h3 class="track-title"><i class="bi bi-diagram-3-fill me-2"></i>File Tracking Timeline</h3>
                <p class="track-sub">End-to-end approval movement for selected district.</p>
            </div>
            <span class="district-chip">
                District:
                <%= Server.HtmlEncode(
                        !string.IsNullOrWhiteSpace(Request.QueryString["District_Name"])
                            ? Request.QueryString["District_Name"]
                            : (string.IsNullOrWhiteSpace(Request.QueryString["District_ID"]) ? "N/A" : Request.QueryString["District_ID"])
                    ) %>
            </span>
        </div>

        <div class="track-card">
            <div class="timeline-wrap">
                <div class="timeline-step done">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-2"></path>
                            <polyline points="7 9 12 4 17 9"></polyline>
                            <line x1="12" y1="4" x2="12" y2="16"></line>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Submitted By Operator</p>
                        <div class="step-meta">
                            <span>09 Aug 2025, 10:00am</span>
                            <span>Days: 2</span>
                            <span class="step-pill done">Completed</span>
                            <span>Comment: Verified upload</span>
                        </div>
                    </div>
                </div>

                <div class="timeline-step done">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 1l3 5 5 .5-4 4 1 5-5-2-5 2 1-5-4-4 5-.5z"></path>
                            <polyline points="9 12 12 15 17 10"></polyline>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Approved By District Head</p>
                        <div class="step-meta">
                            <span>09 Aug 2025, 10:30am</span>
                            <span>Days: 2</span>
                            <span class="step-pill done">Completed</span>
                            <span>Comment: Approved</span>
                        </div>
                    </div>
                </div>

                <div class="timeline-step done">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 1l9 4v6c0 5-3.5 9-9 11C6.5 20 3 16 3 11V5l9-4z"></path>
                            <polyline points="8 11 11 14 16 9"></polyline>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Approved By Agency</p>
                        <div class="step-meta">
                            <span>09 Aug 2025, 12:00pm</span>
                            <span>Days: 2</span>
                            <span class="step-pill done">Completed</span>
                            <span>Comment: Forwarded to district</span>
                        </div>
                    </div>
                </div>

                <div class="timeline-step done">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 2h14l2 4v16l-4-2-4 2-4-2-4 2z"></path>
                            <polyline points="9 14 12 17 18 11"></polyline>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Agency Document Approved By District Head</p>
                        <div class="step-meta">
                            <span>10 Aug 2025, 03:00pm</span>
                            <span>Days: 2</span>
                            <span class="step-pill done">Completed</span>
                            <span>Comment: Checked and approved</span>
                        </div>
                    </div>
                </div>

                <div class="timeline-step done">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M3 21h18"></path>
                            <path d="M5 21V9l7-6 7 6v12"></path>
                            <polyline points="10 14 12 16 16 12"></polyline>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Approved By State</p>
                        <div class="step-meta">
                            <span>10 Aug 2025, 01:00pm</span>
                            <span>Days: 2</span>
                            <span class="step-pill done">Completed</span>
                            <span>Comment: State approval done</span>
                        </div>
                    </div>
                </div>

                <div class="timeline-step">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="1" x2="12" y2="23"></line>
                            <path d="M17 5H9a3 3 0 0 0 0 6h6a3 3 0 0 1 0 6H7"></path>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Payment Released</p>
                        <div class="step-meta">
                            <span>12 Aug 2025, 08:00pm</span>
                            <span>Days: 2</span>
                            <span class="step-pill pending">Pending</span>
                            <span>Comment: Awaiting release</span>
                        </div>
                    </div>
                </div>

                <div class="timeline-step">
                    <div class="step-icon">
                        <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 2h14l2 4v16l-4-2-4 2-4-2-4 2z"></path>
                            <polyline points="9 9 12 12 17 7"></polyline>
                        </svg>
                    </div>
                    <span class="step-dot"></span>
                    <div>
                        <p class="step-title">Uploaded Approved Invoice</p>
                        <div class="step-meta">
                            <span>12 Aug 2025, 09:00pm</span>
                            <span>Days: 2</span>
                            <span class="step-pill pending">Pending</span>
                            <span>Comment: Not uploaded yet</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

