<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
if (!IsAvailable(control.Current)) {
	Execute("/controls/hidden.aspx");
} else if(IsPdf && IsHidePdf(control.Current)) {
} else if(control.Current.getCSSClass().Contains("btn-wizard")) {
} else {
	Context.Items["btn-toolbar"] = true; 
%>
<div id='div_<apn:name runat="server"/>' class="btn-toolbar <%=control.Current.getCSSClass()%>" style='<apn:cssstyle runat="server"/>' role="toolbar">
<% Execute("/controls/custom/buttons.aspx"); %>
</div>
<% Context.Items["btn-toolbar"] = false; %>
<% } %>
</apn:control>