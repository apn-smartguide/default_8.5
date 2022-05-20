<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
if (!IsAvailable(control.Current)) {
	Execute("/controls/hidden.aspx");
} else if(IsPdf && IsHidePdf(control.Current)) {
} else {
%>
<apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% Execute("/controls/custom/no-col-render.aspx"); %></apn:WhenControl><apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><apn:value runat="server"/></apn:otherwise></apn:ChooseControl>
<% } %>
</apn:control>