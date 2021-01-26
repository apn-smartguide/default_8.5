<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:forEach runat="server">	
	<apn:control runat="server" id="controleach">	
		<% if((bool)Context.Items["pdf"] && controleach.Current.getCSSClass().Contains("hide-pdf")) { %>
		<% } else { %>
		<apn:choosecontrol runat="server">
			<apn:whencontrol runat="server" type="ROW">
				<% ExecutePath("/controls/summary/row.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="COL">
				<% ExecutePath("/controls/summary/col.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SUMMARY-SECTION">
				<% ExecutePath("/controls/summary/summary.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="GROUP">																							
				<% ExecutePath("/controls/summary/group.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="REPEAT">
				<% ExecutePath("/controls/summary/repeat.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="INPUT">
				<% ExecutePath("/controls/summary/input.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA">
				<% ExecutePath("/controls/summary/field.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET">
				<% ExecutePath("/controls/summary/secret.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE">																							
				<% ExecutePath("/controls/summary/date.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT">
				<% ExecutePath("/controls/summary/select.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT1">
				<% ExecutePath("/controls/summary/select.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT">
				<% ExecutePath("/controls/summary/statictext.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="IMAGE">																							
				<% ExecutePath("/controls/summary/image.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="UPLOAD" >
				<% ExecutePath("/controls/summary/upload.aspx"); %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="SUB-SMARTLET">
				<% ExecutePath("/controls/summary/subsmartlet.aspx"); %>
			</apn:whencontrol>			
		</apn:choosecontrol>	
		<% } %>
	</apn:control>				
</apn:forEach>