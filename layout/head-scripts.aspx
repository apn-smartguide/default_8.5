<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%-- Scripts needed earlier --%>
<script src='<%= cacheBreak("/resources/js/iso-639-1.js") %>'></script>
<script>
	var keepAlivePage = '<%= resolvePath("/keep-alive.aspx") %>'
	var keepAliveFlag = '<%= isLogged() %>';
	var logoutUrl = '<%= LogoutURL %>';
	var basePath = '<%= BasePath %>';
	var currentLocale = '<%= CurrentLocale %>';
	var supportedLocales = [];
	var smartletName = '<%= SmartletCode %>';
	var workspace = '<%= Workspace %>';
	<apn:ifsmartletmultilingual runat="server">
		<apn:forEach runat="server" id="locale" items="languages">
		supportedLocales.push('<%=locale.Current.getValue()%>'); 
		</apn:forEach>
	</apn:ifsmartletmultilingual>
</script>