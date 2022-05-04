<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<% Context.Items["btn-toolbar"] = true; %>
<div id='div_<apn:name runat="server"/>' class="btn-toolbar <%=control.Current.getCSSClass()%>" style='<apn:cssstyle runat="server"/>' role="toolbar">
<% Execute("/controls/custom/buttons.aspx"); %>
</div>
<% Context.Items["btn-toolbar"] = false; %>
<% } %>
</apn:control>