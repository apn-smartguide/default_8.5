<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifcontrolvalid runat="server"><label class='static-text'></apn:ifcontrolvalid>
	<apn:ifnotcontrolvalid runat="server"><label class='static-text error'></apn:ifnotcontrolvalid>
	<% ExecutePath("/controls/custom/control-label.aspx"); %>
	</label>
</apn:control>