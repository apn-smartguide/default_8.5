<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a id='error_index_<%=ErrorIndex %>'></a></apn:ifnotcontrolvalid>
	<div class='apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
		<span><strong><apn:label runat="server" /></strong><br/>
		<apn:forEach id="option" runat='server'>
			<apn:choosecontrol runat='server'>
				<apn:whencontrol type="optgroup" runat='server'>
					<apn:forEach id="option_under_group" runat='server'>
						<% if(option_under_group.Current.getAttribute("selected").Equals("selected")) { %>
							<apn:label runat='server'/> &nbsp;
						<% } %>
					</apn:forEach>
				</apn:whencontrol>
				<apn:otherwise runat='server'>
					<% if (option.Current.getAttribute("selected").Equals("selected")) { %>
						<apn:label runat='server'/> &nbsp;
					<% } %>
				</apn:otherwise>
			</apn:choosecontrol>
		</apn:forEach> &nbsp;
		</span>
	</div>
</apn:control>