<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!BareRender){ %>
<apn:control runat="server" id="control">
	<% Context.Items["aria-labelledby"] = "lbl_" + control.Current.getName(); %>
	<% if (!control.Current.getCSSClass().Contains("hide-label") && !control.Current.getLabel().Equals("")) { %>
	<%-- should be contained within a <div class="form-group"> --%>
	<label id='lbl_<apn:name runat="server"/>' for='<apn:name runat="server"/>' <apn:ifcontrolrequired runat="server">class='required'</apn:ifcontrolrequired>><% ExecutePath("/controls/custom/control-label.aspx"); %><apn:ifnotcontrolvalid runat="server"><apn:ifcontrolrequired runat="server"><strong class='required'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired></apn:ifnotcontrolvalid></label>
	<% } else if (!control.Current.getLabel().Equals("")) { %>
	<label id='lbl_<apn:name runat="server"/>' class="sr-only"><%= GetAttribute(control.Current, "label") %></label>
	<% } %>
</apn:control>
<% } %>