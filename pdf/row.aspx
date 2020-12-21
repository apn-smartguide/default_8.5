<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
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