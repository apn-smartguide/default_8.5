<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../default_8.5/SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!IsPdf) { %>
<% 
Context.Items["currentSectionName"] = "";
Context.Items["currentPageName"]  = "";
Context.Items["pageIndex"]  = 1;
Context.Items["totalPages"]  = 0;
%
<apn:control runat="server" type="section" id="currentSection"><% Context.Items["currentSectionName"] = currentSection.Current.getLabel();%></apn:control>
<apn:control runat="server" type="page" id="currentPage"><% Context.Items["currentPageName"] = currentPage.Current.getLabel();%></apn:control>
<apn:forEach runat="server" items="global-navigation" id="navPage">
<% 
	if (navPage.Current.getLabel().Equals(Context.Items["currentPageName"])) Context.Items["pageIndex"] = navPage.getCount();
	Context.Items["totalPages"] = (int)Context.Items["totalPages"] + 1;
%>
</apn:forEach>
<% if (!CurrentPageCSS.Contains("hide-breadcrumbs")) { %>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href='<%=GetURLForSmartlet("portal-home")%>'>Home</a></li>
			<% if(!CurrentPageSection.Equals("")) { %>
				<li class="breadcrumb-item"><%=CurrentPageSection%></li>
			<% } %>
			<% if ( (int)Context.Items["totalPages"] > 1 ) { %>
			<apn:forEach runat="server" items="global-navigation" id="sgPage">
				<% string pageTitle = GetAttribute(sgPage.Current, "label"); %>
				<% if ((int)Context.Items["pageIndex"] == sgPage.getCount()) { %>
					<li class="breadcrumb-item active"><%= pageTitle %></li>
				<% } else if ((int)Context.Items["pageIndex"] > sgPage.getCount()) { %>
					<li class="breadcrumb-item"><a href='<%=GetURLForSmartlet(sgPage.Current.getCode())%>'><%= pageTitle %></a></li>
				<% } %>
			</li>
			</apn:forEach>
			<% } %>
		</ol>
	</nav>
<% } %>
<% } %>