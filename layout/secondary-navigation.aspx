<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<nav id="sidebar" class="sidenav affix">
	<ul class="list-unstyled components">
<%
ISmartletPage cpage = sg5.getSmartlet().getSessionSmartlet().getCurrentPage();
ISmartletPage[] pages = null;
pages = sg5.getSmartlet().getSessionSmartlet().getPages();
for (int i = 0; i < pages.Length; i++) {
	ISmartletPage p = pages[i];
	if (!p.getCSSClass().Contains("hidden")) {
		if(p == cpage) { %>
		<li class="active">
			<a href='do.aspx?t_g<%=p.getId()%>=<%=p.getName()%>'><%=i+1%>. <%=p.getTitle()%></a>
		</li>
		<% } else { %>
		<li>
			<a href='do.aspx?t_g<%=p.getId()%>=<%=p.getName()%>'><%=i+1%>. <%=p.getTitle()%></a>
		</li>
		<% } %>
	<% } %>
<% } %>
	</ul>
</nav>
