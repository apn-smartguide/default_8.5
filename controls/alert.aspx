<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["label"] = GetAttribute(control.Current, "label"); %>
	<% if (control.Current.getAttribute("visible").Equals("false") || (IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) || (IsSummary && control.Current.getCSSClass().Contains("hide-summary"))) { %>
	<section id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></section>
	<% } else { %>
	<section id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> role='alert'>
	<%
		bool hasLabel = !Context.Items["label"].Equals("");
		bool isDismissable = control.Current.getCSSClass().Contains("dismissable");
	%>
	<% if (hasLabel || isDismissable) { %>
		<div style="display: flex;">
		<% if(hasLabel) { %><apn:label runat="server"/><% } %>
		<% if (isDismissable) { %>
			<button aria-label="Close" class="close" data-dismiss="alert" type="button" style="padding: 1rem; margin-left: auto">
				<span aria-hidden="true">×</span>
			</button>
		<%}%>
		</div>
	<%}%>
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
			<apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><p><apn:value runat="server"/></p></apn:otherwise>
		</apn:ChooseControl>
	</section>
	<% } %>
	<% Context.Items["label"] = ""; %>
</apn:control>