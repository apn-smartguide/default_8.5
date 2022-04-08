<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
		<div id='div_<apn:name runat="server"/>' style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else { %>
		<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/><apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> <apn:metadata runat="server" />>
		<% if (!BareRender || control.Current.getLabel().Trim().Length == 0){ %><label><span><apn:label runat="server" /></span></label><% } %>
		<% if (control.Current.getValue().Trim().Length > 0) { %><span><apn:value runat="server" /></span><% } %>
		&nbsp;</div>
	<% } %>
</apn:control>