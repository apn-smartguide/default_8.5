<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">
	<div class="row <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" id="div_<apn:name runat='server'/>">
		<div class="col-sm-6">
		  <span><apn:label runat='server'/></span>
		</div>
		<div class="col-sm-6">
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
		</div>
	</div>	
</apn:control>