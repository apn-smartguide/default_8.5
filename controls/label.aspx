<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!BareRender){ %>
<apn:control runat="server" id="control">
	<% if (!control.Current.getLabel().Equals("")) { %>
		<% Context.Items["aria-labelledby"] = "lbl_" + control.Current.getName(); %>
		<% if (!control.Current.getCSSClass().Contains("hide-label")) {%>
		<%-- should be contained within a <div class="form-group"> --%>
		<label id='lbl_<apn:name runat="server"/>' for='<apn:name runat="server"/>' class='<%if (control.Current.getCSSClass().Contains("inline")) {%> inline <% } %> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired>'><% ExecutePath("/controls/custom/control-label.aspx"); %><apn:ifnotcontrolvalid runat="server"><apn:ifcontrolrequired runat="server"><strong class='required'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired></apn:ifnotcontrolvalid></label>
		<% } else { %>
		<label id='lbl_<apn:name runat="server"/>' class="sr-only"><%= GetAttribute(control.Current, "label") %></label>
		<% } %>
	<%}%>
</apn:control>
<% } %>