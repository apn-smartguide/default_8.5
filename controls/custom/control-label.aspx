<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = control.Current.getLabel(); %>
	<apn:ifcontrolrequired runat="server"><span class="required"  data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span></apn:ifcontrolrequired>
	<% if(!control.Current.getLabel().Equals("")) { %>
	<apn:ifnotcontrolattribute attr="tooltip" runat="server"><span class='field-name <apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> <apn:cssclass runat="server"/>'><%=Context.Items["label"] + GetMetaDataValue(control.Current, "label-suffix") %></span></apn:ifnotcontrolattribute>
	<apn:ifcontrolattribute attr="tooltip" runat="server"><span class='field-name <apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> <apn:cssclass runat="server"/>' data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<%=GetTooltip(control.Current)%>'><%=Context.Items["label"] + GetMetaDataValue(control.Current, "label-suffix")%></span></apn:ifcontrolattribute>
	<% } %>
	<% ExecutePath("/controls/help.aspx"); %>
	<% if (control.Current.getCSSClass().IndexOf("tts") > -1 || (Context.Items["tts-option"] != null && (bool)Context.Items["tts-option"])) { %><span class='tts-play <apn:localize runat="server" key="theme.icon.play"/>' /><% } %>
	<% Context.Items["label"] = ""; %>
</apn:control>