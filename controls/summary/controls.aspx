<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:forEach runat="server">	
	<apn:control runat="server" id="controleach">	
		<% if((bool)Context.Items["pdf"] && controleach.Current.getCSSClass().Contains("hide-pdf")) { %>
		<% } else { %>
		<apn:choosecontrol runat="server">
			<apn:whencontrol runat="server" type="ROW">
				<!-- Comment the four div /div below to remove layout view of summary -->
				<div class="row">
					<apn:control runat="server" id="control">
						<apn:forEach runat="server">											
							<apn:choosecontrol runat="server">
								<apn:whencontrol runat="server" type="COL">
									<div class='<apn:ControlLayoutAttribute runat="server" attr="all"/>'>
										<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
									</div>
								</apn:whencontrol>
							</apn:choosecontrol>
						</apn:forEach>
					</apn:control>
				</div>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="COL">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SUMMARY-SECTION">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="GROUP">																							
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_group.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="REPEAT">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_repeat.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="INPUT">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_input.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_field.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_secret.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE">																							
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_date.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_select.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT1">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_select.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_statictext.aspx"); %>
			</apn:whencontrol>
			<%--
				<apn:whencontrol runat="server" type="IMAGE">																							
					<% Server.Execute(Page.TemplateSourceDirectory + "/image.aspx"); %>
				</apn:whencontrol>
			--%>
			<apn:whencontrol runat="server" type="UPLOAD" >
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_upload.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SUB-SMARTLET">
				<% Server.Execute(Page.TemplateSourceDirectory + "/summary_subsmartlet.aspx"); %>
			</apn:whencontrol>			
		</apn:choosecontrol>	
		<% } %>
	</apn:control>				
</apn:forEach>