<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% Context.Items["show-langdetect"] = control.Current.getCSSClass().Contains("show-langdetect"); %>
	<apn:ifsmartletmultilingual runat="server">
		<div class='row'>
			<div class='col-12 lang-picker btn-block'>
				<apn:forEach runat="server" id="locale" items="languages">
					<%  String active = (locale.Current.getValue().Equals(CurrentLocale) ? " btn-primary" : ""; %>
					<a id='btn-lang-<%=locale.Current.getValue()%>' class='btn btn-secondary btn-xlarge <%=active%>' data-lang='<%=locale.Current.getValue()%>' href='<%= GetRequestURI() %>?lang=<%=locale.Current.getValue()%>' class="link-as-post"><%=locale.Current.getValue()%></a>
				</apn:forEach>
				<% if ((bool)Context.Items["show-langdetect"]) { %><a data-target='#detectLanguageModal' data-toggle='modal' class='btn btn-secondary btn-xlarge detectLang'><span class='fas fa-microphone'></span>&nbsp;&nbsp;<span class='fas fa-long-arrow-alt-right'></span>&nbsp;&nbsp;<span class='fas fa-language'></span></a><% } %>
			</div>
		</div>
	</apn:ifsmartletmultilingual>
</apn:control>