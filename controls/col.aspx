<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
	<div class='<apn:controllayoutattribute runat="server" attr="all"/>'>
		<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
	</div>
	<% } else { %> 
		<% Server.Execute(resolvePath("/controls/controls.aspx")); %> 
	<% } %>
</apn:control>