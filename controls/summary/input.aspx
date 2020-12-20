<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SG.Page" Trace="false"%>
<apn:control runat="server" id="control">
	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
	<% Server.Execute(resolvePath("/controls/summary/field.aspx")); %>
	<% } %>
</apn:control>