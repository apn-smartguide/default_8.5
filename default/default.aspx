<%@ Assembly Src="../SGWebCore.cs" %>
<%@ Page Language="C#" autoeventwireup="true" CodeFile="default.aspx.cs" Inherits="_Default" Trace="false"%>
<apn:api5 id="sg5" runat="server"/>
<%
	sg = sg5;
	TimerTraceStart("default");
	ThemesLocations = new string[]{Theme,"/.."};
	LogoutURL = GetURLForSmartlet(SmartletName);
%>
<% IsPdf = false; %>
<!DOCTYPE html>
<html lang="<%= CurrentLocale %>">
	<% ExecutePath("/layout/head.aspx"); %>
	<body role="document" class='<apn:control runat="server" type="step"><apn:cssclass runat="server"/></apn:control>' style='<apn:control runat="server" type="step"><apn:cssstyle runat="server"/></apn:control>' >
		<div id="loader"><div id="spinner"></div></div>
		<form id='smartguide_<apn:control runat="server" type="smartlet-code"><apn:value runat="server"/></apn:control>' action="do.aspx" method="post" enctype="multipart/form-data"><%-- do not change the form id as it is referenced in smartguide.js --%>
			<input type="hidden" name="com.alphinat.sgs.anticsrftoken" value="<%=Session["com.alphinat.sgs.anticsrftoken"] %>"/>
			<%-- SmartGuide library definitions --%>
			<span id="sglib"><% ExecutePath("/controls/sglib.aspx"); %></span><%-- required to support actions on fields, must be placed within the SmartGuide form --%>
			<span id="sgControls"><%-- do not change the div id as it is referenced in smartguide.js --%>
			<% ExecutePath("/layout/header.aspx"); %>
			<div class="container" role="main">
				<% SessionField SecondaryNavigation = (SessionField)FindFieldByName("secondary-navigation"); %>
				<% if (SecondaryNavigation != null && !SecondaryNavigation.getLabel().Equals("")) { %>
				<div id="leftcol" class="col-xs-3 hidden-sm hidden-xs" typeof="SiteNavigationElement" id="wb-sec" role="navigation">	
				<% 
					if (SecondaryNavigation != null && !SecondaryNavigation.getLabel().Equals("")) { 
						ExecutePath(SecondaryNavigation.getLabel());
					} else {		
						ExecutePath("/layout/secondary-navigation.aspx");
					} 
				%>
				</div>
				<div class="col-xs-12 col-md-9">
				<% } else { %>
				<div class="col-xs-12">
				<% } %>
					<div class="row page-title">
						<div class="col-xs-12">
							<h2>
								<apn:control runat="server" type="step"><apn:label runat="server" /></apn:control>
							</h2>
						</div>
					</div>
					<% if (ShowWizard) { %>
								<% ExecutePath("/controls/wizard/sections.aspx"); %>
					<% } %>
					<% ExecutePath("/controls/validation.aspx"); %>
					<% ExecutePath("/layout/main.aspx"); %>
					<%-- MAIN LOOP OVER PAGE CONTROLS --%>		
					<% ExecutePath("/controls/controls.aspx"); %>
					<% if (ShowWizard) { %>
					<%-- WIZARD PREV/NEXT BUTTONS --%>
					<div class="navigation">
						<% ExecutePath("/controls/wizard/bottom-controls.aspx"); %>
					</div>
					<% } %>
				</div>
				<% ExecutePath("/layout/footer.aspx"); %>
			</div>
		</form>
		<script>
			<%=Context.Items["javascript"]%>
			$("#loader").fadeOut("slow");
		</script>
	</body>
</html>
<% TimerTraceStop("default"); %>