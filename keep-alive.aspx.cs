using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Web;
using System.Web.Security;

public partial class KeepAlive : System.Web.UI.Page 
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsSessionExpired()) {
            Response.Write("{alive}");
            Response.Flush();
            Response.Close();
        }
    }	

    public static bool IsSessionExpired() 
    {
        if (HttpContext.Current.Session != null)
        {
            if (HttpContext.Current.Session.IsNewSession)
            {
                string CookieHeaders = HttpContext.Current.Request.Headers["Cookie"];

                if ((null != CookieHeaders) && (CookieHeaders.IndexOf("ASP.NET_SessionId") >= 0))
                {
                    // IsNewSession is true, but session cookie exists,
                    // so, ASP.NET session is expired
                    return true;
                }

                if (CookieHeaders.IndexOf("SmartProfileAuthCookie") <= 0) {
                    return true;
                }
            }
        }

        return false;
    }
}