<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = GetAttribute(control.Current, "label"); %>
	<% if (control.Current.getAttribute("visible").Equals("false") || (IsPdf && control.Current.getCSSClass().Contains("hide-pdf"))) { %>
	<section id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></section>
	<% } else { %>
	<section id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> role='alert'>
		<%-- if(!Context.Items["label"].Equals("")) { %><p><% ExecutePath("/controls/custom/control-label.aspx"); %></p><br><% } --%>
		<%-- ExecutePath("/controls/controls.aspx"); --%>
		<span>
			<apn:ChooseControl runat="server">
				<apn:WhenControl runat="server" type="GROUP">
					<apn:forEach runat="server" id="row">
						<apn:chooseControl runat="server">
							<apn:whenControl runat="server" type="ROW">
								<apn:forEach runat="server" id="col">
									<apn:chooseControl runat="server">
										<apn:whenControl runat="server" type="COL">
											<% Context.Items["no-col-layout"] = col.Current.getLayoutAttribute("all"); %>
											<apn:forEach runat="server" id="field"><% ExecutePath("/controls/control.aspx"); %></apn:forEach>
											<% Context.Items["no-col-layout"] = ""; %>
										</apn:whenControl>
									</apn:chooseControl>
								</apn:ForEach>
							</apn:whenControl>
						</apn:chooseControl>
					</apn:ForEach>
				</apn:WhenControl>
				<apn:otherwise runat="server">
					<%=GetAttribute(control.Current, "label")%><apn:value runat="server"/>
				</apn:otherwise>
			</apn:ChooseControl>
		</span>
	</section>
	<% } %>
	<% Context.Items["label"] = ""; %>
</apn:control>