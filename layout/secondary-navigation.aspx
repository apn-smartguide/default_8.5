<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<nav id="sidebar" class="sidenav affix">
	<ul class="list-unstyled components">
<%
ISmartletPage[] pages = null;
pages = sg.getSmartlet().getSessionSmartlet().getPages();
for (int i = 0; i < pages.Length; i++) {
	ISmartletPage p = pages[i];
	if (!p.getCSSClass().Contains("hidden")) {
		if(p == CurrentPage) { %>
		<li class="active">
			<a href='<%=GetURLForPage(p)%>' class="link-as-post"><%=i+1%>. <%=p.getTitle()%></a>
		</li>
		<% } else { %>
		<li>
			<a href='<%=GetURLForPage(p)%>' class="link-as-post"><%=i+1%>. <%=p.getTitle()%></a>
		</li>
		<% } %>
	<% } %>
<% } %>
	</ul>
</nav>
