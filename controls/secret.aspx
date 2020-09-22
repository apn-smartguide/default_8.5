<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : ""; %>
	<% if(control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
	<% } else { %>
	<apn:ifnotcontrolvalid runat="server">
		<%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
		<a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
	</apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
		<% Server.Execute(resolvePath("/controls/label.aspx")); %>
		<apn:ifcontrolattribute runat="server" attr="prefix or suffix">
			<div class="input-group">
		</apn:ifcontrolattribute>
		<apn:ifcontrolattribute runat="server" attr="prefix">
			<span class="input-group-addon">
				<apn:controlattribute runat="server" attr="prefix" /></span>
		</apn:ifcontrolattribute>
		<input type='password' name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' value='<%= control.Current.getHTMLValue() %>' class='<%= control.Current.getCSSClass() %> form-control' style='<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>' title='<apn:controlattribute attr="title" tohtml="true" runat="server"/>' maxlength='<%= control.Current.getAttribute("maxlength") %>' size='<%= control.Current.getAttribute("size") %>' <apn:metadata runat="server" /> <%= Context.Items["readonly"] %> <!-- #include file="aria-attributes.inc" --> />
		<apn:ifcontrolattribute runat="server" attr="suffix">
			<span class="input-group-addon">
				<apn:controlattribute runat="server" attr="suffix" /></span>
		</apn:ifcontrolattribute>
		<apn:ifcontrolattribute runat="server" attr="prefix or suffix">
			</div>
		</apn:ifcontrolattribute>
		<% Server.Execute(resolvePath("/controls/help.aspx")); %>
	</div>
	<% } %>
</apn:control>