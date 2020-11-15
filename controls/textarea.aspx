<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<% } else { %>
<%
	Context.Items["rows"] = (control.Current.getAttribute("rows").Equals("")) ? "5" : control.Current.getAttribute("rows");
	Context.Items["cols"] = (control.Current.getAttribute("cols").Equals("")) ? "36" : control.Current.getAttribute("cols");
 	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : "";
%>
    <apn:ifnotcontrolvalid runat="server">
        <%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
        <a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
    </apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
		<% Server.Execute(resolvePath("/controls/label.aspx")); %>
		<apn:controlattribute runat="server" attr="prefix"/>
		<textarea name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' rows='<%= Context.Items["rows"] %>' cols='<%= Context.Items["cols"] %>' style='<apn:controlattribute runat="server" attr="style"/><apn:cssstyle runat="server"/>' class='form-control <apn:cssclass runat="server"/>' title='<apn:controlattribute runat="server" attr="title" tohtml="true"/>'<apn:metadata runat="server"/><%= Context.Items["readonly"] %> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" --> >
			<apn:value runat="server" tohtml="true"/>
		</textarea>
		<apn:controlattribute runat="server" attr="suffix"/>
	</div>
<% } %>
</apn:control>

