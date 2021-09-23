<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : ""; %>
	<% if(control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
	<% } else { %>
	<% if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " "; } else { Context.Items["no-col-layout"] = "";} %>
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex%>'>Anchor to error <%=ErrorIndex%></a></apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> form-group <%=control.Current.getCSSClass().Replace("toggle-password","")%> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
		<% ExecutePath("/controls/label.aspx"); %>
		<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		<% if (IsPdf || IsSummary) { %><p>********</p>
		<% } else { %>
		<apn:ifcontrolattribute runat="server" attr="prefix or suffix"><div class="input-group"></apn:ifcontrolattribute>
		<apn:ifcontrolattribute runat="server" attr="prefix"><span class="input-group-addon"><apn:controlattribute runat="server" attr="prefix" /></span></apn:ifcontrolattribute>
		<input type='password' name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' value='<%= control.Current.getHTMLValue() %>' class='<%= control.Current.getCSSClass() %> form-control' style='<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>' title='<%=GetAttribute(control.Current, "title", true)%>' maxlength='<%= control.Current.getAttribute("maxlength") %>' size='<%= control.Current.getAttribute("size") %>' <apn:metadata runat="server" /> <%= Context.Items["readonly"] %> <apn:ifcontrolrequired runat="server">aria-required="true"</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" --> />
		<apn:ifcontrolattribute runat="server" attr="suffix"><span class="input-group-addon"><apn:controlattribute runat="server" attr="suffix" /></span></apn:ifcontrolattribute>
		<apn:ifcontrolattribute runat="server" attr="prefix or suffix"></div></apn:ifcontrolattribute>
		<% } %>
		<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		<% if(control.Current.getCSSClass().Contains("toggle-password")) { %>
			<span toggle="#<%= control.Current.getName() %>" class="far fa-eye field-icon toggle-password"/>
		<% } %>
	</div>
	<% } %>
</apn:control>