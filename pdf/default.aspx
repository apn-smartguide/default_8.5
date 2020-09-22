<?xml version="1.0"?>
<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
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
	<apn:choosecontrol runat="server">
		<apn:whencontrol type="ROW" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/row.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="COL" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/col.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="RECAP" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="GROUP" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/group.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="REPEAT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/repeat.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="INPUT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/input.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="TEXTAREA" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/field.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SECRET" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/secret.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="DATE" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/date.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SELECT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SELECT1" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx"); %>
		</apn:whencontrol>
		<apn:WhenControl runat="server" type="staticText">
			<% Server.Execute(Page.TemplateSourceDirectory + "/statictext.aspx"); %>
		</apn:WhenControl>
		<apn:whencontrol type="IMAGE" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/image.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="UPLOAD" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/upload.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SUB-SMARTLET" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/subsmartlet.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="RESULT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/result.aspx"); %>
		</apn:whencontrol>
	</apn:choosecontrol>
</apn:forEach>

</table>
</div>
<!-- PAGE FOOTER -->
<div id="sgfooter" style="margin : 10px 0;text-align : center;font-size : 90%;">
	(c)Copyright 2004-2016 Alphinat Inc. All rights reserved.
</div>

</body>
</html>
