<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : "";
if (!IsAvailable(control.Current) || (IsProxy(control.Current) && !RenderProxy)) {
	Execute("/controls/hidden.aspx");
} else if (control.Current.getCSSClass().Contains("multiple") && !IsSummary) {
%>
	<span class='<apn:cssclass runat="server"/>' id='div_<apn:name runat="server"/>' >
		<label for='<apn:name runat="server"/>'>
			<apn:label runat="server"/> <input type='file' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' multiple title='<apn:label runat="server"/>' style='color:transparent;' onchange='submit();' />
		</label>
	</span>
<% } else { %>
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>' title='<apn:localize runat="server" key="theme.text.erroranchor"/>' aria-label='<apn:localize runat="server" key="theme.text.erroranchor"/>'><apn:localize runat="server" key="theme.text.erroranchor"/> <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
	<% if(!BareRender) { %> <% Execute("/controls/label.aspx"); %><% } %>
	<% if(ShowErrorsAbove) { %>
		<apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid>
	<% } %>
	<% if(IsPdf) { %>
		<p><apn:value runat="server"/></p>
	<% } else { %>
		<% if(control.Current.getAttribute("value").Trim().Length==0 && !IsSummary) { %>
			<input type='file' <% if (control.Current.getCSSClass().Contains("multiple")) { %>multiple onchange='submit();'<% } %> class='form-control' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <%=(string)Context.Items["readonly"]%> style='<apn:cssstyle runat="server"/>' title='<%=GetAttribute(control.Current, "title", true)%>' <apn:metadata runat="server"/> <apn:ifcontrolrequired runat="server">aria-required="true"</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" -->/>
		<% } else { %>
			<div>
				<a target='_blank' href='upload/do.aspx/<apn:value runat="server"/>?id=<apn:name runat="server"/>&interviewID=<apn:control runat="server" type="interview-code"><apn:value runat="server"/></apn:control>' title='<apn:localize runat="server" key="theme.text.upload"/>' aria-label='<apn:localize runat="server" key="theme.text.upload"/>'> <apn:value runat="server"/></a>
				<% if (!control.Current.getCSSClass().Contains("hide-delete-btn")) { %>
				&nbsp;
				<!-- use button to clear, all the data on the page will be submitted -->
				<% if (((string)Context.Items["readonly"]).Length == 0 && !IsSummary) { %>
					<%
					string eventTargets = "";
					SessionField btn = GetProxyButton("upload_clear", ref eventTargets);
					if(btn != null && btn.isAvailable()) { %>
						<button type='button' id='d_<%=btn.getId()%>' name='d_<%=btn.getId()%>' class='sg <%=GetCleanCSSClass(btn)%>' style='<%=btn.getCSSStyle()%>' data-eventtarget='[<%=eventTargets%>]' <% if (!GetTooltip(btn).Equals("")){ %>title='<%=GetTooltip(btn)%>' aria-label='<%=GetTooltip(btn)%>'<% } %>><%=btn.getLabel()%></button>
					<% } else { %> 
						<button type='button' id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg clear-upload self-refresh <apn:localize runat="server" key="theme.style.button.delete"/>' data-eventtarget='[]' value="" aria-labelledby='lbl_<apn:name runat="server"/>' title='<apn:localize runat="server" key="theme.upload.delete" />'><span class='<apn:localize runat="server" key="theme.icon.delete"/>'></span></button>
					<% } %>
				<% } %>
				<!-- use link to clear, the data on the page will not be submitted -->
				<!-- <a href="?<apn:name runat="server"/>=">Clear</a>	-->
				<% } %>
			</div>
		<% } %>
	<% } %>
	<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
	</div>
<% } %>
</apn:control>