<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<li id='<apn:name runat="server"/>' <apn:ifcontrolattribute runat="server" attr="eventtarget">data-eventtarget='[<apn:controlattribute attr="eventtarget" runat="server"/>]'</apn:ifcontrolattribute> <apn:ifcontrolattribute runat="server" attr="eventsource">data-eventsource='[<apn:controlattribute attr="eventsource" runat="server"/>]'</apn:ifcontrolattribute> class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% ExecutePath("/controls/custom/no-col-render.aspx"); %></apn:WhenControl><apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></li>
<% } %>
</apn:control>