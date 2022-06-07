<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<% if (!IsPdf) { %>
<% Context.Items["btn-toolbar"] = true; %>
<div class="row">
	<div class="col-12">
		<div class="btn-toolbar navigation" role="toolbar">
			<%
			string previousEventTargets = "";
			SessionField previousBtn = GetProxyButton("previous", ref previousEventTargets);
			if(previousBtn != null && !previousBtn.isAvailable()) { %>
			<% } else if(previousBtn != null && previousBtn.isAvailable()) { %>
				<button type='button' id='<%=previousBtn.getHtmlName()%>' name='<%=previousBtn.getHtmlName()%>' class='sg <%=previousBtn.getCSSClass()%>' style='<%=previousBtn.getCSSStyle()%>' data-eventtarget='[<%=previousEventTargets%>]' <% if (!GetTooltip(previousBtn).Equals("")){ %>title='<%=GetTooltip(previousBtn)%>' aria-label='<%=GetTooltip(previousBtn)%>'<% } %>><%=previousBtn.getLabel()%></button>
			<% } else { %>
				<apn:control type="previous" runat="server" id="previous"><button type='submit' id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg previous btn <% if(LayoutEngine == "BS4") { Response.Output.Write("btn-secondary mr-auto"); } else { Response.Output.Write("btn-default pull-left"); }%>' <% if (!GetTooltip(previous.Current).Equals("")){ %>title='<%=GetTooltip(previous.Current)%>' aria-label='<%=GetTooltip(previous.Current)%>'<% } %>><%=GetAttribute(previous.Current, "label")%></button></apn:control>
			<% } %>
			<%
			string nextEventTargets = "";
			SessionField nextBtn = GetProxyButton("next", ref nextEventTargets);
			if(nextBtn != null && !nextBtn.isAvailable()) { %>
			<% } else if(nextBtn != null && nextBtn.isAvailable()) { %>
			<button type='button' id='<%=nextBtn.getHtmlName()%>' name='<%=nextBtn.getHtmlName()%>' class='sg <%=nextBtn.getCSSClass()%>' style='<%=nextBtn.getCSSStyle()%>' data-eventtarget='[<%=nextEventTargets%>]' <% if (!GetTooltip(nextBtn).Equals("")){ %>title='<%=GetTooltip(nextBtn)%>' aria-label='<%=GetTooltip(nextBtn)%>'<% } %>><%=nextBtn.getLabel()%></button>
			<% } else { %>
			<apn:control type="next" runat="server" id="next"><button type='submit' id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg next btn btn-primary <%=Class("right")%>' <% if (!GetTooltip(next.Current).Equals("")){ %>title='<%=GetTooltip(next.Current)%>' aria-label='<%=GetTooltip(next.Current)%>'<% } %>><%=GetAttribute(next.Current, "label")%></button></apn:control>
			<% } %>
			<apn:control type="return-cancel" runat="server" id="cancel"><button type='submit' id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg btn <%=Class("btn-secondary")%> <%=Class("right")%>' <% if (!GetTooltip(cancel.Current).Equals("")){ %>title='<%=GetTooltip(cancel.Current)%>' aria-label='<%=GetTooltip(cancel.Current)%>'<% } %>><%=GetAttribute(cancel.Current, "label")%></button></apn:control>
			<apn:control type="return-save" runat="server" id="save"><button type='submit' id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg next btn btn-primary <%=Class("right")%>' <% if (!GetTooltip(save.Current).Equals("")){ %>title='<%=GetTooltip(save.Current)%>' aria-label='<%=GetTooltip(save.Current)%>'<% } %>><%=GetAttribute(save.Current, "label")%></button></apn:control>
			<% if (!CurrentPageCSS.Contains("hide-return-to-summary")) { %>
				<apn:control type="summary" runat="server" id="summary"><button type='submit' id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg btn <%=Class("btn-secondary")%> <%=Class("right")%>' <% if (!GetTooltip(summary.Current).Equals("")){ %>title='<%=GetTooltip(summary.Current)%>' aria-label='<%=GetTooltip(summary.Current)%>'<% } %>><%=GetAttribute(summary.Current, "label")%></button></apn:control>
			<% } %>
			<apn:forEach runat="server" id="row">
				<apn:forEach runat="server" id="col">
					<apn:forEach runat="server" id="sgfield">
						<apn:ChooseControl runat="server">
							<% WizardRender = true; // render btn-wizard if you see any, but don't render proxies in here. %>
							<apn:WhenControl type="TRIGGER" runat="server">
							<% if (IsWizardButton(sgfield.Current) && !sgfield.IsProxy()) { Execute("/controls/button.aspx");} %>
							</apn:WhenControl>
							<apn:WhenControl type="GROUP" runat="server">
								<apn:forEach runat="server" id="groupRow">
									<apn:forEach runat="server" id="groupCol">
										<apn:forEach runat="server" id="groupField">
											<% if (IsWizardButton(groupField.Current) && !groupField.IsProxy()) { Execute("/controls/control.aspx");} %>
										</apn:forEach>
									</apn:forEach>
								</apn:forEach>
							</apn:WhenControl>
							<apn:Otherwise runat="server">
							<% if (IsWizardButton(sgfield.Current) && !sgfield.IsProxy()) { Execute("/controls/custom/buttons.aspx");} %>
							</apn:Otherwise>
							<% WizardRender = false; %>
						</apn:ChooseControl>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
		</div>
	</div>
</div>
<% Context.Items["btn-toolbar"] = false; %>
<% } %>