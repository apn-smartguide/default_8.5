<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SG.Page" Trace="false"%>
<apn:control runat="server" id="control">
<%
	Context.Items["html5type"]="text";
	// check if html5 type specified explicitly
	if (control.Current.getAttribute("html5type").Length > 0) {
		Context.Items["html5type"] = control.Current.getAttribute("html5type");
	}	
%>
<% if(control.Current.getAttribute("style").Contains("visibility:hidden;")) { %>
	<div id='div_<apn:name runat="server"/>' <!-- #include file="aria-live.inc" --> >
		<input type='hidden' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='<apn:value runat="server" tohtml="true"/>' <apn:metadata runat="server" /> />
	</div>
<% } else { %>
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
	<% } else { %>
		<% 
		Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : "";
		Context.Items["maxlength"] = control.Current.getAttribute("maxlength");
		%>
		<% if (Context.Items["maxlength"] == null) Context.Items["maxlength"] = ""; %>
		<apn:ifnotcontrolvalid runat="server">
			<% Context.Items["errorIndex"] = (int) Context.Items["errorIndex"] + 1; %>
			<a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
		</apn:ifnotcontrolvalid>
		<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
			<% Server.Execute(resolvePath("/controls/label.aspx")); %>
			<% if(control.Current.getType()==1014) { %>
				<% Server.Execute(resolvePath("/controls/date.aspx")); %>
			<% } else { %>
				<apn:ifcontrolattribute runat="server" attr="prefix or suffix">
					<div class='input-group'>
				</apn:ifcontrolattribute>
				<apn:ifcontrolattribute runat="server" attr="prefix">
					<span class='input-group-addon'><apn:controlattribute runat="server" attr="prefix" /></span>
				</apn:ifcontrolattribute>
				<% string placeholder = control.Current.getPlaceholder(); %>
				<input type='<%=Context.Items["html5type"]%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='<apn:value runat="server" tohtml="true"/>' placeholder='<%=placeholder%>' size='<apn:controlattribute runat="server" attr="size"/>' <apn:metadata runat="server" /> style='<apn:controlattribute runat="server" attr="style" /> <apn:cssstyle runat="server" />' class='form-control' <%= Context.Items["readonly"] %> <%= (Context.Items["maxlength"].Equals("") ? "" : "maxlength='" + Context.Items["maxlength"] + "'") %> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired><!-- #include file="aria-attributes.inc" --> />
				<apn:ifcontrolattribute runat="server" attr="suffix">
					<span class='input-group-addon'><apn:controlattribute runat="server" attr="suffix" /></span>
				</apn:ifcontrolattribute>
				<apn:ifcontrolattribute runat="server" attr="prefix or suffix">
				</div>
				</apn:ifcontrolattribute>
			<% } %>
		</div>
	<% } %>
<% } %>
</apn:control>

