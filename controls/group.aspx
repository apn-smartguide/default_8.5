<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
	string containerCSS, headerCSS, titleCSS, collapseCSS, bodyCSS = ""; 
	if(LayoutEngine == "BS4") { 
		containerCSS = "card";
		headerCSS = "card-header";
		titleCSS = "card-title";
		collapseCSS = "collapse";
		bodyCSS = "card-body";
	} else { 
		containerCSS = "panel panel-default";
		headerCSS = "panel-heading";
		titleCSS = "panel-title";
		collapseCSS = "panel-collapse collapse";
		bodyCSS = "panel-body";
	} 
%>
	<%-- Check if modal specified for the group --%>
	<% if ((" " + control.Current.getCSSClass() + " ").IndexOf(" smartmodal ") > -1) { %><% ExecutePath("/controls/modal.aspx"); %>
	<% } else if ((control.Current.getCSSClass()).IndexOf("alert") > -1) { %><% ExecutePath("/controls/alert.aspx"); %>
	<% } else { %>
		<% if (control.Current.getAttribute("visible").Equals("false")) { %>
		<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
		<% } else { %>
			<% if (!BareRender) { %>
				<div id='div_<apn:name runat="server"/>' class='<%=containerCSS%> <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
				<% if (control.Current.getLabel() != "") { %>
					<div class='<%= headerCSS%> clearfix'>
						<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
							<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='pull-left' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (control.Current.getCSSClass().Contains("open")) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
						<% } %>
						<apn:forEach runat="server"><apn:forEach runat="server"><apn:forEach runat="server" id="headingControl">
							<apn:ChooseControl runat="server">
								<apn:WhenControl type="TRIGGER" runat="server">
									<% 
									if(headingControl.Current.getCSSClass().Contains("panel-heading-button")) {
										Context.Items["render-proxy"] = true;  
										ExecutePath("/controls/button.aspx");
										Context.Items["render-proxy"] = false; 
									}
									%>
								</apn:WhenControl>
								<apn:Otherwise runat="server">
									<% 
									if(headingControl.Current.getCSSClass().Contains("panel-heading-control")) { 
										Context.Items["render-proxy"] = true;
										ExecutePath("/controls/control.aspx");
										Context.Items["render-proxy"] = false;
									}
									%>
								</apn:Otherwise>
							</apn:ChooseControl>
						</apn:forEach></apn:forEach></apn:forEach>
						
						<% if (control.Current.getLabel() != "") { %>
						<h2 class='<%= titleCSS %>'><% ExecutePath("/controls/custom/control-label.aspx"); %></h2>
						<% } %>
					</div>
					<% } %>
					<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
					<div id='div_<apn:name runat="server"/>_body' class='<%= collapseCSS%> <% if (control.Current.getCSSClass().Contains("open")) { %>in<% }%>'>
					<% } %>
					<div class='<%= bodyCSS%>'><% ExecutePath("/controls/controls.aspx"); %></div>
					<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
					</div>
					<% } %>
				</div>
			<% } else { %>
				<div class='<%= bodyCSS%>'><% ExecutePath("/controls/controls.aspx"); %></div>
			<% } %>
		<% } %>
	<% } %>
</apn:control>