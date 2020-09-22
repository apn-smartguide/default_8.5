<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>	

<apn:forEach runat="server" id="status2">
	<% if (status2.Current.getType() == 1000) { %>
		 <tr>
		  <td colspan="2" style="<%=Context.Items["groupTitle"]%>"> 
			<apn:label runat='server'/> <% if (!(status2.getCount() == 1 && status2.Last)) { %><%= status2.getCount() %><% } %>
		  </td>
		 </tr>
			
	<apn:forEach runat="server">
	<apn:choosecontrol runat="server">
		<apn:whencontrol type="ROW" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/row.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="COL" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/col.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="GROUP" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/group.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="REPEAT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/repeat.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="INPUT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/input.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="TEXTAREA" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/field.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SECRET" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/secret.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="DATE" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/date.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SELECT" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SELECT1" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="UPLOAD" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/upload.aspx"); %>
		</apn:whencontrol>
		<apn:whencontrol type="SUB-SMARTLET" runat="server">
			<% Server.Execute(Page.TemplateSourceDirectory + "/subsmartlet.aspx"); %>
		</apn:whencontrol>		
		</apn:choosecontrol>
	</apn:forEach>
	<% }  %>
	
</apn:forEach>


