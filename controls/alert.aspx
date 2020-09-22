<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
</div>
<% } else { %>
<div id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> role='alert'>
	<p>
		<apn:label runat="server" /><% Server.Execute(resolvePath("/controls/tts.aspx")); %>
		<apn:ifcontrolattribute runat="server" attr="title">
			<span title='' data-toggle='tooltip' class='<apn:localize runat="server" key="theme.icon.question"/>' data-original-title='<apn:controlattribute runat="server" tohtml="true" attr="title"/>'></span>
		</apn:ifcontrolattribute>
	</p>
		<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
</div>
<% } %>
</apn:control>