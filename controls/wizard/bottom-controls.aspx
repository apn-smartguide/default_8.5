<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<% if (!IsPdf) { %>
<div class="row">
	<div class="col-xs-12">
		<div class="pull-left">
			<%
			string previousEventTargets = "";
			SessionField previousBtn = GetProxyButton("previous", ref previousEventTargets);
			if(previousBtn != null) { %>
			<span id='div_d_<%=previousBtn.getId()%>'><button type='submit' name='d_<%=previousBtn.getId()%>' class='<%=previousBtn.getCSSClass()%>' style='<%=previousBtn.getCSSStyle()%>' data-eventtarget='[<%=previousEventTargets%>]' <% if (!GetTooltip(previousBtn).Equals("")){ %>title='<%=GetTooltip(previousBtn)%>' aria-label='<%=GetTooltip(previousBtn)%>'<% } %>><%=previousBtn.getLabel()%></button></span>
			<% } else { %>
			<apn:control type="previous" runat="server" id="previous"><button type='submit' name='<apn:name runat="server"/>' class='previous btn btn-default' <% if (!GetTooltip(previous.Current).Equals("")){ %>title='<%=GetTooltip(previous.Current)%>' aria-label='<%=GetTooltip(previous.Current)%>'<% } %>><%=GetAttribute(previous.Current, "label")%></button></apn:control>
			<% } %>
			<apn:forEach runat="server" id="row">
				<apn:forEach runat="server" id="col">
					<apn:forEach runat="server" id="field">
						<apn:ChooseControl runat="server">
							<apn:WhenControl type="TRIGGER" runat="server"><% if(field.Current.getCSSClass().Contains("btn-wizard")) { ExecutePath("/controls/button.aspx");} %></apn:WhenControl>
							<apn:WhenControl type="GROUP" runat="server">
								<apn:forEach runat="server" id="grow">
									<apn:forEach runat="server" id="gcol">
										<apn:forEach runat="server" id="gfield">
											<apn:ChooseControl runat="server">
												<apn:WhenControl type="TRIGGER" runat="server"><% if(gfield.Current.getCSSClass().Contains("btn-wizard")) { ExecutePath("/controls/button.aspx");} %></apn:WhenControl>
											</apn:ChooseControl>
										</apn:forEach>
									</apn:forEach>
								</apn:forEach>
							</apn:WhenControl>
						</apn:ChooseControl>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
		</div>
		<div class='pull-right'>
			<apn:control type="summary" runat="server" id="summary"><button type='submit' name='<apn:name runat="server"/>' class='btn btn-default' <% if (!GetTooltip(summary.Current).Equals("")){ %>title='<%=GetTooltip(summary.Current)%>' aria-label='<%=GetTooltip(summary.Current)%>'<% } %>><%=GetAttribute(summary.Current, "label")%></button></apn:control>
			<apn:control type="return-save" runat="server" id="save"><button type='submit' name='<apn:name runat="server"/>' class='next btn btn-primary' <% if (!GetTooltip(save.Current).Equals("")){ %>title='<%=GetTooltip(save.Current)%>' aria-label='<%=GetTooltip(save.Current)%>'<% } %>><%=GetAttribute(save.Current, "label")%></button></apn:control>
			<apn:control type="return-cancel" runat="server" id="cancel"><button type='submit' name='<apn:name runat="server"/>' class='btn btn-default' <% if (!GetTooltip(cancel.Current).Equals("")){ %>title='<%=GetTooltip(cancel.Current)%>' aria-label='<%=GetTooltip(cancel.Current)%>'<% } %>><%=GetAttribute(cancel.Current, "label")%></button></apn:control>
			<%
			string nextEventTargets = "";
			SessionField nextBtn = GetProxyButton("next", ref nextEventTargets);
			if(nextBtn != null) { %>
			<span id='div_d_<%=nextBtn.getId()%>'><button type='submit' name='d_<%=nextBtn.getId()%>' class='<%=nextBtn.getCSSClass()%>' style='<%=nextBtn.getCSSStyle()%>' data-eventtarget='[<%=nextEventTargets%>]' <% if (!GetTooltip(nextBtn).Equals("")){ %>title='<%=GetTooltip(nextBtn)%>' aria-label='<%=GetTooltip(nextBtn)%>'<% } %>><%=nextBtn.getLabel()%></button></span>
			<% } else { %>
			<apn:control type="next" runat="server" id="next"><button type='submit' name='<apn:name runat="server"/>' class='next btn btn-primary' <% if (!GetTooltip(next.Current).Equals("")){ %>title='<%=GetTooltip(next.Current)%>' aria-label='<%=GetTooltip(next.Current)%>'<% } %>><%=GetAttribute(next.Current, "label")%></button></apn:control>
			<% } %>
		</div>
	</div>
</div>
<% } %>