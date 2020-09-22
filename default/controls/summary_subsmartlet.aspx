<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">

<apn:forEach runat='server'>					
	<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
</apn:forEach>								

</apn:control>	

