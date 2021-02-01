<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
<% if (!bareControl){ %>
<apn:control runat="server" id="control">
	<% if (!control.Current.getCSSClass().Contains("hide-label") && !control.Current.getLabel().Equals("")) { %>
	<%-- should be contained within a <div class="form-group"> --%>
	<label id='lbl_<apn:name runat="server"/>' for='<apn:name runat="server"/>' <apn:ifcontrolrequired runat="server">class='required'</apn:ifcontrolrequired>>
		<% ExecutePath("/controls/custom/control-label.aspx"); %>
		<apn:ifnotcontrolvalid runat="server"><apn:ifcontrolrequired runat="server"><strong class='has-error'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired><br><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid>
	</label>
	<% } %>
</apn:control>
<% } %>

