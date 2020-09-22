<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
<tr>
  	<apn:forEach runat="server">
  		<apn:choosecontrol runat="server">
			<apn:whencontrol type="COL" runat="server">
  				<% Server.Execute(resolvePath("/pdf/col.aspx")); %>			
  			</apn:whencontrol>
  		</apn:choosecontrol>
  	</apn:forEach>
</tr>
</apn:control>	