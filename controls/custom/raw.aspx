<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% ExecutePath("/controls/custom/no-col-render.aspx"); %></apn:WhenControl><apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><apn:value runat="server"/></apn:otherwise></apn:ChooseControl>
<% } %>
</apn:control>