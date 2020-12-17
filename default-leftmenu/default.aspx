<%@ Page Language="C#" autoeventwireup="true" CodeFile="../default/default.aspx.cs" Inherits="_Default" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<%
	TimerTraceStart("default");
	Context.Items["optionIndex"] = "";
	setThemeLocations(new string[]{"/..",sg5.Smartlet.getTheme()});
	setLogoutURL(getURLForSmartlet(getSmartletName()));
%>
<!DOCTYPE html>
<html lang="<%= getCurrentLocale() %>">
<% Server.Execute(resolvePath("/layout/head.aspx")); %>
<body role="document" class='<apn:control runat="server" type="step"><apn:cssclass runat="server"/></apn:control>' style='<apn:control runat="server" type="step"><apn:cssstyle runat="server"/></apn:control>'>
	<div id="loader"><div id="spinner"></div></div>
	<div class="container" role="main">
		<%-- SMARTGUIDE MAIN FORM --%>
		<form id='smartguide_<apn:control runat="server" type="smartlet-code"><apn:value runat="server"/></apn:control>' action="do.aspx" method="post" enctype="multipart/form-data">
			<%-- do not change the form id as it is referenced in smartguide.js --%>
			<input type="hidden" name="com.alphinat.sgs.anticsrftoken" value="<%=Session["com.alphinat.sgs.anticsrftoken"] %>" />
			<%-- SmartGuide library definitions --%>
			<span id="sglib"><% Server.Execute(resolvePath("/controls/sglib.aspx")); %></span>
			<%-- required to support actions on fields, must be placed within the SmartGuide form --%>
			<span id="sgControls"><%-- do not change the div id as it is referenced in smartguide.js --%>
				<% Server.Execute(resolvePath("/layout/header.aspx")); %>
				<% Server.Execute(resolvePath("/layout/main.aspx")); %>
				<div class="row">
					<div id="leftcol" class="col-md-3">
						<% Server.Execute(resolvePath("/layout/secondary-navigation.aspx")); %>
					</div>
					<div class="col-md-9">
						<% if (showWizard()) { %>
							<% Server.Execute(resolvePath("/controls/wizard/sections.aspx")); %>
						<% } %>
						<div class="row page-title">
							<div class="col-md-12">
								<h2>
									<apn:control runat="server" type="step"><apn:label runat="server" /></apn:control>
								</h2>
							</div>
						</div>
						<% Server.Execute(resolvePath("/controls/validation.aspx")); %>
						<%-- MAIN LOOP OVER PAGE CONTROLS --%>
						<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
						<% if (showWizard()) { %>
						<%-- WIZARD PREV/NEXT BUTTONS --%>
						<div class="navigation">
							<% Server.Execute(resolvePath("/controls/wizard/bottom-controls.aspx")); %>
						</div>
						<% } %>
					</div>
				</div>
				<% Server.Execute(resolvePath("/layout/footer.aspx")); %>
			</span>
		</form>
	</div>
	<script>
		<%=Context.Items["javascript"]%>
		$("#loader").fadeOut("slow");
	</script>
</body>
</html>
<% TimerTraceStop("default"); %>