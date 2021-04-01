<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = GetAttribute(control.Current, "label"); %>
	<apn:ifcontrolrequired runat="server"><span class="required">*</span></apn:ifcontrolrequired>
	<% if(!Context.Items["label"].Equals(""))  { %>
	<apn:ifnotcontrolattribute attr="tooltip" runat="server"><span class='<apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> field-name <apn:cssclass runat="server"/>'><%=GetAttribute(control.Current, "label") + GetMetaDataValue(control.Current, "label-suffix") %></span></apn:ifnotcontrolattribute>
	<apn:ifcontrolattribute attr="tooltip" runat="server"><span class='<apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> field-name <apn:cssclass runat="server"/>' data-toggle='tooltip' data-html='true' title='<%=GetAttribute(control.Current, "tooltip")%>'><%=GetAttribute(control.Current, "label") + GetMetaDataValue(control.Current, "label-suffix")%></span></apn:ifcontrolattribute>
	<% } %>
	<% ExecutePath("/controls/help.aspx"); %>
	<% if (control.Current.getCSSClass().IndexOf("tts") > -1 || (Context.Items["tts-option"] != null && (bool)Context.Items["tts-option"])) { %><span class='<apn:localize runat="server" key="theme.icon.play"/>' /><% } %>
	<% Context.Items["label"] = ""; %>
</apn:control>