<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<Apn:ForEach runat="server">											
	<Apn:ChooseControl runat="server">	
		<Apn:WhenControl runat="server" type="SUMMARY-SECTION">
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/summary.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="ROW">
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/row.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="COL">
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/col.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="GROUP">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/group.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="REPEAT">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/repeat.aspx"); %>
		</Apn:WhenControl>							
		<Apn:WhenControl runat="server" type="INPUT">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/input.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="TEXTAREA">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/textarea.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="SECRET">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/secret.aspx"); %>
		</Apn:WhenControl>												
		<Apn:WhenControl runat="server" type="DATE">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/date.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="SELECT">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/select.aspx"); %>
		</Apn:WhenControl>											
		<Apn:WhenControl runat="server" type="SELECT1">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/select1.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="staticText">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/statictext.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="image">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/image.aspx"); %>
		</Apn:WhenControl>						
		<Apn:WhenControl runat="server" type="UPLOAD">
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/upload.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="TRIGGER">
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/button.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="SUB-SMARTLET">
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/subsmartlet.aspx"); %>
		</Apn:WhenControl>
		<Apn:WhenControl runat="server" type="RESULT">												
			<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/result.aspx"); %>
		</Apn:WhenControl>
	</apn:ChooseControl>
</apn:forEach>
