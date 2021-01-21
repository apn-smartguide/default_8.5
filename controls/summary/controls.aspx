<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:forEach runat="server">	
	<apn:control runat="server" id="controleach">	
		<% if((bool)Context.Items["pdf"] && controleach.Current.getCSSClass().Contains("hide-pdf")) { %>
		<% } else { %>
		<apn:choosecontrol runat="server">
			<apn:whencontrol runat="server" type="ROW">
				<% Server.Execute(resolvePath("/controls/summary/row.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="COL">
				<% Server.Execute(resolvePath("/controls/summary/col.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SUMMARY-SECTION">
				<% Server.Execute(resolvePath("/controls/summary/summary.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="GROUP">																							
				<% Server.Execute(resolvePath("/controls/summary/group.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="REPEAT">
				<% Server.Execute(resolvePath("/controls/summary/repeat.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="INPUT">
				<% Server.Execute(resolvePath("/controls/summary/input.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA">
				<% Server.Execute(resolvePath("/controls/summary/field.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET">
				<% Server.Execute(resolvePath("/controls/summary/secret.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE">																							
				<% Server.Execute(resolvePath("/controls/summary/date.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT">
				<% Server.Execute(resolvePath("/controls/summary/select.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT1">
				<% Server.Execute(resolvePath("/controls/summary/select.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT">
				<% Server.Execute(resolvePath("/controls/summary/statictext.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="IMAGE">																							
				<% Server.Execute(resolvePath("/controls/summary/image.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="UPLOAD" >
				<% Server.Execute(resolvePath("/controls/summary/upload.aspx")); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SUB-SMARTLET">
				<% Server.Execute(resolvePath("/controls/summary/subsmartlet.aspx")); %>
			</apn:whencontrol>			
		</apn:choosecontrol>	
		<% } %>
	</apn:control>				
</apn:forEach>