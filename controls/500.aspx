<%@ Page Language="C#" %>
<%
	// An unexpected error occured (unhandled session timeout, etc)
	// We can for example set a message in session, send email messages, etc
	// Session["loginNotification"] = "An error occured.  You have been redirected automatically to the portal login page.";
	// Before redirecting
	string redirectURL = (string)ConfigurationSettings.AppSettings["com.alphinat.sgs.theme.ErrorRedirectURL"];
	Response.Redirect(redirectURL);
	Response.End();
%>