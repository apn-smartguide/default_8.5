<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%-- Scripts needed earlier --%>
<script src='<%= CacheBreak("/resources/js/iso-639-1.js") %>'></script>
<script>
	$.getScript({url: '<%= ResolvePath("/handlers/sglib.ashx") %>'});
	var urlCurrentPage = ' <%=GetURLForPage(CurrentPage)%>';
	<%-- var uploader = '<%= ResolvePath("/handlers/uploads.ashx") %>'; --%>
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