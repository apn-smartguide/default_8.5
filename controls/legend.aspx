<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
<% if (!bareControl){ %>
<apn:control runat="server" id="control">
	<% if (!control.Current.getCSSClass().Contains("hide-label")) { %>
	<%-- should be contained within a <div class="form-group"> --%>
	<legend id='lbl_<apn:name runat="server"/>' class='<apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <%= ( "".Equals(control.Current.getLabel()) ? "emptyLegend":"") %>'>
		<% Server.Execute(resolvePath("/controls/custom/control-label.aspx")); %>
		<apn:ifnotcontrolvalid runat="server">
			<apn:ifcontrolrequired runat="server"><strong class='has-error'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired>
			<strong id='<apn:name runat="server"/>-error' class='error'>
				<span class="label label-danger">
					<span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %>
				</span>
			</strong>
		</apn:ifnotcontrolvalid>
	</legend>
	<% } %>	
</apn:control>
<% } %>
