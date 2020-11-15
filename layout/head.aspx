<!-- TODO : Fix missing WET static dependencies -->
<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<head>
	<% Server.Execute(resolvePath("/layout/head-meta.aspx")); %>
	<% Server.Execute(resolvePath("/layout/head-stylesheets.aspx")); %>
	<% Server.Execute(resolvePath("/layout/head-scripts.aspx")); %>
</head>