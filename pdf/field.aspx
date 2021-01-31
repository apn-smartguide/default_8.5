<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
<tr><td colspan="12">
	<table width="100%">
		<tr><td style="<%=Context.Items["fieldLabel"]%>">
			<%=GetAttribute(control.Current, "label")%>
		</td></tr>
		<tr><td style="<%=Context.Items["fieldValue"]%>"> 
			&nbsp;<![CDATA[<apn:value runat="server"/>]]>
		</td></tr>
	</table>
</td></tr>
</apn:control>