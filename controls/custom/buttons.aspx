<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
if (!IsAvailable(control.Current)) {
	Execute("/controls/hidden.aspx");
} else if(IsPdf && IsHidePdf(control.Current)) {
} else { 
%>
<apn:forEach runat="server" id="row"><%-- Each row --%>
	<apn:chooseControl runat="server">
		<apn:whenControl runat="server" type="ROW">
			<apn:forEach runat="server" id="col"><%-- Each col --%>
				<apn:chooseControl runat="server">
					<apn:whenControl runat="server" type="COL">
						<apn:forEach runat="server" id="field"><%-- Each field --%>
							<apn:chooseControl runat="server">
								<% if (!IsProxy(control.Current) || ((IsProxy(control.Current) && RenderProxy)) || ((IsWizardBtn(control.Current) && RenderWizardBtn))) { %>
								<apn:whenControl runat="server" type="GROUP"><% Execute("/controls/custom/btn-group.aspx"); %></apn:whenControl>
								<apn:whenControl runat="server" type="TRIGGER"><% Execute("/controls/button.aspx"); %></apn:whenControl>
								<% } %>
							</apn:choosecontrol>
						</apn:forEach>
					</apn:whenControl>
				</apn:chooseControl>
			</apn:ForEach>
		</apn:whenControl>
	</apn:chooseControl>
</apn:ForEach>
<% } %>
</apn:control>