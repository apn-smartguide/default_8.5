<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% if (!control.Current.getCSSClass().Contains("summary-borderless")) { %>
	<div id='div_<apn:name runat="server"/>' class='<%=Class("group-container")%> <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<% if (control.Current.getLabel() != ""){ %>
			<div class='<%=Class("group-header")%>'>
				<h2 class='<%=Class("group-title")%>'><apn:label runat="server" /></h2>
			</div>
		<% } %>
		<div class='<%=Class("group-body")%>'><% ExecutePath("/controls/summary/controls.aspx"); %></div>
	</div>
	<% } else { %>
		<% ExecutePath("/controls/summary/controls.aspx"); %>
	<% } %>
</apn:control>