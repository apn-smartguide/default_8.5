<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="System.Text.RegularExpressions" %> 

<apn:control runat="server" id="col">
<%
string layout = col.Current.getLayoutAttribute("all");
string colspan = "12";

if (layout!=null){
	Regex regex = new Regex("col-md-(\\d+)");
	Match match = regex.Match(layout);
	if (match.Success) {
		colspan = match.Groups[1].Value;
	}
}
%>
<td class="<apn:controllayoutattribute attr='all' runat='server'/>" colspan="<%=colspan%>">
	<table width="100%">
	<tr><td></td></tr>
  	<apn:forEach runat='server'>
		<apn:choosecontrol runat='server'>
			<apn:whencontrol type="RECAP" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary.aspx"); %>
			</apn:whencontrol>	
			<apn:whencontrol type="ROW" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/row.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="COL" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/col.aspx"); %>			
			</apn:whencontrol>
			<apn:whencontrol type="GROUP" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/group.aspx"); %>			
			</apn:whencontrol>
			<apn:whencontrol type="REPEAT" runat='server'>										
				<% Server.Execute(Page.TemplateSourceDirectory + "/repeat.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="INPUT" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/input.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="TEXTAREA" runat='server'>							
				<% Server.Execute(Page.TemplateSourceDirectory + "/field.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="SECRET" runat='server'>								
				<% Server.Execute(Page.TemplateSourceDirectory + "/secret.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="DATE" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/date.aspx"); %>		
			</apn:whencontrol>
			<apn:whencontrol type="SELECT" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="SELECT1" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="STATICTEXT" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/statictext.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="IMAGE" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/image.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol type="UPLOAD"  runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/upload.aspx"); %>			
			</apn:whencontrol>
			<apn:whencontrol type="TRIGGER"  runat='server'>
				<tr><td></td></tr>
			</apn:whencontrol>
			<apn:whencontrol type="SUB-SMARTLET" runat='server'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/subsmartlet.aspx"); %>
			</apn:whencontrol>												
			<apn:whencontrol type="RESULT" runat='server'>							
				<% Server.Execute(Page.TemplateSourceDirectory + "/result.aspx"); %>
			</apn:whencontrol>
		</apn:choosecontrol>
  	</apn:forEach>
	</table>
</td>
</apn:control>	