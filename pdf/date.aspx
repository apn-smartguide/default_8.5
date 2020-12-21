<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server">
<tr><td colspan="12">
<table width="100%">
<tr>
	<td style="<%=Context.Items["fieldLabel"]%>">
		<apn:label runat="server"/>
	</td>
</tr>
<tr>
	<td style="<%=Context.Items["fieldValue"]%>">
		<apn:forEach runat="server">
		<apn:choosecontrol runat="server">
			<apn:whencontrol type="INPUT" runat="server">
				<apn:value runat="server"/>
			</apn:whencontrol>
			<apn:whencontrol type="SELECT1" runat="server">
				<apn:value runat="server"/>
			</apn:whencontrol>
			<apn:whencontrol type="LABEL" runat="server">
				<apn:label runat="server"/>
			</apn:whencontrol>
		</apn:choosecontrol>
		</apn:forEach>
	</td>
</tr>
</table>
</td></tr>	
</apn:control>

