<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
	<div class='<apn:controllayoutattribute runat="server" attr="all"/>'><% ExecutePath("/controls/summary/controls.aspx"); %></div>
	<% } else { %> 
		<% ExecutePath("/controls/summary/controls.aspx"); %> 
	<% } %>
</apn:control>