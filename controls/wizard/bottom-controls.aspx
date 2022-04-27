<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<% if (!IsPdf) { %>
<% Context.Items["btn-toolbar"] = true; %>
<div class="row">
	<div class="col-12">
		<div class="btn-toolbar" role="toolbar">
			<%
			string previousEventTargets = "";
			SessionField previousBtn = GetProxyButton("previous", ref previousEventTargets);
			if(previousBtn != null && previousBtn.isAvailable()) { %>
				<button type='submit' name='d_<%=previousBtn.getId()%>' class='sg <%=previousBtn.getCSSClass()%>' style='<%=previousBtn.getCSSStyle()%>' data-eventtarget='[<%=previousEventTargets%>]' <% if (!GetTooltip(previousBtn).Equals("")){ %>title='<%=GetTooltip(previousBtn)%>' aria-label='<%=GetTooltip(previousBtn)%>'<% } %>><%=previousBtn.getLabel()%></button>
			<% } else { %>
				<apn:control type="previous" runat="server" id="previous"><button type='submit' name='<apn:name runat="server"/>' class='sg previous btn <% if(LayoutEngine == "BS4") { Response.Output.Write("btn-secondary mr-auto"); } else { Response.Output.Write("btn-default pull-left"); }%>' <% if (!GetTooltip(previous.Current).Equals("")){ %>title='<%=GetTooltip(previous.Current)%>' aria-label='<%=GetTooltip(previous.Current)%>'<% } %>><%=GetAttribute(previous.Current, "label")%></button></apn:control>
			<% } %>

			<%
			string nextEventTargets = "";
			SessionField nextBtn = GetProxyButton("next", ref nextEventTargets);
			if(nextBtn != null && nextBtn.isAvailable()) { %>
			<button type='submit' name='d_<%=nextBtn.getId()%>' class='sg <%=nextBtn.getCSSClass()%>' style='<%=nextBtn.getCSSStyle()%>' data-eventtarget='[<%=nextEventTargets%>]' <% if (!GetTooltip(nextBtn).Equals("")){ %>title='<%=GetTooltip(nextBtn)%>' aria-label='<%=GetTooltip(nextBtn)%>'<% } %>><%=nextBtn.getLabel()%></button>
			<% } else { %>
			<apn:control type="next" runat="server" id="next"><button type='submit' name='<apn:name runat="server"/>' class='sg next btn btn-primary <%=Class("right")%>' <% if (!GetTooltip(next.Current).Equals("")){ %>title='<%=GetTooltip(next.Current)%>' aria-label='<%=GetTooltip(next.Current)%>'<% } %>><%=GetAttribute(next.Current, "label")%></button></apn:control>
			<% } %>
			<apn:control type="return-cancel" runat="server" id="cancel"><button type='submit' name='<apn:name runat="server"/>' class='sg btn <%=Class("btn-secondary")%> <%=Class("right")%>' <% if (!GetTooltip(cancel.Current).Equals("")){ %>title='<%=GetTooltip(cancel.Current)%>' aria-label='<%=GetTooltip(cancel.Current)%>'<% } %>><%=GetAttribute(cancel.Current, "label")%></button></apn:control>
			<apn:control type="return-save" runat="server" id="save"><button type='submit' name='<apn:name runat="server"/>' class='sg next btn btn-primary <%=Class("right")%>' <% if (!GetTooltip(save.Current).Equals("")){ %>title='<%=GetTooltip(save.Current)%>' aria-label='<%=GetTooltip(save.Current)%>'<% } %>><%=GetAttribute(save.Current, "label")%></button></apn:control>
			<% if (!CurrentPageCSS.Contains("hide-return-to-summary")) { %>
				<apn:control type="summary" runat="server" id="summary"><button type='submit' name='<apn:name runat="server"/>' class='sg btn <%=Class("btn-secondary")%> <%=Class("right")%>' <% if (!GetTooltip(summary.Current).Equals("")){ %>title='<%=GetTooltip(summary.Current)%>' aria-label='<%=GetTooltip(summary.Current)%>'<% } %>><%=GetAttribute(summary.Current, "label")%></button></apn:control>
			<% } %>
			<apn:forEach runat="server" id="row">
				<apn:forEach runat="server" id="col">
					<apn:forEach runat="server" id="field">
						<apn:ChooseControl runat="server">
							<% Context.Items["btn-wizard"] = true; // render btn-wizard if you see any, but don't render proxies in here. %>
							<apn:WhenControl type="TRIGGER" runat="server">
							<% if (field.Current.getCSSClass().Contains("btn-wizard") && !field.Current.getCSSClass().Contains("proxy")) { ExecutePath("/controls/button.aspx");} %>
							</apn:WhenControl>
							<apn:Otherwise runat="server">
							<% if (field.Current.getCSSClass().Contains("btn-wizard") && !field.Current.getCSSClass().Contains("proxy")) { ExecutePath("/controls/custom/buttons.aspx");} %>
							</apn:Otherwise>
							<% Context.Items["btn-wizard"] = false; %>
						</apn:ChooseControl>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
			
		</div>
	</div>
</div>
<% Context.Items["btn-toolbar"] = false; %>
<% } %>