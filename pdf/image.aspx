<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
<tr><td colspan="12">
	<table width="100%">
		<tr><td style="<%=Context.Items["fieldLabel"]%>">
			<img src="<apn:controlattribute attr='src' runat='server'/>" id="<apn:code runat='server'/>" 
				style="width:<apn:controlattribute attr='width' runat='server'/>;height:<apn:controlattribute attr='height' runat='server'/>" 
				alt="<apn:controlattribute attr='alt' runat='server'/>" />
		</td></tr>
		<tr><td style="<%=Context.Items["fieldLabel"]%>"> 
			<apn:label runat="server"/>
		</td></tr>
	</table>
</td></tr>
</apn:control>

