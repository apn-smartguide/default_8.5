<?xml version="1.0"?>
<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<%
 //global style
 Context.Items["pageTitle"] = "font-family:Helvetica; font-size:1.17em; color: #333";
 Context.Items["pageContent"] =  "font-family:Helvetica; font-size:0.875em;  color: #333;";
 Context.Items["fieldLabel"] =  "font-family:Helvetica; font-size:0.875em; color:#333; font-weight:700";
 Context.Items["fieldValue"] =  "font-family:Helvetica; font-size:0.875em; border:1px solid #ccc; width:100%; color:#555; padding:5px 5px 5px 1px; margin:0 0 0 2px";
 Context.Items["groupTitle"] =  "font-size:100%; font-weight:bold; font-style:italic; color:#333; background-color:#EEE; margin:0; padding:0";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><apn:control runat="server" type="title"><apn:value runat="server"/></apn:control> <apn:control runat="server" type="step"><apn:label runat="server"/></apn:control></title>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
<meta name="keywords" content='<apn:control runat="server" type="keyword"><apn:value runat="server"/></apn:control>' />
</head>
<body>
<!-- page header -->
<div style="<%=Context.Items["pageTitle"]%>">
	<apn:control runat="server" type="step"><apn:label runat="server"/></apn:control>
</div>

<div id="sgControls" style="<%=Context.Items["pageContent"]%>">
<table cellpadding="0" cellspacing="0" border="0">
<apn:forEach runat="server">
	<% Server.Execute(resolvePath("/pdf/controls.aspx")); %>
</apn:forEach>

</table>
</div>
<!-- PAGE FOOTER -->
<div id="sgfooter" style="margin : 10px 0;text-align : center;font-size : 90%;">
	(c)Copyright 2004-2020 Alphinat Inc. All rights reserved.
</div>

</body>
</html>
