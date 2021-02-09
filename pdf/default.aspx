<?xml version="1.0"?>
<%@ Assembly Src="../SGWebCore.cs" %>
<%@ Page Language="C#" autoeventwireup="true" CodeFile="default.aspx.cs" Inherits="_Default" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Import Namespace="System.Reflection" %>
<apn:control runat="server" id="control">
<apn:api5 id="sg5" runat="server" />
<% IsPdf = true; %>
<%
	sg = sg5;
	Init();
	ThemesLocations = new string[]{"/..",Theme};
	LogoutURL = GetURLForSmartlet(SmartletName);
	//global style
	Context.Items["pageTitle"] = "font-family:Helvetica; font-size:1.17em; color: #333";
	Context.Items["pageContent"] =  "font-family:Helvetica; font-size:0.875em;  color: #333;";
	Context.Items["fieldLabel"] =  "font-family:Helvetica; font-size:0.875em; color:#333; font-weight:700";
	Context.Items["fieldValue"] =  "font-family:Helvetica; font-size:0.875em; border:1px solid #ccc; width:100%; color:#555; padding:5px 5px 5px 1px; margin:0 0 0 2px";
	Context.Items["groupTitle"] =  "font-size:100%; font-weight:bold; font-style:italic; color:#333; background-color:#EEE; margin:0; padding:0";
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%=Context.Items["currentLocale"]%>">
<% ExecutePath("/layout/head.aspx"); %>
<body vocab="http://schema.org/" typeof="WebPage" class="pdf">
<!-- page header -->
<div style="<%=Context.Items["pageTitle"]%>">
	<apn:control runat="server" type="step"><%=GetAttribute(control.Current, "label")%></apn:control>
</div>
<div id="sgControls" style="<%=Context.Items["pageContent"]%>">
<table cellpadding="0" cellspacing="0" border="0">
	<% ExecutePath("/layout/main.aspx"); %>
</table>
</div>
<% ExecutePath("/layout/footer.aspx"); %>
</body>
</html>
<% IsPdf = false; %>
</apn:control>

