<%@ WebHandler Language="C#" Class="KeepAlive" %>
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
		context.Response.Flush();
		context.Response.Close();
	}

	public bool IsReusable
	{
		get
		{
			return false;
		}
	}

	private static void VerifySession(HttpContext context)
	{
		Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
		SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");

		//string test = (string)context.Session["test"];
		HttpCookie aspnetCookie = context.Request.Cookies[section.CookieName];
		HttpCookie smartProfileAuthCookie = context.Request.Cookies["SmartProfileAuthCookie"];

		context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
		context.Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
		context.Response.Cache.SetNoStore();
		context.Response.Cache.SetNoServerCaching();

		if (context.Session != null)
		{
			if (context.Session.IsNewSession)
			{
				context.Response.Write("{session:new}");
			}
			if (aspnetCookie != null && !aspnetCookie.Value.Equals(""))
			{
				int timeout = (int)section.Timeout.TotalMinutes;
				aspnetCookie.Expires = DateTime.UtcNow.AddMinutes(timeout);
				aspnetCookie.Secure = context.Request.IsSecureConnection;
				aspnetCookie.SameSite = SameSiteMode.Strict;
				context.Response.Cookies.Add(aspnetCookie);
				//context.Response.Write("{test:" + test + "},{session:alive},{session-id:" + aspnetCookie.Value + "},{session-expires:" + aspnetCookie.Expires + "}" + ",{timeout:" + timeout + "}");
				context.Response.Write("{session:alive}");
			}

			string SPRestAPI = GetAppSetting("SmartProfileRestApi");
			if (smartProfileAuthCookie != null && SPRestAPI != null && !smartProfileAuthCookie.Value.Equals("")) {
				string apiUrl = GetAppSetting("SmartProfileRestApi")+"/spv3/utils/keepalive";
				WebClient client = new WebClient();
				client.Headers["SPAccessToken"] = GetAppSetting("SP.Smartlets.WS.AccessKey");
				client.Headers["SPAuthToken"] = smartProfileAuthCookie.Value;
				string result = client.DownloadString(apiUrl);
				context.Response.Write("{smartprofile:"+result+"}");
			}   
		} else {
			context.Response.Write("{session:none}");
		}
	}

	private static string GetAppSetting(string key) {
		if(System.Configuration.ConfigurationManager.AppSettings[key] != null) {
			return (string)System.Configuration.ConfigurationManager.AppSettings[key];
		}
		return "";
	}
}