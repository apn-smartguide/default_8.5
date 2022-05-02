<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<main role="main">
	<div class="container">
		<div class="row">
			<% SessionField SecondaryNavigation = (SessionField)FindFieldByName("secondary-navigation"); %>
			<% if (SecondaryNavigation != null) { %>
			<div id="leftcol" class="col-3 d-none d-lg-block" typeof="SiteNavigationElement" id="wb-sec" role="navigation">
				<% if (!SecondaryNavigation.getLabel().Equals("")) { ExecutePath(SecondaryNavigation.getLabel()); } else { ExecutePath("/layout/secondary-navigation.aspx"); } %>
			</div>
			<% } %>
			<div class='<% if (SecondaryNavigation != null) { %>col-9<% } else { %>col-12<% } %>'>
				<div class="row page-title">
					<div class="col-12">
						<h2>
							<apn:control runat="server" type="step">
								<apn:label runat="server" />
							</apn:control>
						</h2>
					</div>
				</div>
				<% if (ShowWizard) { ExecutePath("/controls/wizard/sections.aspx"); } %>
				<% ExecutePath("/controls/validation.aspx"); %>
				<div class="row smartlet-title">
					<div class="col-12">
						<div class="float-right"><img class="float-sm-right" src='<%=ResolvePath("/resources/img/logo.jpg")%>' /></div>
						<h2>
							<apn:control runat="server" type="smartlet-name">
								<apn:value runat="server" />
							</apn:control>
						</h2>
					</div>
				</div>
				<%-- MAIN LOOP OVER PAGE CONTROLS --%>
				<% ExecutePath("/controls/controls.aspx"); %>
				<% if (!HideBottomNavigation) { %>
				<%-- WIZARD PREV/NEXT BUTTONS --%>
				<% ExecutePath("/controls/wizard/bottom-controls.aspx"); %>
				<% } %>
			</div>
		</div>
	</div>
</main> <!-- end content part -->