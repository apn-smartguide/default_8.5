<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
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
				<button type='submit' name='d_<%=previousBtn.getId()%>' class='<%=previousBtn.getCSSClass()%>' style='<%=previousBtn.getCSSStyle()%>' data-eventtarget='[<%=previousEventTargets%>]' <% if (!GetTooltip(previousBtn).Equals("")){ %>title='<%=GetTooltip(previousBtn)%>' aria-label='<%=GetTooltip(previousBtn)%>'<% } %>><%=previousBtn.getLabel()%></button>
			<% } else { %>
				<apn:control type="previous" runat="server" id="previous"><button type='submit' name='<apn:name runat="server"/>' class='previous btn btn-secondary mr-auto' <% if (!GetTooltip(previous.Current).Equals("")){ %>title='<%=GetTooltip(previous.Current)%>' aria-label='<%=GetTooltip(previous.Current)%>'<% } %>><%=GetAttribute(previous.Current, "label")%></button></apn:control>
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