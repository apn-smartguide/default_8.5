<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:choosecontrol runat="server">
	<apn:whencontrol type="ROW" runat="server">
		<% Server.Execute(resolvePath("/pdf/row.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="COL" runat="server">
		<% Server.Execute(resolvePath("/pdf/col.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="RECAP" runat="server">
		<% Server.Execute(resolvePath("/pdf/summary.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="GROUP" runat="server">
		<% Server.Execute(resolvePath("/pdf/group.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="REPEAT" runat="server">
		<% Server.Execute(resolvePath("/pdf/repeat.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="INPUT" runat="server">
		<% Server.Execute(resolvePath("/pdf/input.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="TEXTAREA" runat="server">
		<% Server.Execute(resolvePath("/pdf/field.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="SECRET" runat="server">
		<% Server.Execute(resolvePath("/pdf/secret.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="DATE" runat="server">
		<% Server.Execute(resolvePath("/pdf/date.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="SELECT" runat="server">
		<% Server.Execute(resolvePath("/pdf/select.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="SELECT1" runat="server">
		<% Server.Execute(resolvePath("/pdf/select.aspx")); %>
	</apn:whencontrol>
	<apn:WhenControl runat="server" type="staticText">
		<% Server.Execute(resolvePath("/pdf/statictext.aspx")); %>
	</apn:WhenControl>
	<apn:whencontrol type="IMAGE" runat="server">
		<% Server.Execute(resolvePath("/pdf/image.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="UPLOAD" runat="server">
		<% Server.Execute(resolvePath("/pdf/upload.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="TRIGGER"  runat='server'>
		<tr><td></td></tr>
	</apn:whencontrol>
	<apn:whencontrol type="SUB-SMARTLET" runat="server">
		<% Server.Execute(resolvePath("/pdf/subsmartlet.aspx")); %>
	</apn:whencontrol>
	<apn:whencontrol type="RESULT" runat="server">
		<% Server.Execute(resolvePath("/pdf/result.aspx")); %>
	</apn:whencontrol>
</apn:choosecontrol>