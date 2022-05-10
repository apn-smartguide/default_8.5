<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%	string customControl = control.Current.getNonLocalizedMetaDataValue("Controls");
	bool renderProxy = (Context.Items["render-proxy"] != null) ? (bool)Context.Items["render-proxy"] : false;
	if((IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) || (!IsPdf && control.Current.getCSSClass().Contains("pdf-only"))) {
	} else if(control.Current.getCSSClass().Contains("proxy") && !renderProxy) {
	} else if (customControl != null && customControl.Equals("file")) {
		if(!control.Current.getValue().Equals("")) {
			//Use the controls Value if you need to dynamically switch the file loaded based on conditions
			Execute(control.Current.getValue());
		} else if(!control.Current.getLabel().Equals("")){
			Execute(control.Current.getLabel());
		}
	} else if (customControl != null && !customControl.Equals("")) {
		string controlsPath = GetCustomControlPathForCurrentControl(customControl);
		if(!controlsPath.Equals("")) Server.Execute(controlsPath);
	} else { %>
	<apn:ChooseControl runat="server">
		<apn:WhenControl runat="server" type="SUMMARY-SECTION"><% Execute("/controls/summary/summary.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="ROW"><% Execute("/controls/row.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="COL"><% Execute("/controls/col.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="GROUP"><% Execute("/controls/group.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="REPEAT"><% Execute("/controls/repeats/repeat.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="DATE"><% Execute("/controls/date.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="INPUT"><% Execute("/controls/input.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="TEXTAREA"><% Execute("/controls/textarea.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SECRET"><% Execute("/controls/secret.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SELECT"><% Execute("/controls/select.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SELECT1"><% Execute("/controls/select1.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="STATICTEXT"><% Execute("/controls/statictext.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="IMAGE"><% Execute("/controls/image.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="UPLOAD"><% Execute("/controls/upload.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="TRIGGER"><% Execute("/controls/button.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="SUB-SMARTLET"><% Execute("/controls/subsmartlet.aspx"); %></apn:WhenControl>
		<apn:WhenControl runat="server" type="RESULT"><% Execute("/controls/result.aspx"); %></apn:WhenControl>
	</apn:ChooseControl>
<% } %>
</apn:control>