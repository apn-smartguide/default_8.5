<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>	
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:forEach runat="server" id="status2">
	<% if (status2.Current.getType() == 1000) { %>
		 <tr>
		  <td colspan="2" style="<%=Context.Items["groupTitle"]%>"> 
			<apn:label runat='server'/> <% if (!(status2.getCount() == 1 && status2.Last)) { %><%= status2.getCount() %><% } %>
		  </td>
		 </tr>
			
	<apn:forEach runat="server">
		<% Server.Execute(resolvePath("/pdf/controls.aspx")); %>
	</apn:forEach>
	<% }  %>
	
</apn:forEach>


