<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat='server' id="control">
	<Apn:ForEach id="field" runat="server">
  		<Apn:ChooseControl runat="server">
			<apn:whencontrol runat='server' type="SUMMARY-SECTION">																		
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
					<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/summary.aspx"); %>
				</td>												
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="ROW">
				<apn:control runat='server'>
					<apn:forEach runat='server'>
						<apn:choosecontrol runat='server'>
							<apn:whencontrol runat='server' type="COL">
								<jsp:include page="repeat_col.jsp"/>												
							</apn:whencontrol>
						</apn:choosecontrol>
					</apn:forEach>
				</apn:control>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="GROUP">																							
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
					<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/group.aspx"); %>
				</td>												
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="REPEAT">												
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/repeat.aspx"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="INPUT">
				<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
					<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% } %>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/input.aspx?bare_control=true"); %>
				<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
					</td>
				<% } %>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="TEXTAREA">										
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/textarea.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="SECRET">												
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/secret.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="DATE">																							
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/date.aspx?bare_control=true"); %>
				</td>												
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="SELECT">												
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/select.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="SELECT1">																							
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/select1.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="STATICTEXT">
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/statictext.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="IMAGE">																							
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/image.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="UPLOAD">
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/upload.aspx?bare_control=true"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="TRIGGER">																							
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/button.aspx"); %>
				</td>
			</apn:whencontrol>
			<apn:whencontrol runat='server' type="SUB-SMARTLET">
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/subsmartlet.aspx?bare_control=true"); %>
				</td>							
			</apn:whencontrol>												
			<apn:whencontrol runat='server' type="RESULT">												
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/result.aspx"); %>
				</td>
			</apn:whencontrol>	
  		</apn:choosecontrol>
  	</apn:forEach>

</apn:control>	