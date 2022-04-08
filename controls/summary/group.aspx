<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<div id='div_<apn:name runat="server"/>' class='card <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<% if (control.Current.getLabel() != ""){ %><div class='card-header'><h2 class='card-title'><apn:label runat="server" /></h2></div><% } %>
		<div class='card-body'><% ExecutePath("/controls/summary/controls.aspx"); %></div>
	</div>
</apn:control>