<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<%	string customControl = control.Current.getNonLocalizedMetaDataValue("Controls");
	bool renderProxy = (Context.Items["render-proxy"] != null) ? (bool)Context.Items["render-proxy"] : false;
	if((IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) || (!IsPdf && control.Current.getCSSClass().Contains("pdf-only"))) {
	} else if(control.Current.getCSSClass().Contains("proxy") && !renderProxy) {
	} else if (customControl != null && customControl.Equals("file")) {
		if(!control.Current.getValue().Equals("")) {
			//Use the controls Value if you need to dynamically switch the file loaded based on conditions
			ExecutePath(control.Current.getValue());
		} else if(!control.Current.getLabel().Equals("")){
			ExecutePath(control.Current.getLabel());
		}
	} else if (customControl != null && !customControl.Equals("")) {
		string controlsPath = GetCustomControlPathForCurrentControl(customControl);
		if(!controlsPath.Equals("")) Server.Execute(controlsPath);
	} else { %>
	<apn:ChooseControl runat="server">
		<apn:WhenControl runat="server" type="SUMMARY-SECTION"><% ExecutePath("/controls/summary/summary.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="ROW"><% ExecutePath("/controls/row.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="COL"><% ExecutePath("/controls/col.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="GROUP"><% ExecutePath("/controls/group.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="REPEAT"><% ExecutePath("/controls/repeats/repeat.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="DATE"><% ExecutePath("/controls/date.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="INPUT"><% ExecutePath("/controls/input.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="TEXTAREA"><% ExecutePath("/controls/textarea.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SECRET"><% ExecutePath("/controls/secret.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SELECT"><% ExecutePath("/controls/select.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SELECT1"><% ExecutePath("/controls/select1.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="STATICTEXT"><% ExecutePath("/controls/statictext.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="IMAGE"><% ExecutePath("/controls/image.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="UPLOAD"><% ExecutePath("/controls/upload.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="TRIGGER"><% ExecutePath("/controls/button.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SUB-SMARTLET"><% ExecutePath("/controls/subsmartlet.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="RESULT"><% ExecutePath("/controls/result.aspx"); %></apn:WhenControl>
	</apn:ChooseControl>
<% } %>
</apn:control>