<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:forEach runat='server'>					
	<apn:choosecontrol runat='server'>
		<apn:whencontrol runat='server' type="ROW">
			<%-- Remove the opening and closing div tags below, lines 7, 12, 14, and 19 to remove the layout view of summary --%>
			<div class="row">
				<apn:control runat='server' id="control">
					<apn:forEach runat='server'>											
						<apn:choosecontrol runat='server'>
							<apn:whencontrol runat='server' type="COL">
								<div class="<apn:ControlLayoutAttribute runat='server' attr='all'/>">
									<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
								</div>
							</apn:whencontrol>
						</apn:choosecontrol>
					</apn:forEach>
				</apn:control>
			</div>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="COL">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="SUMMARY-SECTION">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="GROUP">																							
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_group.aspx"); %>				
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="REPEAT">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_repeat.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="INPUT">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_input.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="TEXTAREA">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_field.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="SECRET">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_secret.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="DATE">																							
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_date.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="SELECT">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_select.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="SELECT1">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_select.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="UPLOAD" >
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_upload.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol runat='server' type="SUB-SMARTLET">
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_subsmartlet.aspx"); %>
		</apn:whencontrol>		
	</apn:choosecontrol>					
</apn:forEach>