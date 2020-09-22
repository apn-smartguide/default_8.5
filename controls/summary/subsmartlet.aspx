<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
	<apn:forEach runat="server">
		<% Server.Execute(resolvePath("/controls/summary/controls.aspx")); %>
	</apn:forEach>
</apn:control>