<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
if (!IsAvailable(control)) {
	Execute("/controls/hidden.aspx");
} else if(IsPdf && control.IsHidePdf()) {
} else {
%>
<li id='<apn:name runat="server"/>' <apn:ifcontrolattribute runat="server" attr="eventtarget">data-eventtarget='[<apn:controlattribute attr="eventtarget" runat="server"/>]'</apn:ifcontrolattribute> <apn:ifcontrolattribute runat="server" attr="eventsource">data-eventsource='[<apn:controlattribute attr="eventsource" runat="server"/>]'</apn:ifcontrolattribute> class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% Execute("/controls/custom/no-col-render.aspx"); %></apn:WhenControl><apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></li>
<% } %>
</apn:control>