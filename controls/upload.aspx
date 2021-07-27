<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : ""; %>
<% bool renderProxy = (Context.Items["render-proxy"] != null) ? (bool)Context.Items["render-proxy"] : false; %>	
<% if (control.Current.getAttribute("visible").Equals("false") || (control.Current.getCSSClass().Contains("proxy") && !renderProxy)) { %>
	<!-- #include file="hidden.inc" -->
<% } else if (control.Current.getCSSClass().Contains("multiple") && !IsSummary) { %>
	<span class='<apn:cssclass runat="server"/>' id='div_<apn:name runat="server"/>' >
		<label for='<apn:name runat="server"/>'>
			<apn:label runat="server"/> <input type='file' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' multiple title='<apn:label runat="server"/>' style='color:transparent;' onchange='submit();' />
		</label>
	</span>
<% } else { %>
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>' title='<apn:localize runat="server" key="theme.text.erroranchor"/>' aria-label='<apn:localize runat="server" key="theme.text.erroranchor"/>'><apn:localize runat="server" key="theme.text.erroranchor"/> <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
	<% if(!BareRender) { %> <% ExecutePath("/controls/label.aspx"); %><% } %>
	<% if(ShowErrorsAbove) { %>
		<apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid>
	<% } %>
	<% if(IsPdf) { %>
		<p><apn:value runat="server"/></p>
	<% } else { %>
		<% if(control.Current.getAttribute("value").Trim().Length==0) { %>
			<input type='file' <% if (control.Current.getCSSClass().Contains("multiple")) { %>multiple onchange='submit();'<% } %> class='form-control' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <%=(string)Context.Items["readonly"]%> style='<apn:cssstyle runat="server"/>' title='<%=GetAttribute(control.Current, "title", true)%>' <apn:metadata runat="server"/> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" -->/>
		<% } else { %>
			<div>
				<a target='_blank' href='upload/do.aspx/<apn:value runat="server"/>?id=<apn:name runat="server"/>&interviewID=<apn:control runat="server" type="interview-code"><apn:value runat="server"/></apn:control>' title='<apn:localize runat="server" key="theme.text.upload"/>' aria-label='<apn:localize runat="server" key="theme.text.upload"/>'> <apn:value runat="server"/></a>
				<% if (!control.Current.getCSSClass().Contains("hide-delete-btn")) { %>
				&nbsp;
				<!-- use button to clear, all the data on the page will be submitted -->
				<% if (((string)Context.Items["readonly"]).Length == 0 && !IsSummary) { %><button type='submit' name='<apn:name runat="server"/>' class='btn btn-danger btn-xs btn-link' aria-labelledby='lbl_<apn:name runat="server"/>' onclick='this.value=""; return true;' title='<apn:localize runat="server" key="theme.upload.delete" />'><span class='<apn:localize runat="server" key="theme.icon.delete"/>'></span></button><% } %>
				<!-- use link to clear, the data on the page will not be submitted -->
				<!-- <a href="?<apn:name runat="server"/>=">Clear</a>	-->
				<% } %>
			</div>
		<% } %>
	<% } %>
	<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
	</div>
<% } %>
</apn:control>