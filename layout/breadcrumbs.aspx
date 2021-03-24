<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% if (!IsPdf) { %>
<% 
//This breadcrumbs is history based.
ISmartletPage[] pages = Smartlet.getHistory();
List<ISmartletPage> breadcrumbsList = new List<ISmartletPage>();
//Add our currentPage to the list fist
breadcrumbsList.Add(CurrentPage);
//Read History in Reverse
for (int i = pages.Length - 1; i >= 0; i--) {
	//Check if we are in a section
	if(!CurrentPageSection.Equals("")) {
		//Otherwise we only keep members of our section
		if(CurrentPageSection == ((SessionPage)pages[i]).getSection(CurrentLocale)) {
			if (pages[i] != CurrentPage && (pages[i] != pages[0] || i == 0)) { breadcrumbsList.Add(pages[i]); } else { break; }
		} else {
			//Once we see we're no longer in the  section, we stop.
			break;
		}
	//Not in a section,
	} else {
		if (pages[i] != CurrentPage && (pages[i] != pages[0] || i == 0)) { breadcrumbsList.Add(pages[i]); } else {
			//If we see ourselves in the history, we stop.
			break;
		}
	}
}
ISmartletPage[] breadcrumbs = breadcrumbsList.ToArray();
Array.Reverse(breadcrumbs);
%>
<% if (!CurrentPageCSS.Contains("hide-breadcrumbs")) { %>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href='<%=HomeURL%>'>Home</a></li>
			<%-- if(!CurrentPageSection.Equals("")) { %><li class="breadcrumb-item"><%=CurrentPageSection%></li><% } --%>
			<% for (int i = 0; i < breadcrumbs.Length ; i++) { %>
				<% string pageTitle = ((ISmartletPage)breadcrumbs[i]).getTitle(); %>
				<% string pageURL = GetURLForPage((ISmartletPage)breadcrumbs[i]); %>
				<% if (i == breadcrumbs.Length - 1) { %><li class="breadcrumb-item active"><%= pageTitle %></li><% } else { %><li class="breadcrumb-item"><a href='<%=pageURL%>'><%= pageTitle %></a></li><% } %></li>
			<% } %>
		</ol>
	</nav>
<% } %>
<% } %>