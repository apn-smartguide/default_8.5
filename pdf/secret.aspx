<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">
<% if ((!control.Current.getValue().Equals("")) && (control.Current.getValue() != null)) { %>
<tr>
	<td style="<%=Context.Items["fieldLabel"]%>">
		<apn:label runat="server"/>
	</td>
	<td style="<%=Context.Items["fieldValue"]%>">
		*******
	</td>
</tr>
<% } %>
</apn:control>

