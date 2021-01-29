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
        VerifySession();
        Response.Flush();
        Response.Close();
    }	

    public static void VerifySession() 
    {
        HttpCookie aspnetCookie = HttpContext.Current.Request.Cookies["ASP.NET_SessionId"];
        HttpCookie smartProfileAuthCookie = HttpContext.Current.Request.Cookies["SmartProfileAuthCookie"]; 

        if (HttpContext.Current.Session != null)
        {
            if (HttpContext.Current.Session.IsNewSession)
            {
                HttpContext.Current.Response.Write("{session:new}");
            }
            if (aspnetCookie != null && !aspnetCookie.Value.Equals(""))
            {
                HttpContext.Current.Response.Write("{session:alive}");
            }
            if (smartProfileAuthCookie != null && !smartProfileAuthCookie.Value.Equals("")) {
                string apiUrl = GetAppSetting("SmartProfileRestApi")+"/spv3/utils/keepalive";
                WebClient client = new WebClient();
                client.Headers["SPAccessToken"] = GetAppSetting("SP.Smartlets.WS.AccessKey");
                client.Headers["SPAuthToken"] = smartProfileAuthCookie.Value;
                string result = client.DownloadString(apiUrl);
                HttpContext.Current.Response.Write("{smartprofile:"+result+"}");
            }   
        } else {
            HttpContext.Current.Response.Write("{session:none}");
        }
    }

    public static string GetAppSetting(string key) {
		if(System.Configuration.ConfigurationManager.AppSettings[key] != null) {
			return (string)System.Configuration.ConfigurationManager.AppSettings[key];
		}
		return "";
	}
}