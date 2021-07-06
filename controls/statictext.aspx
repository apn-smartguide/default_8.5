<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else { %>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> form-group' style='<apn:controlattribute runat="server" attr="style"/><apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> <apn:metadata runat="server" /> >
	<% if (!BareRender && control.Current.getLabel().Trim().Length > 0){ %><label <%if(control.Current.getCSSClass().Contains("inline")) {%>class='inline'<% } %>><span><% ExecutePath("/controls/custom/control-label.aspx"); %></span></label><% } %>
	<apn:value runat="server"/></div>
	<% } %>
</apn:control>