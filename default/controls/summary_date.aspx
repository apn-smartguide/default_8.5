<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
	<div class="row <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" id="div_<apn:name runat='server'/>">
		<div class="col-sm-6">
		  <span><apn:label runat='server'/></span>
		</div>
		<div class="col-sm-6">
  		<apn:forEach runat='server'>
  			<apn:choosecontrol runat='server'>											
  				<apn:whencontrol type="INPUT" runat='server'>												
  					<apn:value runat='server' tohtml='true'/>
  				</apn:whencontrol>
  				<apn:whencontrol type="SELECT1" runat='server'>												
  					<apn:value runat='server' tohtml='true'/>
  				</apn:whencontrol>
  				<apn:whencontrol type="LABEL" runat='server'>	
  					<apn:label runat='server'/>
  				</apn:whencontrol>
  			</apn:choosecontrol>
  		</apn:forEach>
		</div>
	</div>
</apn:control>	
