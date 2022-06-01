<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<%-- Check if modal specified for the group --%>
	<% if ((" " + control.Current.getCSSClass() + " ").IndexOf(" smartmodal ") > -1) { %><% Execute("/controls/modal.aspx"); %>
	<% } else if ((control.Current.getCSSClass()).IndexOf("alert") > -1) { %><% Execute("/controls/alert.aspx"); %>
	<% } else { %>
		<% if (!IsAvailable(control.Current)) { %>
		<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
		<% } else { %>
			<% if (!BareRender) { %>
				<div id='div_<apn:name runat="server"/>' class='<%=Class("group-container")%> <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
				<% if (control.Current.getLabel() != "") { %>
					<div class='<%=Class("group-header")%> clearfix'>
						<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
							<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='pull-left' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (control.Current.getCSSClass().Contains("open")) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
						<% } %>
						<apn:forEach runat="server"><apn:forEach runat="server"><apn:forEach runat="server" id="headingControl">
							<apn:ChooseControl runat="server">
								<apn:WhenControl type="TRIGGER" runat="server">
									<% 
									if(headingControl.Current.getCSSClass().Contains("panel-heading-button")) {
										RenderProxy = true;  
										Execute("/controls/button.aspx");
										RenderProxy = false; 
									}
									%>
								</apn:WhenControl>
								<apn:Otherwise runat="server">
									<% 
									if(headingControl.Current.getCSSClass().Contains("panel-heading-control")) { 
										RenderProxy = true;
										Execute("/controls/control.aspx");
										RenderProxy = false;
									}
									%>
								</apn:Otherwise>
							</apn:ChooseControl>
						</apn:forEach></apn:forEach></apn:forEach>
						
						<% if (control.Current.getLabel() != "") { %>
						<h2 class='<%=Class("group-title")%>'><% Execute("/controls/custom/control-label.aspx"); %></h2>
						<% } %>
					</div>
					<% } %>
					<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
					<div id='div_<apn:name runat="server"/>_body' class='<%=Class("group-collapse")%> <% if (control.Current.getCSSClass().Contains("open")) { %>in<% }%>'>
					<% } %>
					<div class='<%=Class("group-body")%>'><% Execute("/controls/controls.aspx"); %></div>
					<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
					</div>
					<% } %>
				</div>
			<% } else { %>
				<div class='<%=Class("group-body")%>'><% Execute("/controls/controls.aspx"); %></div>
			<% } %>
		<% } %>
	<% } %>
</apn:control>