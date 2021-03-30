<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../../default_8.5/SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
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
<div class="row">
<% if ( (int)Context.Items["totalSection"] > 1 ) { %>
<div id="nav-step" class="wizard">
	<% if (!CurrentPageCSS.Contains("hide-step-navigation")) { %>
		<div class="wizard-inner">			
			<!-- <div class='section section-count-<%= (int)Context.Items["totalSection"] + 1 %>'></div> -->
				<ol  class="nav nav-tabs" role="tablist">
					 <apn:forEach runat="server" items="sections" id="section1">
						<li role="presentation">
							<% if ((int)Context.Items["sectionIndex"] == section1.getCount()) { %>
							<div class="connecting-line right-line current"></div>								
							 <a href="#" data-toggle="tab" aria-controls="step1" role="tab" aria-expanded="true" class="active"><strong><i><%=GetAttribute(section1.Current, "label")%></i><span class="round-tab active"><%= section1.getCount() %></span></strong></a>
							<% } else if ((int)Context.Items["sectionIndex"] - section1.getCount() == 1) { %>								
								<a href="#" data-toggle="tab" aria-controls="step2" role="tab" aria-expanded="false"><strong><span class="round-tab"><%= section1.getCount() %></span><i><%=GetAttribute(section1.Current, "label")%></i></strong></a> 																
							<% } else { %>								
								<div class="connecting-line left-line"></div>
								<a href="#" data-toggle="tab" aria-controls="step3" role="tab" aria-expanded="false"><strong><span class="round-tab"><%= section1.getCount() %></span><i><%=GetAttribute(section1.Current, "label")%></i></strong></a>
								<% if ((int)Context.Items["totalSection"] != section1.getCount()) { %>
									<div class="connecting-line right-line"></div>
								<% } %>
							<% } %>
						</li>
					</apn:forEach>
				</ol>				
			<!-- </div> -->
		</div>
	<% } %>
	<% if (!CurrentPageCSS.Contains("hide-progress-bar")) { %>
	<div class="col-xs-12">
		<apn:control runat="server" type="progress" id="progressBar"><div class="wizard progress"><div class="progress-bar" role="progressbar" aria-valuenow="<%= int.Parse(progressBar.Current.getValue()) %>" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;width: <%= int.Parse(progressBar.Current.getValue()) %>%"><%= int.Parse(progressBar.Current.getValue()) %> %</div></div></apn:control>
	</div>
	<% } %>
</div>
</div>
<% } %>