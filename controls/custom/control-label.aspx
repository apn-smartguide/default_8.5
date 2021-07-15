<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = GetAttribute(control.Current, "label"); %>
	<apn:ifcontrolrequired runat="server"><span class="required"  data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span></apn:ifcontrolrequired>
	<% if(!Context.Items["label"].Equals("")) { %>
	<apn:ifnotcontrolattribute attr="tooltip" runat="server"><span class='<apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> field-name <apn:cssclass runat="server"/>'><%=control.Current.getLabel() + GetMetaDataValue(control.Current, "label-suffix") %></span></apn:ifnotcontrolattribute>
	<apn:ifcontrolattribute attr="tooltip" runat="server"><span class='<apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> field-name <apn:cssclass runat="server"/>' data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<%=GetAttribute(control.Current, "tooltip")%>'><%=control.Current.getLabel() + GetMetaDataValue(control.Current, "label-suffix")%></span></apn:ifcontrolattribute>
	<% } %>
	<% ExecutePath("/controls/help.aspx"); %>
	<% if (control.Current.getCSSClass().IndexOf("tts") > -1 || (Context.Items["tts-option"] != null && (bool)Context.Items["tts-option"])) { %><span class='<apn:localize runat="server" key="theme.icon.play"/>' /><% } %>
	<% Context.Items["label"] = ""; %>
</apn:control>