<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<%
	Context.Items["html5type"]="text";
	// check if html5 type specified explicitly
	if (control.Current.getAttribute("html5type").Length > 0) { Context.Items["html5type"] = control.Current.getAttribute("html5type"); }
	if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " "; } else { Context.Items["no-col-layout"] = ""; }
%>
<% if(control.Current.getAttribute("style").Contains("visibility:hidden;") || control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<% } else { %>
	<%
	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : "";
	Context.Items["maxlength"] = control.Current.getAttribute("maxlength");
	%>
	<% if (Context.Items["maxlength"] == null) Context.Items["maxlength"] = ""; %>
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex%>'>Anchor to error <%=ErrorIndex%></a></apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> form-group <apn:ifcontrolattribute runat="server" attr="prefix or suffix"> input-group</apn:ifcontrolattribute> <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
		<% ExecutePath("/controls/label.aspx"); %>
		<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		<% if(IsPdf || IsSummary) { %>
			<p><apn:value runat="server"/></p>
		<% } else { %>
			<apn:ifcontrolattribute runat="server" attr="prefix or suffix"><div class='input-group'></apn:ifcontrolattribute>
			<apn:ifcontrolattribute runat="server" attr="prefix"><span class='input-group-addon'><apn:controlattribute runat="server" attr="prefix" /></span></apn:ifcontrolattribute>
			<apn:ifcontrolrequired runat="server">
			<% if(control.Current.getAttribute("label").Equals("")) { %>
				<span class="required required-input-no-label" title='<apn:localize runat="server" key="theme.text.required"/>'>*</span>
			<%}%>
			<%-- If control is required, when using a cancel button, make sure to add the "formnovalidate" data attribute. --%>
			</apn:ifcontrolrequired>
			<input name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' type='<%=Context.Items["html5type"]%>' <apn:metadata runat="server" /> value='<apn:value runat="server" tohtml="true"/>' title='<%=GetAttribute(control.Current, "label")%>' placeholder='<%=GetAttribute(control.Current, "placeholder")%>' size='<apn:controlattribute runat="server" attr="size"/>' style='<apn:controlattribute runat="server" attr="style" /> <apn:cssstyle runat="server" />' class='form-control <apn:cssclass runat="server"/>' <%= Context.Items["readonly"] %> <%if (control.Current.isRequired()) { %>aria-required="true"<% } %> <%= (Context.Items["maxlength"].Equals("") ? "" : "maxlength='" + Context.Items["maxlength"] + "'") %> <!-- #include file="aria-attributes.inc" -->/>
			<apn:ifcontrolattribute runat="server" attr="suffix"><span class='input-group-addon'><apn:controlattribute runat="server" attr="suffix" /></span></apn:ifcontrolattribute>
			<apn:ifcontrolattribute runat="server" attr="prefix or suffix"></div></apn:ifcontrolattribute>
		<% } %>
		<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
	</div>
<% } %>
</apn:control>