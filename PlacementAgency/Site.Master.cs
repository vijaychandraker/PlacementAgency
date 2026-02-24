using PlacementAgency.UI.Dashboard;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls; // <-- needed for HtmlControl
using System.Web.UI.WebControls;

namespace PlacementAgency
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetActiveMenuItem();
                lblusername.Text = Session["Username"] != null ? Session["Username"].ToString() : string.Empty;
                lbluserrole.Text = Session["RoleID"] == null
                ? ""
        : GetRoleName(Session["RoleID"].ToString());

                lbldistrict.Text = Session["DistrictName"] != null ? Session["DistrictName"].ToString() : string.Empty;
            }
            if (Session["RoleID"] != null)
            {
                string roleId = Session["RoleID"] != null ? Session["RoleID"].ToString() : string.Empty;
                switch (roleId)
                {
                    case "2": // DistrictUser
                        lidistapprovepayroll.Visible = false;
                        liagencyapprove.Visible = false;
                        lidashboard.Visible = true;
                        lireport.Visible = true;
                        lidistreport.Visible = true;
                        lipayrolentry.Visible = true;
                        break;

                    case "3": // DistrictAdmin
                        lidistapprovepayroll.Visible = true;
                        lidashboard.Visible = true;
                        lipayrolentry.Visible = false;
                        liapproveststus.Visible = false;
                        lireport.Visible = false;
                        lidistreport.Visible = true;
                        li5.Visible = true;
                        li2.Visible = true;
                        liagencyapprove.Visible = false;
                        break;

                    case "4": // Agency
                        liagencyapprove.Visible = true;
                        lidashboard.Visible = true;
                        lipayrolentry.Visible = false;
                        lidistapprovepayroll.Visible = false;
                        lidistreport.Visible = false;
                        lireport.Visible = false;
                        li4.Visible = true;
                        liapproveststus.Visible = false;
                        break;

                    case "5": // State Officer
                       
                        lidashboard.Visible = true;
                        li1.Visible = true;
                        li6.Visible = true;
                        li3.Visible = true;
                        li7.Visible = true;
                        lidistreport.Visible = false;
                        break;
                }
            }
        }
        private string GetRoleName(string roleId)
        {
            switch (roleId)
            {
                case "1": return "Admin";
                case "2": return "DistrictUser";
                case "3": return "DistrictAdmin";
                case "4": return "Agency";
                case "5": return "StateOfficer";
                default: return "Unknown";
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login/Login.aspx");
        }
        private void SetActiveMenuItem()
        {
            // Get current page filename (e.g. "csmcl_ratemaster.aspx")
            string current = Path.GetFileName(Request.Url.AbsolutePath ?? "").ToLowerInvariant();

            // mapping: page file name -> LI HtmlControl
            var map = new Dictionary<string, HtmlControl>(StringComparer.OrdinalIgnoreCase)
            {
                { "dashboard.aspx", lidashboard },
                { "default.aspx", lidashboard },

                { "distapprove.aspx", lidistapprovepayroll },
                { "dist_approve.aspx", lidistapprovepayroll },

                { "csmcl_agencyapprovel.aspx", liagencyapprove },
                { "csmcl_agencyapprove.aspx", liagencyapprove },

                { "csmcl_distentry.aspx", lipayrolentry },
                { "distentry.aspx", lipayrolentry },
                { "csmcl_dist_entry.aspx", lipayrolentry },

                { "csmcldistapprovestatus.aspx", liapproveststus },
                { "csmcl_dist_approvestatus.aspx", liapproveststus },

                { "csmcl_entryreport.aspx", lireport },
                { "entryreport.aspx", lireport },

                { "csmcl_filetrack.aspx", li1 },
                { "filetrack.aspx", li1 },

                { "csmcl_ratemaster.aspx", li2 },
                { "ratemaster.aspx", li2 },

                { "uploaddocument.aspx", li4 },
                { "uploaddoc.aspx", li4 },

                { "approvedocument.aspx", li5 },
                { "approvedoc.aspx", li5 },

                { "csmcl_chatbox.aspx", li6 },
                { "chatbox.aspx", li6 },

                { "master.aspx", li7 },
                { "adminmaster.aspx", li7 },

                 { "csmcl_DistReport.aspx", lidistreport },
                { "DistReport.aspx", lidistreport },

                // report submenu pages map to the report parent
                { "csmcl_summaryreport.aspx", li3 },
                { "summaryreport.aspx", li3 }
            };

            // default to dashboard when unknown/empty
            if (string.IsNullOrEmpty(current))
            {
                ActivateLi(lidashboard);
                return;
            }

            // try exact filename match
            if (map.TryGetValue(current, out HtmlControl found))
            {
                ActivateLi(found);
                // if it's report group, make submenu visible
                if (found == li3)
                {
                    ShowSubmenuIfExists();
                }
                return;
            }

            // fallback: match by last segment contains (best-effort)
            foreach (var kv in map)
            {
                var keyName = kv.Key?.Replace(".aspx", "") ?? string.Empty;
                if (!string.IsNullOrEmpty(keyName) && current.Contains(keyName))
                {
                    ActivateLi(kv.Value);
                    if (kv.Value == li3) ShowSubmenuIfExists();
                    return;
                }
            }

            // final fallback
            ActivateLi(lidashboard);
        }

        private void ActivateLi(HtmlControl li)
        {
            if (li == null) return;
            li.Attributes["class"] = AddClass(li.Attributes["class"], "active");
        }

        private void ShowSubmenuIfExists()
        {
            // sidebarSubmenuReport may be null if not declared as runat="server" in markup
            if (sidebarSubmenuReport != null)
            {
                sidebarSubmenuReport.Attributes["class"] = AddClass(sidebarSubmenuReport.Attributes["class"], "show");
            }
        }

        // helper: append class if not present
        private string AddClass(string existing, string toAdd)
        {
            existing = (existing ?? "").Trim();
            if (string.IsNullOrEmpty(existing))
                return toAdd;
            if ((" " + existing + " ").IndexOf(" " + toAdd + " ", StringComparison.OrdinalIgnoreCase) >= 0)
                return existing;
            return existing + " " + toAdd;
        }

        protected void btnLogout_Click1(object sender, EventArgs e)
        {
            try
            {
                // Clear session and sign out
                Session.Clear();
                Session.Abandon();
                FormsAuthentication.SignOut();

                // Optional: remove auth cookie explicitly
                if (Request.Cookies[FormsAuthentication.FormsCookieName] != null)
                {
                    var cookie = new HttpCookie(FormsAuthentication.FormsCookieName) { Expires = DateTime.Now.AddDays(-1), Path = "/" };
                    Response.Cookies.Add(cookie);
                }

                // Redirect to login (use full path that exists)
                // Use CompleteRequest to avoid ThreadAbortException from Response.Redirect
                Response.Redirect("~/Login/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch
            {
                // fallback safe redirect
                Response.Redirect("~/Login/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}
