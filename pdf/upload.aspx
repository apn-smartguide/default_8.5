<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SG.Page" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control id="control" runat="server">
<% if(control.Current.getAttribute("value").Trim().Length > 0) { %>
<tr>
	<td colspan="12" style="<%=Context.Items["fieldLabel"]%>">
		<a target= "_blank" href='upload/<apn:value runat="server"/>?id=<apn:name runat="server"/>&amp;amp;interview=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>'><apn:value runat="server"/></a>
	</td>
</tr>
<% } %>
</apn:control>