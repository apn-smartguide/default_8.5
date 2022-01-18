<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!BareRender){ %>
<apn:control runat="server" id="control">
	<% if (!control.Current.getLabel().Equals("")) { %>
		<% Context.Items["aria-labelledby"] = "lbl_" + control.Current.getName(); %>
		<% if (!control.Current.getCSSClass().Contains("hide-label")) {%>
		<%-- should be contained within a <div class="form-group"> --%>
		<label id='lbl_<apn:name runat="server"/>' <% if (TTSEnabled) { Response.Output.Write("data-tts='{0}_label'",control.Current.getFieldId()); } %> for='<apn:name runat="server"/>' class='<%if (control.Current.getCSSClass().Contains("inline")) {%> inline <% } %> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired>'><% ExecutePath("/controls/custom/control-label.aspx"); %><apn:ifnotcontrolvalid runat="server"><apn:ifcontrolrequired runat="server"><strong class='required'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired></apn:ifnotcontrolvalid><% if (TTSEnabled) { %><span id='<% Response.Output.Write("tts_{0}_label",control.Current.getFieldId()); %>' style='display:none;' class='tts-icon <apn:localize runat="server" key="theme.icon.play"/>'></span><% } %></label>
		<% } else { %>
		<label id='lbl_<apn:name runat="server"/>' class="sr-only"><%= GetAttribute(control.Current, "label") %></label>
		<% } %>
	<%}%>
</apn:control>
<% } %>