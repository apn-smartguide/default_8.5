<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%@ Import Namespace="SG.Theme.Core" %>
<apn:control runat="server" id="control">
	<% group = new SG.Theme.Core.Group(this, control); %>
	<%-- Check if modal specified for the group --%>
	<% if ((" " + control.Current.getCSSClass() + " ").IndexOf(" smartmodal ") > -1) { %><% Execute("/controls/modal.aspx"); %>
	<% } else if ((control.Current.getCSSClass()).IndexOf("alert") > -1) { %><% Execute("/controls/alert.aspx"); %>
	<% } else { %>
		<% if (!IsAvailable(control)) { %>
		<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
		<% } else { %>
			<% if (!BareRender) { %>
				<div id='div_<apn:name runat="server"/>' class='<%=Class("group-container")%> <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
				<% if (control.Current.getLabel() != "") { %>
					<div class='<%=Class("group-header")%> clearfix'>
						<% if (group.Collapsible) { %>
							<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='pull-left' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (group.IsOpen) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
						<% } %>
						<apn:forEach runat="server"><apn:forEach runat="server"><apn:forEach runat="server" id="headingControl">
							<apn:ChooseControl runat="server">
								<% 
								if(headingControl.IsHeadingControl()) {
									ProxyRender = true;
									Execute("/controls/control.aspx");
									ProxyRender = false;
								}
								%>
							</apn:ChooseControl>
						</apn:forEach></apn:forEach></apn:forEach>
						
						<% if (control.Current.getLabel() != "") { %>
						<h2 class='<%=Class("group-title")%>'><% Execute("/controls/custom/control-label.aspx"); %></h2>
						<% } %>
					</div>
					<% } %>
					<% if (group.Collapsible) { %>
					<div id='div_<apn:name runat="server"/>_body' class='<%=Class("group-collapse")%> <% if (group.IsOpen) { %>in<% }%>'>
					<% } %>
					<div class='<%=Class("group-body")%>'><% Execute("/controls/controls.aspx"); %></div>
					<% if (group.Collapsible) { %>
					</div>
					<% } %>
				</div>
			<% } else { %>
				<div class='<%=Class("group-body")%>'><% Execute("/controls/controls.aspx"); %></div>
			<% } %>
		<% } %>
	<% } %>
	<% 
	group = null; 
	%>
</apn:control>
<script runat="server">
	//We must declare the repeat variable here, so it remains visible troughout the processing of the control.
	SG.Theme.Core.Group group = null;
</script>