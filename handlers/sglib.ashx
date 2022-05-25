<%@ WebHandler Language="C#" Class="sglib" %>
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.SessionState;
using System.Web.Security;

using com.alphinat.sg;
using com.alphinat.sg5;
using com.alphinat.sg5.widget.repeat;
using com.alphinat.sgs;
using com.alphinat.sgs.smartlet;
using com.alphinat.sgs.smartlet.api5impl;
using com.alphinat.sgs.smartlet.session;
using com.alphinat.sgs.smartlet.util;
using com.alphinat.sgs.smartlet.display;
using com.alphinat.xmlengine.interview.tag;
using com.alphinat.interview.si.xml.servlet.environment;
using Alphinat.SmartGuideServer.Controls;

//WIP not yet implemented
public class sglib : IRequiresSessionState, IHttpHandler
{
	public void ProcessRequest (HttpContext context) {
		context.Response.ContentType = "application/javascript";
		string content = "var testvar = 'blue';";
		API5 sg = new API5();
		//content = ClientSideEvents.getJSFields(((DisplayPage)sg.getSmartlet().getCurrentPage()).getSessionPage());
		context.Response.Write(content);
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

	private static string GetAppSetting(string key) {
		if(System.Configuration.ConfigurationManager.AppSettings[key] != null) {
			return (string)System.Configuration.ConfigurationManager.AppSettings[key];
		}
		return "";
	}
}