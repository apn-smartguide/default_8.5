<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
Context.Items["bareControl"] = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
	
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<!-- #include file="render_hidden_div.inc" -->
<%
} else { 

	Context.Items["rows"] = (control.Current.getAttribute("rows").Equals("")) ? "5" : control.Current.getAttribute("rows");
	Context.Items["cols"] = (control.Current.getAttribute("cols").Equals("")) ? "36" : control.Current.getAttribute("cols");
 	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly' disabled='disabled'" : "";
%>
	<div id="div_<apn:name runat='server'/>" class="form-group <apn:cssclass runat='server'/> <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" <!-- #include file="aria-live.inc" --> >
		<% if (!((bool)Context.Items["bareControl"])) { %>
		<!-- #include file="control_label.inc" -->
		<% } %>
		<apn:controlattribute runat='server' attr='prefix'/>
		<textarea 
			name="<apn:name runat='server'/>" 
			id="<apn:name runat='server'/>" 
			rows="<%= Context.Items["rows"] %>" 
			cols="<%= Context.Items["cols"] %>" 
			style="<apn:controlattribute runat='server' attr='style'/><apn:cssstyle runat='server'/>" 
			class="form-control" 
			placeholder="<apn:controlattribute runat='server' attr='placeholder'/>"
			title="<apn:controlattribute runat='server' attr='title' tohtml='true'/>"
                        <apn:metadata runat="server"/>
			<%= Context.Items["readonly"] %>
			<!-- #include file="aria_attributes.inc" -->
		><apn:value runat='server' tohtml='true'/></textarea>
		
		<apn:controlattribute runat='server' attr='suffix'/>
		<% Server.Execute(Page.TemplateSourceDirectory+"/help_icon.aspx"); %>
	</div>
<%
} 
%>
</apn:control>

