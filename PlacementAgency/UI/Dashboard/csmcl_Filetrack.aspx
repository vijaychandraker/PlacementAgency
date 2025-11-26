<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="csmcl_Filetrack.aspx.cs" Inherits="PlacementAgency.UI.Dashboard.csmcl_Filetrack" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        
       

        .tracking-container {
            background: white;
            border-radius: 12px;
            padding: 40px;
            max-width: 500px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .tracking-item {
            display: flex;
            align-items: flex-start;
            position: relative;
            padding-bottom: 40px;
        }

        .tracking-item:last-child {
            padding-bottom: 0;
        }

        .icon-container {
            width: 45px;
            height: 45px;
            background: #f0f0f0;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            z-index: 2;
            position: relative;
        }

        .tracking-item.completed .icon-container {
            background: #e8f5e9;
        }

        .icon-container svg {
            width: 24px;
            height: 24px;
            stroke: #999;
        }

        .tracking-item.completed .icon-container svg {
            stroke: #4caf50;
        }

        .timeline {
            position: absolute;
            left: 22px;
            top: 45px;
            width: 2px;
            height: calc(100% - 5px);
            background: #e0e0e0;
            z-index: 1;
        }

        .tracking-item.completed .timeline {
            background: #4caf50;
        }

        .status-indicator {
            position: absolute;
            left: 54px;
            top: 15px;
            width: 14px;
            height: 14px;
            background: white;
            border: 3px solid #e0e0e0;
            border-radius: 50%;
            z-index: 3;
        }

        .tracking-item.completed .status-indicator {
            background: #4caf50;
            border-color: #4caf50;
        }

        .tracking-info {
            margin-left: 50px;
            flex: 1;
        }

        .tracking-title {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 4px;
        }

        .tracking-item.completed .tracking-title {
            color: #2e7d32;
        }

        .tracking-date {
            font-size: 13px;
            color: #999;
        }

        .tracking-item.completed .tracking-date {
            color: #66bb6a;
        }
    </style>
 
    
          <div class="card">
<div class="card-header alert alert-success">
  Search Record
</div>
<div class="card-body">
    <div class="container text-center">
    <div class="row g-3">

        <!-- District -->
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-geo-alt-fill"></i>&nbsp; District</span>
                <asp:DropDownList ID="ddldistrictAgent" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- FY -->
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-calendar-range"></i>&nbsp; FY</span>
                <asp:DropDownList ID="ddlFYAg" runat="server" CssClass="form-select" ></asp:DropDownList>
            </div>
        </div>

        <!-- Month -->
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-calendar3"></i>&nbsp; Month</span>
                <asp:DropDownList ID="ddlMonthAg" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
        </div>

        <!-- Submit Button -->
        <div class="col-md-3 d-flex align-items-end">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success"  />&nbsp
            <asp:Button ID="btnclr" runat="server" Text="Submit" CssClass="btn btn-warning" />
        </div>

    </div>
        </div>
    </div>
              </div>

    <br />
    
          <div class="card">
  <div class="card-header alert alert-success">Track File</div>
  <div class="card-body">

    <style>
      .tracking-container-horizontal {
        background: white;
        border-radius: 12px;
        padding: 24px;
        width: 100%;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        position: relative;
        overflow: visible;
      }

      .timeline-bar {
        position: absolute;
        left: 44px;
        right: 44px;
        top: 58px;
        height: 4px;
        background: #e0e0e0;
        border-radius: 2px;
        z-index: 1;
      }

      .timeline-steps {
        display: flex;
        justify-content: space-between;
        gap: 14px;
        z-index: 2;
        position: relative;
      }

      .timeline-step {
        flex: 1;
        max-width: 230px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
      }

      .timeline-step .icon-container {
        width: 58px;
        height: 58px;
        border-radius: 10px;
        background: #f0f0f0;
        display:flex;
        align-items:center;
        justify-content:center;
        box-shadow: 0 2px 6px rgba(0,0,0,0.06);
        position: relative;
        z-index: 3;
      }

      .timeline-step.completed .icon-container {
        background: #e8f5e9;
      }

      .timeline-step .icon-container svg {
        width: 30px;
        height: 30px;
        stroke: #999;
      }

      .timeline-step.completed .icon-container svg {
        stroke: #4caf50;
      }

      .timeline-step .status-indicator {
        position: absolute;
        top: 59px;
        left: 50%;
        transform: translateX(-50%);
        width: 16px;
        height: 16px;
        background: white;
        border: 3px solid #e0e0e0;
        border-radius: 50%;
        z-index: 4;
      }

      .timeline-step.completed .status-indicator {
        background: #4caf50;
        border-color: #4caf50;
      }

      .timeline-step .step-title {
        margin-top: 14px;
        font-weight: 600;
        font-size: 14px;
        color: #333;
      }

      .timeline-step.completed .step-title {
        color: #2e7d32;
      }

      .timeline-step .step-date,
      .timeline-step .step-days,
      .timeline-step .step-comment {
        font-size: 12px;
        color: #777;
        margin-top: 4px;
      }

      @media (max-width: 768px) {
        .timeline-bar { display: none; }
        .timeline-steps {
          flex-direction: column;
          gap: 24px;
        }
        .timeline-step {
          flex-direction: row;
          text-align: left;
          max-width: 100%;
        }
        .timeline-step .step-title { margin-top: 0; }
        .timeline-step .icon-container {
          width: 48px;
          height: 48px;
        }
        .timeline-step .status-indicator {
          left: 60px;
          top: 15px;
          transform: none;
        }
      }
    </style>

    <div class="tracking-container-horizontal">
      <div class="timeline-bar"></div>

      <div class="timeline-steps">

        <!-- 1. Submitted By Operator -->
        <div class="timeline-step completed">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-2" />
              <polyline points="7 9 12 4 17 9" />
              <line x1="12" y1="4" x2="12" y2="16" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Submitted By Operator</div>
          <div class="step-date">09 Aug 2025, 10:00am</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

        <!-- 2. Approved By District Head -->
        <div class="timeline-step completed">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 1l3 5 5 .5-4 4 1 5-5-2-5 2 1-5-4-4 5-.5z" />
              <polyline points="9 12 12 15 17 10" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Approved By District Head</div>
          <div class="step-date">09 Aug 2025, 10:30am</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

        <!-- 3. Approved By Agency -->
        <div class="timeline-step completed">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 1l9 4v6c0 5-3.5 9-9 11C6.5 20 3 16 3 11V5l9-4z" />
              <polyline points="8 11 11 14 16 9" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Approved By Agency</div>
          <div class="step-date">09 Aug 2025, 12:00pm</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

        <!-- 4. Approve Agency Document District Head -->
        <div class="timeline-step completed">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M4 2h14l2 4v16l-4-2-4 2-4-2-4 2z" />
              <polyline points="9 14 12 17 18 11" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Approve Agency Document District Head</div>
          <div class="step-date">10 Aug 2025, 03:00pm</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

        <!-- 5. Approved By State -->
        <div class="timeline-step completed">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M3 21h18" />
              <path d="M5 21V9l7-6 7 6v12" />
              <polyline points="10 14 12 16 16 12" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Approved By State</div>
          <div class="step-date">10 Aug 2025, 01:00pm</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

        <!-- 6. Payment Released -->
        <div class="timeline-step">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <line x1="12" y1="1" x2="12" y2="23" />
              <path d="M17 5H9a3 3 0 0 0 0 6h6a3 3 0 0 1 0 6H7" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Payment Released</div>
          <div class="step-date">12 Aug 2025, 08:00pm</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

        <!-- 7. Uploaded Approved Invoice -->
        <div class="timeline-step">
          <div class="icon-container">
            <svg fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M4 2h14l2 4v16l-4-2-4 2-4-2-4 2z" />
              <polyline points="9 9 12 12 17 7" />
            </svg>
          </div>
          <div class="status-indicator"></div>
          <div class="step-title">Uploaded Approved Invoice</div>
          <div class="step-date">12 Aug 2025, 09:00pm</div>
          <div class="step-days">Days 2</div>
          <div class="step-comment">Comment</div>
        </div>

      </div>
    </div>

  </div>
</div>


</asp:Content>

