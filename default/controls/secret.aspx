<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<% 	
Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly' disabled='disabled'" : "";
if(control.Current.getAttribute("visible").Equals("false")) {
%>
	<!-- #include file="render_hidden_div.inc" -->
<%	
} else { 
%>
<div id="div_<apn:name runat='server'/>" 
	class="form-group <apn:cssclass runat='server'/> <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" <!-- #include file="aria-live.inc" --> >
	<!-- #include file="control_label.inc" -->
	<apn:ifcontrolattribute runat='server' attr='prefix or suffix'><div class="input-group"></apn:ifcontrolattribute>
	<apn:ifcontrolattribute runat='server' attr='prefix'><span class="input-group-addon"><apn:controlattribute runat='server' attr='prefix'/></span></apn:ifcontrolattribute>
	<input 
		type="password" 
		name="<%= control.Current.getName() %>" 
		id="<%= control.Current.getName() %>"
		value="<%= control.Current.getHTMLValue() %>"  
		class="<%= control.Current.getCSSClass() %> form-control"
		style='<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>' 
		title="<apn:controlattribute attr='title' tohtml='true' runat='server'/>" 
		placeholder="<apn:controlattribute runat='server' attr='placeholder'/>"
		maxlength="<%= control.Current.getAttribute("maxlength") %>" 
		size="<%= control.Current.getAttribute("size") %>" 
                <apn:metadata runat="server"/>
		<%= Context.Items["readonly"] %>
		<!-- #include file="aria_attributes.inc" -->
	/>
	<apn:ifcontrolattribute runat='server' attr='suffix'><span class="input-group-addon"><apn:controlattribute runat='server' attr='suffix'/></span></apn:ifcontrolattribute>
	<apn:ifcontrolattribute runat='server' attr='prefix or suffix'></div></apn:ifcontrolattribute>
	<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
</div>
<% 
} 
%>
</apn:control>
