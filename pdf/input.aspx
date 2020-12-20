<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SG.Page" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
		<% Server.Execute(resolvePath("/pdf/field.aspx")); %>
	<% } %>		
</apn:control>

