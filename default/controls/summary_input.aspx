<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">

	<% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>
		<% Server.Execute(Page.TemplateSourceDirectory + "/summary_field.aspx"); %>
	<% } %>	
	
</apn:control>

