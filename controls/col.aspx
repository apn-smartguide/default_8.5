<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
	<div class='<apn:controllayoutattribute runat="server" attr="all"/>'>
		<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
	</div>
	<% } else { %> 
		<% Server.Execute(resolvePath("/controls/controls.aspx")); %> 
	<% } %>
</apn:control>