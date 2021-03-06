<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="System.Text.RegularExpressions" %> 
<apn:control runat="server" id="col">
<%
string layout = col.Current.getLayoutAttribute("all");
string colspan = "12";
if (layout!=null){
	Regex regex = new Regex("col-md-(\\d+)");
	Match match = regex.Match(layout);
	if (match.Success) { colspan = match.Groups[1].Value; }
}
%>
<td class='<apn:controllayoutattribute attr="all" runat="server"/>' colspan='<%=colspan%>'>
	<table width="100%">
	<tr><td></td></tr>
	<apn:forEach runat="server"><% ExecutePath("/pdf/controls.aspx"); %></apn:forEach>
	</table>
</td>
</apn:control>