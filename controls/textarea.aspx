<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
if (!IsAvailable(control.Current)) {
	Execute("/controls/hidden.aspx");
} else {
	Context.Items["rows"] = (control.Current.getAttribute("rows").Equals("")) ? "5" : control.Current.getAttribute("rows");
	Context.Items["cols"] = (control.Current.getAttribute("cols").Equals("")) ? "36" : control.Current.getAttribute("cols");
	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : "";
	if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) {
		Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " ";
	} else {
		Context.Items["no-col-layout"] = "";
	}
%>
	<% if(IsPdf || IsSummary) { %>
		<p><apn:value runat="server"/></p>
	<% } else { %>
		<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
		<div id='div_<apn:name runat="server"/>' data-name='<%=control.Current.getCode()%>' class='<%=Context.Items["no-col-layout"]%> form-group <%=GetCleanCSSClass(control) %> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> ><% Execute("/controls/label.aspx"); %><apn:controlattribute runat="server" attr="prefix"/>
			<% if (control.Current.getCSSClass().Contains("inline-mode")) { %>
				<div name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' <apn:metadata runat="server"/> <%= Context.Items["readonly"] %> <apn:ifcontrolrequired runat="server">aria-required="true"</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" --> ><apn:value runat="server"/></div><apn:controlattribute runat="server" attr="suffix"/>
			<% } else { %>
				<textarea name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' rows='<%= Context.Items["rows"] %>' cols='<%= Context.Items["cols"] %>' placeholder='<%=GetAttribute(control.Current, "placeholder", false)%>' style='<apn:controlattribute runat="server" attr="style"/><apn:cssstyle runat="server"/>' class='form-control <apn:cssclass runat="server"/>' title='<%=GetAttribute(control.Current, "title", true)%>'<apn:metadata runat="server"/><%= Context.Items["readonly"] %> <apn:ifcontrolrequired runat="server">aria-required="true"</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" --> ><apn:value runat="server" tohtml="true"/></textarea><apn:controlattribute runat="server" attr="suffix"/>
			<% } %>
			<% if(!control.Current.getCSSClass().Contains("error-with-label")) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		</div>
	<% } %>
<% } %>
</apn:control>
