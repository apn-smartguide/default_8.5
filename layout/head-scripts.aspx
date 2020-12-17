<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<%-- Scripts needed earlier --%>
<script src='<%= cacheBreak("/resources/js/iso-639-1.js") %>'></script>
<script>
	var keepAlivePage = '<%= resolvePath("/keep-alive.aspx") %>'
	var keepAliveFlag = '<%= isLogged() %>';
	var basePath = '<%= getBasePath() %>';
	var currentLocale = '<%= getCurrentLocale() %>';
	var supportedLocales = [];
	var smartletName = '<%= getSmartletCode() %>';
	var workspace = '<%= getWorkspace() %>';
	<apn:ifsmartletmultilingual runat="server">
		<apn:forEach runat="server" id="locale" items="languages">
		supportedLocales.push('<%=locale.Current.getValue()%>'); 
		</apn:forEach>
	</apn:ifsmartletmultilingual>
</script>