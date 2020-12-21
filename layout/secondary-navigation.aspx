<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
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
