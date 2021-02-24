<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!BareRender){ %>
<% if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { 
	Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " ";
} else {
	Context.Items["no-col-layout"] = "";
} %>
<apn:control runat="server" id="control">
	<% if (!control.Current.getCSSClass().Contains("hide-label")) { %>
	<%-- should be contained within a <div class="form-group"> --%>
	<legend id='lbl_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <%= ( "".Equals(control.Current.getLabel()) ? "emptyLegend":"") %>'>
		<% ExecutePath("/controls/custom/control-label.aspx"); %>
		<apn:ifnotcontrolvalid runat="server"><apn:ifcontrolrequired runat="server"><strong class='has-error'><%=Smartlet.getLocalizedResource("theme.text.required-suffix")%></strong></apn:ifcontrolrequired></apn:ifnotcontrolvalid>
	</legend>
	<% } %>	
</apn:control>
<% } %>
