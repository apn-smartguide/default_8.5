<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
<tr><td colspan="12">
	<table width="100%">
		<tr><td style="<%=Context.Items["fieldLabel"]%>">
			<apn:label runat='server'/>
		</td></tr>
		<tr><td> 
			&nbsp;<apn:value runat='server'/>
		</td></tr>
	</table>
</td></tr>
</apn:control>