<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else { %>
<a id='<apn:name runat="server"/>' <apn:ifcontrolattribute runat="server" attr="eventtarget">data-eventtarget='[<apn:controlattribute attr="eventtarget" runat="server"/>]'</apn:ifcontrolattribute> <apn:ifcontrolattribute runat="server" attr="eventsource">data-eventsource='[<apn:controlattribute attr="eventsource" runat="server"/>]'</apn:ifcontrolattribute> class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/> href='<apn:value runat="server"/>' <apn:metadata runat="server" match="target"/>><apn:ChooseControl runat="server"><apn:label runat="server"/><apn:WhenControl runat="server" type="GROUP"><% Server.Execute(resolvePath("/controls/custom/no-col-render.aspx")); %></apn:WhenControl></apn:ChooseControl></a>
<% } %>  						
</apn:control>	
