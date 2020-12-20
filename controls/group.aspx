<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<apn:control runat="server" id="control">
	<%-- Check if modal specified for the group --%>
	<% if ((" " + control.Current.getCSSClass() + " ").IndexOf(" smartmodal ") > -1) { %>
	<% Server.Execute(resolvePath("/controls/modal.aspx")); %>
	<% } else if ((control.Current.getCSSClass()).IndexOf("alert") > -1) { %>
	<% Server.Execute(resolvePath("/controls/alert.aspx")); %>	
	<% } else { %>
		<% if (control.Current.getAttribute("visible").Equals("false")) { %>
		<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		</div>
		<% } else { %>
			<% bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
			<% if (!bareControl) { %>
			<div id='div_<apn:name runat="server"/>' class='panel panel-default <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
				<% if (control.Current.getLabel() != "") { %>
				<div class='panel-heading clearfix'>
					<apn:forEach runat="server">
						<apn:forEach runat="server">
							<apn:forEach runat="server" id="headingControl">
								<% if (headingControl != null && headingControl.Current.getCSSClass().Contains("panel-heading-button")) { %>
									<% Server.Execute(resolvePath("/controls/button.aspx")); %>
								<% } %>
							</apn:forEach>
						</apn:forEach>
					</apn:forEach>
					<h2 class='panel-title'>
						<% Server.Execute(resolvePath("/controls/custom/control-label.aspx")); %>
					</h2>
				</div>
				<% } %>
				<div class='panel-body'>
					<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
				</div>
			</div>
			<% } else { %>
			<div class='panel-body'>
				<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
			</div>
			<% } %>
		<% } %>
	<% } %>
</apn:control>