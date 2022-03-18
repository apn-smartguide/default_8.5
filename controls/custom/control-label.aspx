<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = control.Current.getLabel(); %>
	<apn:ifcontrolrequired runat="server"><span class="required"  data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span></apn:ifcontrolrequired>
	<% if(!control.Current.getLabel().Equals("")) { %>
	<apn:ifnotcontrolattribute attr="tooltip" runat="server">
		<span <% if (TTSEnabled && !control.Current.getFieldId().Equals("")) { Response.Output.Write("data-tts='{0}_label'",control.Current.getFieldId()); } %> class='field-name <apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> <apn:cssclass runat="server"/>'><%=Context.Items["label"] + GetMetaDataValue(control.Current, "label-suffix") %></span>
	</apn:ifnotcontrolattribute>
	<apn:ifcontrolattribute attr="tooltip" runat="server">
		<span <% if (TTSEnabled && !control.Current.getFieldId().Equals("")) { Response.Output.Write("data-tts='{0}_label'",control.Current.getFieldId()); } %> class='field-name <apn:ifnotcontrolvalid runat="server"></span>has-error</apn:ifnotcontrolvalid> <apn:cssclass runat="server"/>' data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<%=GetTooltip(control.Current)%>'><%=Context.Items["label"] + GetMetaDataValue(control.Current, "label-suffix")%></span>
	</apn:ifcontrolattribute>
	<% if (TTSEnabled && !control.Current.getFieldId().Equals("")) { %><span id='<% Response.Output.Write("tts_{0}_label",control.Current.getFieldId()); %>' style='display:none;' class='tts-icon <apn:localize runat="server" key="theme.icon.play"/>'></span><% } %>
	<% } %>
	<% ExecutePath("/controls/help.aspx"); %>
	<% Context.Items["label"] = ""; %>
</apn:control>