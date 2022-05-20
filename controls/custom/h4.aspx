<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
if (!IsAvailable(control.Current)) {
	Execute("/controls/hidden.aspx");
} else if(IsPdf && IsHidePdf(control.Current)) {
} else {
%>
<h4 id='<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><div class="row"><% Execute("/controls/custom/no-col-render.aspx"); %></div></apn:WhenControl><apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></h4>
<% } %>
</apn:control>