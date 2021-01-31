<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% 
Context.Items["currentSectionName"]  = "";
Context.Items["sectionIndex"]  = 1;
Context.Items["totalSection"]  = 0;
%>
<apn:control runat="server" type="section" id="currentSection">
<% Context.Items["currentSectionName"] = currentSection.Current.getLabel();%>
</apn:control>
<apn:forEach runat="server" items="sections" id="section">
<% 
	if (section.Current.getLabel().Equals(Context.Items["currentSectionName"])) Context.Items["sectionIndex"] = section.getCount();
	Context.Items["totalSection"] = (int)Context.Items["totalSection"] + 1;
%>
</apn:forEach>
<% if ( (int)Context.Items["totalSection"] >0 ) { %>
<div class="section section-count-<%= (int)Context.Items["totalSection"] + 1 %>">
	<ol>
	<apn:forEach runat="server" items="sections" id="section1">			            
		<li>
			<% if ((int)Context.Items["sectionIndex"] == section1.getCount()) { %>
				<p class="current"><strong><span class="number"><%= section1.getCount() %></span><span class="text"><%=GetAttribute(section1.Current, "label")%></span></strong></p>
			<% } else if ((int)Context.Items["sectionIndex"] - section1.getCount() == 1) { %>
				<p class="before-current"><span class="number"><%= section1.getCount() %></span><span class="text"><%=GetAttribute(section1.Current, "label")%></span></p>
			<% } else { %>
				<p><span class="number"><%= section1.getCount() %></span><span class="text"><%=GetAttribute(section1.Current, "label")%></span></p>
			<% } %>
		</li>
	</apn:forEach>
	</ol>
	<div class="col-md-12">
		<apn:control runat="server" type="progress" id="progressBar"><div class="progress"><div class="progress-bar" role="progressbar" aria-valuenow="<%= int.Parse(progressBar.Current.getValue()) %>" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;width: <%= int.Parse(progressBar.Current.getValue()) %>%"><%= int.Parse(progressBar.Current.getValue()) %> %</div></div></apn:control>
	</div>
</div>
<% } %>