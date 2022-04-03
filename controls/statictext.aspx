<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<%
		if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " "; } else { Context.Items["no-col-layout"] = "";}
	%>
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else { %>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> <%=GetCleanCSSClass(control.Current)%> form-group' style='<apn:controlattribute runat="server" attr="style"/><apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> <apn:metadata runat="server" /> >
	<% if (!BareRender && control.Current.getLabel().Trim().Length > 0){ %>
		<label <%if(control.Current.getCSSClass().Contains("inline")) {%>class='inline'<% } %>><span><% ExecutePath("/controls/custom/control-label.aspx"); %></span></label>
	<% } %>
		<span <% if (TTSEnabled && !control.Current.isDynamicValue()) { Response.Output.Write("data-tts='{0}_value'",control.Current.getFieldId()); } %>><apn:value runat="server"/></span>
	<% if (TTSEnabled && !control.Current.isDynamicValue()) { %><span id='<% Response.Output.Write("tts_{0}_value",control.Current.getFieldId()); %>' style='display:none;' class='tts-icon <apn:localize runat="server" key="theme.icon.play"/>'></span><% } %>
	</div>
	<% } %>
</apn:control>