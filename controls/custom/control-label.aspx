<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<apn:ifcontrolrequired runat="server">
	<span class="required">*</span>
</apn:ifcontrolrequired>
<apn:ifnotcontrolattribute attr="tooltip" runat="server">
	<span class='<apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> field-name'><%=GetAttribute(control.Current, "label")%></span>
</apn:ifnotcontrolattribute>
<apn:ifcontrolattribute attr="tooltip" runat="server">
	<span class='<apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> field-name' data-toggle='tooltip' data-html='true' title='<%=GetAttribute(control.Current, "tooltip")%>'><%=GetAttribute(control.Current, "label")%></span>
</apn:ifcontrolattribute>
<% ExecutePath("/controls/help.aspx"); %>
<% if (control.Current.getCSSClass().IndexOf("tts") > -1 || (Context.Items["tts-option"] != null && (bool)Context.Items["tts-option"])) { %>
	<span class='<apn:localize runat="server" key="theme.icon.play"/>' />
<% } %>
</apn:control>