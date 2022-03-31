<%@ WebHandler Language="C#" Class="keepalive" %>
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.SessionState;
using System.Web.Security;

public class KeepAlive : IRequiresSessionState, IHttpHandler
{
	public void ProcessRequest (HttpContext context) {
		VerifySession(context);
		//context.Current.Session["test"] = DateTime.UtcNow.ToString();
		context.Current.Response.Flush();
		context.Current.Response.Close();
	}	

	public static void VerifySession(HttpContext context)
	{
		Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
		SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");

		//string test = (string)context.Current.Session["test"];
		HttpCookie aspnetCookie = context.Current.Request.Cookies[section.CookieName];
		HttpCookie smartProfileAuthCookie = context.Current.Request.Cookies["SmartProfileAuthCookie"];

		context.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
		context.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
		context.Current.Response.Cache.SetNoStore();
		context.Current.Response.Cache.SetNoServerCaching();

		if (context.Current.Session != null)
		{
			if (context.Current.Session.IsNewSession)
			{
				context.Current.Response.Write("{session:new}");
			}
			if (aspnetCookie != null && !aspnetCookie.Value.Equals(""))
			{
				int timeout = (int)section.Timeout.TotalMinutes;
				aspnetCookie.Expires = DateTime.UtcNow.AddMinutes(timeout);
				aspnetCookie.Secure = context.Current.Request.IsSecureConnection;
				aspnetCookie.SameSite = SameSiteMode.Strict;
				context.Current.Response.Cookies.Add(aspnetCookie);
				//context.Current.Response.Write("{test:" + test + "},{session:alive},{session-id:" + aspnetCookie.Value + "},{session-expires:" + aspnetCookie.Expires + "}" + ",{timeout:" + timeout + "}");
				context.Current.Response.Write("{session:alive}");
			}

			string SPRestAPI = GetAppSetting("SmartProfileRestApi");
			if (smartProfileAuthCookie != null && SPRestAPI != null && !smartProfileAuthCookie.Value.Equals("")) {
				string apiUrl = GetAppSetting("SmartProfileRestApi")+"/spv3/utils/keepalive";
				WebClient client = new WebClient();
				client.Headers["SPAccessToken"] = GetAppSetting("SP.Smartlets.WS.AccessKey");
				client.Headers["SPAuthToken"] = smartProfileAuthCookie.Value;
				string result = client.DownloadString(apiUrl);
				context.Current.Response.Write("{smartprofile:"+result+"}");
			}   
		} else {
			context.Current.Response.Write("{session:none}");
		}
	}

	public static string GetAppSetting(string key) {
		if(System.Configuration.ConfigurationManager.AppSettings[key] != null) {
			return (string)System.Configuration.ConfigurationManager.AppSettings[key];
		}
		return "";
	}
}