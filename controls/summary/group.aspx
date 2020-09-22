<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
	<div
		id='div_<apn:name runat="server"/>'
		class='panel panel-default <apn:cssclass runat="server"/>'
		style='<apn:cssstyle runat="server"/>'
		<% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<% if (control.Current.getLabel() != ""){ %>
		<div class='panel-heading'>
			<h2 class='panel-title'>
				<apn:label runat="server" />
			</h2>
		</div>
		<% } %>
		<div class='panel-body'>
			<% Server.Execute(resolvePath("/controls/summary/controls.aspx")); %>
		</div>
	</div>
</apn:control>