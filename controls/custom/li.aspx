<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SG.Page" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else { %>
<li id='<apn:name runat="server"/>' <apn:ifcontrolattribute runat="server" attr="eventtarget">data-eventtarget='[<apn:controlattribute attr="eventtarget" runat="server"/>]'</apn:ifcontrolattribute> <apn:ifcontrolattribute runat="server" attr="eventsource">data-eventsource='[<apn:controlattribute attr="eventsource" runat="server"/>]'</apn:ifcontrolattribute> class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% Server.Execute(resolvePath("/controls/custom/no-col-render.aspx")); %></apn:WhenControl><apn:otherwise runat="server"><apn:label runat="server"/><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></li>
<% } %>  						
</apn:control>	

