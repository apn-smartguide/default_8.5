<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SG.Page" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
</div>
<% } else { %>
<div id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> role='alert'>
	<p><% Server.Execute(resolvePath("/controls/custom/control-label.aspx")); %></p>
	<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
</div>
<% } %>
</apn:control>