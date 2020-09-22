<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:ForEach runat="server" id="control">
<% Server.Execute(resolvePath("/controls/control.aspx")); %>
</apn:forEach>
