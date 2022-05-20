<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>	
	<apn:control runat="server" id="control">	
	<%
	string customControl = control.Current.getNonLocalizedMetaDataValue("Controls");
	if((IsPdf && IsHidePdf(control.Current)) || (!IsPdf && IsPdfOnly(control.Current))) {
	} else if (!customControl.Equals("")) {
		string controlsPath = GetCustomControlPathForCurrentControl(customControl);
		if(!controlsPath.Equals("")) Server.Execute(controlsPath);
	} else if(IsProxy(control.Current)) {
	} else {
	%>
	<apn:choosecontrol runat="server">
		<apn:whencontrol runat="server" type="ROW"><% Execute("/controls/summary/row.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="COL"><% Execute("/controls/summary/col.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="SUMMARY-SECTION"><% Execute("/controls/summary/summary.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="GROUP"><% Execute("/controls/summary/group.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="REPEAT"><% Execute("/controls/summary/repeat.aspx"); %></apn:whencontrol>
		<apn:whencontrol runat="server" type="SUB-SMARTLET"><% Execute("/controls/summary/subsmartlet.aspx"); %></apn:whencontrol>
		<apn:ifcontrolattribute runat="server" attr="value">
			<apn:whencontrol runat="server" type="INPUT"><% Execute("/controls/summary/input.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA"><% Execute("/controls/summary/field.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET"><% Execute("/controls/summary/secret.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE"><% Execute("/controls/summary/date.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="radio"><% Execute("/controls/summary/radio.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="check"><% Execute("/controls/summary/check.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="lbox"><% Execute("/controls/summary/lbox.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="drop"><% Execute("/controls/summary/drop.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT"><% Execute("/controls/summary/statictext.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="IMAGE"><% Execute("/controls/summary/image.aspx"); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="UPLOAD"><% Execute("/controls/summary/upload.aspx"); %></apn:whencontrol>
		</apn:ifcontrolattribute>
		<apn:ifnotcontrolattribute runat="server" attr="value">
			<apn:ifcontrolattribute runat="server" attr="label">
				<apn:whencontrol runat="server" type="INPUT"><% Execute("/controls/summary/input.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="TEXTAREA"><% Execute("/controls/summary/field.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="SECRET"><% Execute("/controls/summary/secret.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="DATE"><% Execute("/controls/summary/date.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="radio"><% Execute("/controls/summary/radio.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="check"><% Execute("/controls/summary/check.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="lbox"><% Execute("/controls/summary/lbox.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="drop"><% Execute("/controls/summary/drop.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="STATICTEXT"><% Execute("/controls/summary/statictext.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="IMAGE"><% Execute("/controls/summary/image.aspx"); %></apn:whencontrol>
				<apn:whencontrol runat="server" type="UPLOAD"><% Execute("/controls/summary/upload.aspx"); %></apn:whencontrol>
			</apn:ifcontrolattribute>
		</apn:ifnotcontrolattribute>
		<apn:WhenControl runat="server" type="TRIGGER"></apn:WhenControl>
	</apn:choosecontrol>
	<% } %>
</apn:control>