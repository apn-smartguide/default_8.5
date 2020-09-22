<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<!-- Breadcrumb trail-->
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
			<p class="current"><strong><span class="number"><%= section1.getCount() %></span><span class="text"><apn:label runat="server"/></span></strong></p>
		<% } else if ((int)Context.Items["sectionIndex"] - section1.getCount() == 1) { %>
			<p class="before-current"><span class="number"><%= section1.getCount() %></span><span class="text"><apn:label runat="server"/></span></p>
		<% } else { %>
			<p><span class="number"><%= section1.getCount() %></span><span class="text"><apn:label runat="server"/></span></p>
		<% } %>
	</li>
</apn:forEach>
</ol>
</div>
<% } %>
<!-- End breadcrumb trail -->