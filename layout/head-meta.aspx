<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags --%>
<title><apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control> &gt; <apn:control runat="server" type="step"><apn:label runat="server"/></apn:control></title>
<meta name="description" content='<apn:control runat="server" type="smartlet-description"><apn:value runat="server"/></apn:control>'>
<meta name="theme" content='<apn:control runat="server" type="smartlet-theme"><apn:value runat="server"/></apn:control>'>
<meta name="author" content='<apn:control runat="server" type="smartlet-author"><apn:value runat="server"/></apn:control>'>
<meta name="lastmodified" content='<apn:control runat="server" type="smartlet-lastmodification"><apn:value runat="server"/></apn:control>'>
<meta name="keywords" content='<apn:control runat="server" type="keyword"><apn:value runat="server"/></apn:control>'>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="mobile-web-app-capable" content="yes">
<meta name="generator" content="SmartGuide 8.0.2"> <%-- leave this for stats please --%>
<meta name="application-name" content="<apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control>">
<% Server.Execute(resolvePath("/layout/dcterms.aspx")); %>