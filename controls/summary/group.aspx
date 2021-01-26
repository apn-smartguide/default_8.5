<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<div
		id='div_<apn:name runat="server"/>'
		class='panel panel-default <apn:cssclass runat="server"/>'
		style='<apn:cssstyle runat="server"/>'
		<% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<% if (control.Current.getLabel() != ""){ %>
		<div class='panel-heading'>
			<h2 class='panel-title'>
				<apn:label runat="server" />
			</h2>
		</div>
		<% } %>
		<div class='panel-body'>
			<% ExecutePath("/controls/summary/controls.aspx"); %>
		</div>
	</div>
</apn:control>