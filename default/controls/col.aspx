<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
<div class="<apn:controllayoutattribute runat='server' attr='all'/>">
	<% Server.Execute(Page.TemplateSourceDirectory + "/controls.aspx"); %>
</div>
<% } else { %>
	<% Server.Execute(Page.TemplateSourceDirectory + "/controls.aspx"); %>
<% } %>
</apn:control>