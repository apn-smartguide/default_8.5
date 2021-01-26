<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<apn:ifcontrolrequired runat="server">
	<span class="required">*</span>
</apn:ifcontrolrequired>
<apn:ifnotcontrolattribute attr="tooltip" runat="server">
	<apn:ifnotcontrolvalid runat="server">
		<span class="has-error field-name"><apn:label runat="server" /></span>
	</apn:ifnotcontrolvalid>
	<apn:ifcontrolvalid runat="server">
		<span class="field-name"><apn:label runat="server" /></span>
	</apn:ifcontrolvalid>
</apn:ifnotcontrolattribute>
<apn:ifcontrolattribute attr="tooltip" runat="server">
	<apn:ifnotcontrolvalid runat="server">
		<span class="has-error field-name" data-toggle='tooltip' title='<apn:controlattribute runat="server" tohtml="true" attr="tooltip"/>'><apn:label runat="server" /></span>
	</apn:ifnotcontrolvalid>
	<apn:ifcontrolvalid runat="server">
		<span class="field-name" data-toggle='tooltip' title='<apn:controlattribute runat="server" tohtml="true" attr="tooltip"/>'><apn:label runat="server" /></span>
	</apn:ifcontrolvalid>
</apn:ifcontrolattribute>
<% ExecutePath("/controls/help.aspx"); %>
<% if (control.Current.getCSSClass().IndexOf("tts") > -1 || (Context.Items["tts-option"] != null && (bool)Context.Items["tts-option"])) { %>
	<span class='<apn:localize runat="server" key="theme.icon.play"/>' />
<% } %>
</apn:control>