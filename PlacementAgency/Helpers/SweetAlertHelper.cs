using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace PlacementAgency.Helpers
{
    public class SweetAlertHelper
    {
        public static void ShowSuccess(Page page, string message)
        {
            string safeMessage = HttpUtility.JavaScriptStringEncode(message);

            string script = $@"
                Swal.fire({{
                    icon: 'success',
                    title: 'Success',
                    text: '{safeMessage}',
                    confirmButtonColor: '#28a745'
                }});";

            ScriptManager.RegisterStartupScript(page, page.GetType(),
                "SuccessAlert", script, true);
        }

        public static void ShowError(Page page, string message)
        {
            string safeMessage = HttpUtility.JavaScriptStringEncode(message);

            string script = $@"
                Swal.fire({{
                    icon: 'error',
                    title: 'Error',
                    text: '{safeMessage}',
                    confirmButtonColor: '#dc3545'
                }});";

            ScriptManager.RegisterStartupScript(page, page.GetType(),
                "ErrorAlert", script, true);
        }

        public static void ShowWarning(Page page, string message)
        {
            string safeMessage = HttpUtility.JavaScriptStringEncode(message);

            string script = $@"
                Swal.fire({{
                    icon: 'warning',
                    title: 'Warning',
                    text: '{safeMessage}',
                    confirmButtonColor: '#ffc107'
                }});";

            ScriptManager.RegisterStartupScript(page, page.GetType(),
                "WarningAlert", script, true);
        }
    }
}