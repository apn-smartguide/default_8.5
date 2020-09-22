<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
<% Context.Items["show-langdetect"] = control.Current.getCSSClass().Contains("show-langdetect"); %>
<% if(control.Current.getSmartletLocales().Length <= 2) { %>
	<apn:forEach runat="server" id="locID" items="languages">
		<% if(!locID.Current.getValue().Equals(Context.Items["currentLocale"])) { %>
		<a id='btn-lang-<%=locID.Current.getValue()%>' data-lang='<%=locID.Current.getValue()%>' href='<%=Context.Items["requestUri"]%>?lang=<%=locID.Current.getValue()%>'></a>
		<% } %>
	</apn:forEach>
<% } else { %>
<div class='locale-picker dropdown pull-right' aria-haspopup='true' aria-expanded='false'>
	<button id='btn-lang-<%=Context.Items["currentLocale"]%>' data-lang='<%=Context.Items["currentLocale"]%>' class='btn btn-default dropdown-toggle' type='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='true'>
		<span id='current-locale'></span> <span class='caret'></span>
	</button>
	<ul class='dropdown-menu'>
		<apn:forEach runat="server" id="localeID" items="languages">
			<li>
				<a id='btn-lang-<%=localeID.Current.getValue()%>' data-lang='<%=localeID.Current.getValue()%>' href='<%=Context.Items["requestUri"]%>?lang=<%=localeID.Current.getValue()%>'></a>
			</li>
		</apn:forEach>
		<% if ((bool)Context.Items["show-langdetect"]) { %>
		<li role='separator' class='divider'></li>
		<li>
			<a data-target='#detectLanguageModal' data-toggle='modal' class='detectLang'>
				<span class='fas fa-microphone'></span>&nbsp;&nbsp;<span class='fas fa-long-arrow-alt-right'></span>&nbsp;&nbsp;<span class='fas fa-language'></span>
			</a>
		</li>
		<% } %>
	</ul>
</div>
<% } %>
</apn:control>