<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = GetAttribute(control.Current, "label"); %>
	<% if (control.Current.getAttribute("visible").Equals("false") || (IsPdf && control.Current.getCSSClass().Contains("hide-pdf"))) { %>
	<section id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></section>
	<% } else { %>
	<section id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> role='alert'>
		<% if(!Context.Items["label"].Equals("")) { %><p><% ExecutePath("/controls/custom/control-label.aspx"); %></p><br><% } %>
		<% ExecutePath("/controls/controls.aspx"); %>
	</section>
	<% } %>
	<% Context.Items["label"] = ""; %>
</apn:control>