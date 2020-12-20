<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SG.Page" Trace="false"%>
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