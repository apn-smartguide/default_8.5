<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if((bool)Context.Items["pdf"] && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<div id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% ExecutePath("/controls/custom/no-col-render.aspx"); %></apn:WhenControl><apn:otherwise runat="server"><apn:label runat="server"/><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></div>
<% } %>  						
</apn:control>