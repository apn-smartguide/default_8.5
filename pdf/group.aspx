<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control id="group" runat="server">
<tr>
	<td colspan="12" style="border:1px solid #EEE">
<table width="100%" cellpadding="0" cellspacing="0" style="padding:0;margin:0">

<% if (group.Current.getLabel().Length != 0){%>
<tr>
	<td colspan="12" style="<%=Context.Items["groupTitle"]%>">
		<apn:label runat="server"/>
	</td>
</tr>
<% } %>
	<apn:forEach runat="server">
		<% Server.Execute(resolvePath("/pdf/controls.aspx")); %>
	</apn:forEach>
</table>
  </td>
</tr>	
</apn:control>	

