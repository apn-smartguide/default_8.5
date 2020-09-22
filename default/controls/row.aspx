<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
<div class="row">
  	<apn:forEach runat='server'>											
  		<apn:choosecontrol runat='server'>
			<apn:whencontrol type="COL" runat='server'>
  				<% Server.Execute(Page.TemplateSourceDirectory + "/col.aspx"); %>
  			</apn:whencontrol>
  		</apn:choosecontrol>
  	</apn:forEach>
</div>
</apn:control>	