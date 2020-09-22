<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
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

