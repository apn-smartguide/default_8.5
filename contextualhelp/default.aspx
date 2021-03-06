<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" autoeventwireup="true" CodeFile="../default/default.aspx.cs" Inherits="Default" Trace="false"%>
<%@ Assembly src="../../default_8.5/SGWebCore.cs" %>
<apn:api5 id="sg5" runat="server"/>
<% 
	ThemesLocations = new string[]{"/..",Theme};
	LogoutURL = GetURLForSmartlet(SmartletName);
	IsPdf = false;
%>
<!DOCTYPE html>
<html lang="<%= CurrentLocale %>">
	<% ExecutePath("/layout/head.aspx"); %>
	<body role="document">
		<div id="loader"><div id="spinner"></div></div>
		<div class="container" role="main">
			<!-- SMARTGUIDE MAIN FORM -->
			<form id="smartguide" action="do.aspx" method="post" enctype="multipart/form-data">
				<div class="jumbotron" id="sgControls">
				  <h1><apn:localize runat="server" key="theme.text.helplink"/></h1>
				  <apn:forEach runat="server">
					<apn:choosecontrol runat="server">
					  <apn:whencontrol runat="server" type="GROUP">
						<apn:control runat="server" id="control">
							<p><%=GetAttribute(control.Current, "label")%></p>
							<apn:help/>
						</apn:control>
					  </apn:whencontrol>
					</apn:choosecontrol>
				  </apn:forEach>
				</div>
				<div id="sgNavButtons">
				  <apn:control runat="server" type="previous" id="button">
					 <input type="submit" name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='<apn:localize runat="server" key="theme.text.helpprevbutton"/>' />
					</apn:control>
				</div>
			</form>
		</div>
		<% ExecutePath("/layout/footer.aspx"); %>
		<% ExecutePath("/layout/scripts.aspx"); %>
		<script>
			<%=Context.Items["javascript"]%>
			$("#loader").fadeOut("fast");
		</script>
	</body>
</html>
