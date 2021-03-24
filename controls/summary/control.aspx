<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
	<apn:control runat="server" id="control">
	<% string customControl = control.Current.getNonLocalizedMetaDataValue("Controls");
	if((IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) || (!IsPdf && control.Current.getCSSClass().Contains("pdf-only"))) {
	} else if (!customControl.Equals("")) {
		string controlsPath = GetCustomControlPathForCurrentControl(customControl);
		if(!controlsPath.Equals("")) Server.Execute(controlsPath);
	} else if(control.Current.getCSSClass().Contains("proxy")) {
	} else { %>
	<apn:choosecontrol runat="server">
		<apn:whencontrol runat="server" type="ROW"><% ExecutePath("/controls/summary/row.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="COL"><% ExecutePath("/controls/summary/col.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="SUMMARY-SECTION"><% ExecutePath("/controls/summary/summary.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="GROUP"><% ExecutePath("/controls/summary/group.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="REPEAT"><% ExecutePath("/controls/summary/repeat.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="SUB-SMARTLET"><% ExecutePath("/controls/summary/subsmartlet.aspx"); %></apn:whencontrol>
		<apn:ifcontrolattribute runat="server" attr="value">
			<apn:whencontrol runat="server" type="INPUT"><% ExecutePath("/controls/summary/input.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA"><% ExecutePath("/controls/summary/field.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET"><% ExecutePath("/controls/summary/secret.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE"><% ExecutePath("/controls/summary/date.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="radio"><% ExecutePath("/controls/summary/radio.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="check"><% ExecutePath("/controls/summary/check.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="lbox"><% ExecutePath("/controls/summary/lbox.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="drop"><% ExecutePath("/controls/summary/drop.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT"><% ExecutePath("/controls/summary/statictext.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="IMAGE"><% ExecutePath("/controls/summary/image.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="UPLOAD"><% ExecutePath("/controls/summary/upload.aspx"); %></apn:whencontrol>
		</apn:ifcontrolattribute>
		<apn:ifnotcontrolattribute runat="server" attr="value">
			<apn:ifcontrolattribute runat="server" attr="label">
				<apn:whencontrol runat="server" type="INPUT"><% ExecutePath("/controls/summary/input.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="TEXTAREA"><% ExecutePath("/controls/summary/field.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="SECRET"><% ExecutePath("/controls/summary/secret.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="DATE"><% ExecutePath("/controls/summary/date.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="radio"><% ExecutePath("/controls/summary/radio.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="check"><% ExecutePath("/controls/summary/check.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="lbox"><% ExecutePath("/controls/summary/lbox.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="drop"><% ExecutePath("/controls/summary/drop.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="STATICTEXT"><% ExecutePath("/controls/summary/statictext.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="IMAGE"><% ExecutePath("/controls/summary/image.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="UPLOAD"><% ExecutePath("/controls/summary/upload.aspx"); %></apn:whencontrol>
			</apn:ifcontrolattribute>
		</apn:ifnotcontrolattribute>
		<apn:WhenControl runat="server" type="TRIGGER"></apn:WhenControl>
	</apn:choosecontrol>
	<% } %>
</apn:control>