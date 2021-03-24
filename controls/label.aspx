<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!BareRender){ %>
<apn:control runat="server" id="control">
	<% if (!control.Current.getCSSClass().Contains("hide-label") && !control.Current.getLabel().Equals("")) { %>
	<%-- should be contained within a <div class="form-group"> --%>
	<label id='lbl_<apn:name runat="server"/>' for='<apn:name runat="server"/>' <apn:ifcontrolrequired runat="server">class='required'</apn:ifcontrolrequired>>
		<% ExecutePath("/controls/custom/control-label.aspx"); %>
		<apn:ifnotcontrolvalid runat="server"><apn:ifcontrolrequired runat="server"><strong class='required'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired></apn:ifnotcontrolvalid>
	</label>
	<% } %>
</apn:control>
<% } %>