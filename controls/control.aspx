<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
	string customControl = GetCustomControlPath(control.Current);
	if((IsPdf && control.IsHidePdf()) || (!IsPdf && control.IsPdfOnly())) {
		//No render
	} else if(control.IsProxy() && !ProxyRender) {
		//No render
	} else if (!customControl.Equals("")) {
		//Custom Render
		Execute(customControl);
	} else {
		//Regular render
	%>
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