using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.SessionState;
using System.Web.Security;

public partial class KeepAlive : System.Web.UI.Page, IRequiresSessionState
{
	protected void Page_Load(object sender, EventArgs e)
	{
		VerifySession();
		//HttpContext.Current.Session["test"] = DateTime.UtcNow.ToString();
		Response.Flush();
		Response.Close();
	}	

	public static void VerifySession()
	{
		//string test = (string)HttpContext.Current.Session["test"];
		HttpCookie aspnetCookie = HttpContext.Current.Request.Cookies["ASP.NET_SessionId"];
		HttpCookie smartProfileAuthCookie = HttpContext.Current.Request.Cookies["SmartProfileAuthCookie"];

		HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
		HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
		HttpContext.Current.Response.Cache.SetNoStore();
		HttpContext.Current.Response.Cache.SetNoServerCaching();

		if (HttpContext.Current.Session != null)
		{
			if (HttpContext.Current.Session.IsNewSession)
			{
				HttpContext.Current.Response.Write("{session:new}");
			}
			if (aspnetCookie != null && !aspnetCookie.Value.Equals(""))
			{
				Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
				SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
				int timeout = (int)section.Timeout.TotalMinutes;
				aspnetCookie.Expires = DateTime.UtcNow.AddMinutes(timeout);
				HttpContext.Current.Response.Cookies.Add(aspnetCookie);
				//HttpContext.Current.Response.Write("{test:" + test + "},{session:alive},{session-id:" + aspnetCookie.Value + "},{session-expires:" + aspnetCookie.Expires + "}" + ",{timeout:" + timeout + "}");
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