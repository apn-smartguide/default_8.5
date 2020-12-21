<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server">
	<apn:forEach runat="server">
<tr>
	<td colspan="12" style="<%=Context.Items["groupTitle"]%>">
		<apn:label runat="server"/>
	</td>
</tr>
	<apn:forEach runat="server">
		<% Server.Execute(resolvePath("/pdf/controls.aspx")); %>
	</apn:forEach>
  </apn:forEach>
</apn:control>

