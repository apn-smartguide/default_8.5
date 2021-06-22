<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% Context.Items["render-proxy"] = (Context.Items["render-proxy"] != null) ? (bool)Context.Items["render-proxy"] : false; %>
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<% Context.Items["btn-toolbar"] = true; %>
<div id='div_<apn:name runat="server"/>' class="btn-toolbar <%=control.Current.getCSSClass()%>" style='<apn:cssstyle runat="server"/>' role="toolbar">
<% ExecutePath("/controls/custom/buttons.aspx"); %>
</div>
<% Context.Items["btn-toolbar"] = false; %>
<% } %>
</apn:control>