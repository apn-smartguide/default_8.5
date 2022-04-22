<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%-- Scripts needed earlier --%>
<script src='<%= CacheBreak("/resources/js/iso-639-1.js") %>'></script>
<script>
	var urlCurrentPage = ' <%=GetURLForPage(CurrentPage)%>';
	var keepAlivePage = '<%= ResolvePath("/handlers/keepalive.ashx") %>';
	var keepAliveFlag = '<%= IsLogged() %>';
	var sessionDuration = '<%= Session.Timeout %>';
	var logoutPage = '<%= LogoutURL %>';
	var redirPage = '<%= LogoutURL %>';
	var applicationPath = '<%= ApplicationPath %>';
	var basePath = '<%= BasePath %>';
	var currentLocale = '<%= CurrentLocale %>';
	var supportedLocales = [];
	var smartletName = '<%= SmartletCode %>';
	var workspace = '<%= Workspace %>';
	<apn:ifsmartletmultilingual runat="server"><apn:forEach runat="server" id="locale" items="languages">supportedLocales.push('<%=locale.Current.getValue()%>');</apn:forEach></apn:ifsmartletmultilingual>
</script>