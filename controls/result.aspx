<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% if (!IsAvailable(control)) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else { %>
	<div id='div_<apn:name runat="server"/>' class='group knowledge' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<h2><apn:forEach begin="0" end="0" runat="server"><apn:value runat="server" /></apn:forEach></h2>
		<apn:forEach begin="1" runat="server">
			<apn:choosecontrol runat="server">
				<apn:whencontrol type="RESULT_REPEAT" runat="server">
					<apn:forEach runat="server">
						<apn:control runat="server">
							<div class='sgKb'>
								<div class='sgLabel'><apn:forEach begin="0" end="0" runat="server"><apn:value runat="server" /></apn:forEach></div>
								<div class='sgValue'><ul><apn:forEach begin="1" runat="server"><apn:control runat="server"><li><apn:label runat="server" /> : <apn:value runat="server" /></li></apn:control></apn:forEach></ul></div>
							</div>
						</apn:control>
					</apn:forEach>
				</apn:whencontrol>
				<apn:otherwise runat="server">
					<div class='sgKb'>
						<div class='sgLabel'><apn:label runat="server" /></div>
						<div class='sgValue'><apn:value runat="server" /></div>
					</div>
				</apn:otherwise>
			</apn:choosecontrol>
		</apn:forEach>
	</div>
	<% } %>
</apn:control>