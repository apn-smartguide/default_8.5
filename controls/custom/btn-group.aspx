<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="hidden.inc" -->
<% } else { %>
<% Context.Items["btn-group"] = true; %>
<div class="btn-group" role="group">
	<apn:forEach runat="server" id="row"><%-- Each row --%>
		<apn:chooseControl runat="server">
			<apn:whenControl runat="server" type="ROW">
				<apn:forEach runat="server" id="col"><%-- Each col --%>
					<apn:chooseControl runat="server">
						<apn:whenControl runat="server" type="COL">
							<apn:forEach runat="server" id="field"><%-- Each field --%>
								<apn:chooseControl runat="server">
									<apn:whenControl runat="server" type="TRIGGER">
										<% Server.Execute(resolvePath("/controls/button.aspx")); %>
									</apn:whenControl>
								</apn:choosecontrol>
							</apn:forEach>
						</apn:whenControl>
					</apn:chooseControl>
				</apn:ForEach>
			</apn:whenControl>
		</apn:chooseControl>
	</apn:ForEach>
</div>
<% Context.Items["btn-group"]  = false; %>
<% } %>  						
</apn:control>	

