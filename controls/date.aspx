<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="System.Globalization" %>
<apn:control runat="server" id="control">
<%
	Context.Items["html5type"] = "text";
	// check if html5 type specified explicitly
	if (control.Current.getAttribute("html5type").Length > 0) { Context.Items["html5type"] = control.Current.getAttribute("html5type"); }
	if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " "; } else { Context.Items["no-col-layout"] = "";}
%>
<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : ""; %>
<% if (control.Current.getAttribute("visible").Equals("false")) { %><!-- #include file="hidden.inc" -->
<% } else { %>
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a id='error_index_<%=ErrorIndex%>'></a></apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> form-group <apn:ifcontrolattribute runat="server" attr="prefix or suffix"> form-group</apn:ifcontrolattribute> <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
	<% ExecutePath("/controls/label.aspx"); %>
	<%-- for html date type, format must be "yyyy-mm-dd" for value, min and max attributes. --%>
	<%-- for min or max attribute set via data attribute; Ex.: HTML -> Min -> setting --%>
	<%-- For the setting place a hidden field named like the date-input + "-max" or "-min", note format is yyyy-mm-dd --%>
	<% 
		Context.Items["data-value"] = GetHTMLDate(control.Current);
	%>
	<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
	<% if (IsPdf || IsSummary) { %>
		<p><%=Context.Items["data-value"]%></p>
	<% } else { %>
		<apn:choosecontrol runat="server">
			<apn:whencontrol type="INPUT" runat="server"><input type='<%=Context.Items["html5type"]%>' class='form-control' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='<%=Context.Items["data-value"]%>' size='<apn:controlattribute attr="size" runat="server"/>' <apn:metadata runat="server" /> placeholder='<%=GetAttribute(control.Current, "placeholder")%>' maxlength='<apn:controlattribute attr="size" runat="server" />' <%= Context.Items["readonly"] %> <!-- #include file="aria-attributes.inc" --> data-apnformat='<apn:controlattribute runat="server" attr="format"/>'/></apn:whencontrol>
			<apn:whencontrol type="SELECT1" runat="server"><apn:control id="select" runat="server"><select <apn:metadata runat="server" /> class='form-control' name='<apn:name runat="server" />' <apn:ifnotcontrolvalid runat="server"> aria-describedby='error_<apn:name runat="server" />' </apn:ifnotcontrolvalid> aria-invalid='<%= (control.Current.isValid()? "true" : "false")%>' <%if (control.Current.isRequired()) { %>aria-required="true"<% } %> aria-labelledby='lbl_<apn:name runat="server" />'><apn:forEach id="option" runat="server"><option <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> id='<apn:name runat="server"/>' value='<apn:value runat="server" tohtml="true"/>' <%= control.Current.containsValue(option.Current.getValue()) ? "selected" : "" %>><apn:label runat="server" /></option></apn:forEach></select></apn:control></apn:whencontrol>
			<apn:whencontrol type="LABEL" runat="server"><apn:label runat="server" /></apn:whencontrol>
		</apn:choosecontrol>
	<% } %>
	<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
	</div>
<% } %>
</apn:control>