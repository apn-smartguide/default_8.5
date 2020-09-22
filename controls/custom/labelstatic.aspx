<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
	<apn:ifcontrolvalid runat="server">
		<label class='static-text'>
	</apn:ifcontrolvalid>
	<apn:ifnotcontrolvalid runat="server">
		<label class='static-text error'>
	</apn:ifnotcontrolvalid>
	<apn:label runat="server"/>
		<%-- tooltip comes here --%>
		<apn:ifcontrolattribute runat="server" attr='title'>
			<span title='' data-toggle='tooltip' class='<apn:localize runat="server" key="theme.icon.question"/>' data-original-title='<apn:controlattribute runat="server" attr="title"/>'></span>
		</apn:ifcontrolattribute>
	</label>
</apn:control>