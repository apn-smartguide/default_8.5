<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<apn:control runat="server" id="control">
<% Context.Items["required"] = false; %>
<% Context.Items["target"] = "body,html"; %>
<% Context.Items["idsuffix"] = ""; %>
<% if (Context.Items["context-modal"] != null) {
	Context.Items["target"] = "#modal"; 
	Context.Items["idsuffix"] = "_" + control.Current.getName();
} %>
<% if (!IsPdf || !IsSummary) { %>
	<apn:IfRequiredControlExists runat="server"><% Context.Items["required"] = true; %></apn:IfRequiredControlExists>
	<div id='alerts_required_<%=Context.Items["idsuffix"]%>'>
		<% if (!CurrentPageCSS.Contains("hide-required-notification")) { %>
		<apn:IfRequiredControlExists runat="server"><div class='alert alert-info' role='alert'><span class='required'>*</span><apn:localize runat="server" key="theme.text.required"/></div></apn:IfRequiredControlExists>
		<% } %>
	</div>
<% } %>
</apn:control>