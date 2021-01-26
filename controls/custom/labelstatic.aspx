<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifcontrolvalid runat="server">
		<label class='static-text'>
	</apn:ifcontrolvalid>
	<apn:ifnotcontrolvalid runat="server">
		<label class='static-text error'>
	</apn:ifnotcontrolvalid>
	<% ExecutePath("/controls/custom/control-label.aspx"); %>
	</label>
</apn:control>