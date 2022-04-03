<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<% if (!IsPdf) { %>
	<% ISmartletPage[] breadcrumbs = Breadcrumbs(); %>
	<% if (!CurrentPageCSS.Contains("hide-breadcrumbs")) { %>
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href='<%=HomeURL%>' class="link-as-post">Home</a></li>
				<% for (int i = 0; i < breadcrumbs.Length ; i++) { %>	
					<% string pageTitle = ((ISmartletPage)breadcrumbs[i]).getTitle(); %>
					<% string pageURL = GetURLForPage((ISmartletPage)breadcrumbs[i]); %>
					<% if (i == breadcrumbs.Length - 1) { %>
						<li class="breadcrumb-item active"><%= pageTitle %></li>
					<% } else { %>
						<li class="breadcrumb-item"><a href='<%=pageURL%>' class="link-as-post"><%= pageTitle %></a></li>
					<% } %>
				<% } %>
			</ol>
		</nav>
	<% } %>
<% } %>
