<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
	<% Server.Execute(resolvePath("/controls/summary/field.aspx")); %>
	<% } %>
</apn:control>