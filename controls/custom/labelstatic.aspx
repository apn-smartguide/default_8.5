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
	<% Server.Execute(resolvePath("/controls/custom/control-label.aspx")); %>
	</label>
</apn:control>