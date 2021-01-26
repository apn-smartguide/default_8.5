<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if((bool)Context.Items["pdf"] && control.Current.getCSSClass().Contains("hide-pdf")) { %>
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
										<% ExecutePath("/controls/button.aspx"); %>
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

