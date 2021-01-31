<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : ""; %>
	<% if(control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
	<% } else { %>
		<% if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { 
			Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " ";
		} else {
			Context.Items["no-col-layout"] = "";
		} %>
	<apn:ifnotcontrolvalid runat="server">
		<%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
		<a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
	</apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
		<% ExecutePath("/controls/label.aspx"); %>
		<apn:ifcontrolattribute runat="server" attr="prefix or suffix"><div class="input-group"></apn:ifcontrolattribute>
		<apn:ifcontrolattribute runat="server" attr="prefix"><span class="input-group-addon"><apn:controlattribute runat="server" attr="prefix" /></span></apn:ifcontrolattribute>
		<input type='password' name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' value='<%= control.Current.getHTMLValue() %>' class='<%= control.Current.getCSSClass() %> form-control' style='<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>' title='<%=GetAttribute(control.Current, "title", true)%>' maxlength='<%= control.Current.getAttribute("maxlength") %>' size='<%= control.Current.getAttribute("size") %>' <apn:metadata runat="server" /> <%= Context.Items["readonly"] %> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" --> />
		<apn:ifcontrolattribute runat="server" attr="suffix"><span class="input-group-addon"><apn:controlattribute runat="server" attr="suffix" /></span></apn:ifcontrolattribute>
		<apn:ifcontrolattribute runat="server" attr="prefix or suffix"></div></apn:ifcontrolattribute>
	</div>
	<% } %>
</apn:control>