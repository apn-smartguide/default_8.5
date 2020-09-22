<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<% 
	Context.Items["optionIndex"] = ""; 
	//string requestUri = Request.Url.PathAndQuery;
	//requestUri = requestUri.Substring(requestUri.LastIndexOf("/")+1);
	Context.Items["requestUri"] = Request.Url.AbsolutePath;
%>
<apn:locale runat="server" id="loc">
	<% Context.Items["currentLocale"] = loc.Current.getValue(); %>
</apn:locale>

<!DOCTYPE html>
<html lang="<%=Context.Items["currentLocale"]%>">
	<% Server.Execute(resolvePath("/layout/head.aspx")); %>
	<body role="document" class='<apn:control runat="server" type="step"><apn:cssclass runat="server"/></apn:control>' style='<apn:control runat="server" type="step"><apn:cssstyle runat="server"/></apn:control>' >
		<%-- SMARTGUIDE MAIN FORM --%>
		<form id='smartguide_<apn:control runat="server" type="smartlet-code"><apn:value runat="server"/></apn:control>' action="do.aspx" method="post" enctype="multipart/form-data"><%-- do not change the form id as it is referenced in smartguide.js --%>
			<input type="hidden" name="com.alphinat.sgs.anticsrftoken" value="<%=Session["com.alphinat.sgs.anticsrftoken"] %>"/>
			<%-- SmartGuide library definitions --%>
			<div id="sglib"><% Server.Execute(resolvePath("/controls/sglib.aspx")); %></div><%-- required to support actions on fields, must be placed within the SmartGuide form --%>
			<% Server.Execute(resolvePath("/layout/header.aspx")); %>		
			<div class="container" role="main">
				<% Server.Execute(resolvePath("/layout/main.aspx")); %>
				<div class="row">
					<div class="col-md-3">
						<% Server.Execute(resolvePath("/layout/sidenav.aspx")); %>
					</div>
					<div class="col-md-9">
						<%-- MAIN LOOP OVER PAGE CONTROLS --%>
						<div id="sgControls"><%-- do not change the div id as it is referenced in smartguide.js --%>
							<div id="loader"></div>
							<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
						</div>
					</div>
				</div>
				<%-- NAVIGATION BUTTONS --%>
				<div class="navigation">
					<% Server.Execute(resolvePath("/controls/navigation.aspx")); %>
				</div>
				<% Server.Execute(resolvePath("/layout/footer.aspx")); %>
				<% Server.Execute(resolvePath("/layout/scripts.aspx")); %>
				<div id="loader" style="display: none;"> </div>
			</div>
		</form>
	</body>
</html>
