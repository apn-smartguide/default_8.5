<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<%
	string customControl = control.Current.getNonLocalizedMetaDataValue("Controls");
	if (!customControl.Equals("")) {
		string controlsPath = getCustomControlPathForCurrentControl(customControl);
		if(!controlsPath.Equals("")) Server.Execute(controlsPath);
	} else if(control.Current.getCSSClass().Contains("proxy")) { 
		//It's a proxy we do nothing.
	} else { 
%>
	<apn:ChooseControl runat="server">
		<apn:WhenControl runat="server" type="SUMMARY-SECTION">
			<% Server.Execute(resolvePath("/controls/summary/summary.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="ROW">
			<% Server.Execute(resolvePath("/controls/row.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="COL">
			<% Server.Execute(resolvePath("/controls/col.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="GROUP">
			<% Server.Execute(resolvePath("/controls/group.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="REPEAT">
			<% Server.Execute(resolvePath("/controls/repeats/repeat.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="DATE">
			<% Server.Execute(resolvePath("/controls/date.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="INPUT">
			<% Server.Execute(resolvePath("/controls/input.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="TEXTAREA">
			<% Server.Execute(resolvePath("/controls/textarea.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="SECRET">
			<% Server.Execute(resolvePath("/controls/secret.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="SELECT">
			<% Server.Execute(resolvePath("/controls/select.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="SELECT1">
			<% Server.Execute(resolvePath("/controls/select1.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="staticText">
			<% Server.Execute(resolvePath("/controls/statictext.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="image">
			<% Server.Execute(resolvePath("/controls/image.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="UPLOAD">
			<% Server.Execute(resolvePath("/controls/upload.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="TRIGGER">
			<% Server.Execute(resolvePath("/controls/button.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="SUB-SMARTLET">
			<% Server.Execute(resolvePath("/controls/subsmartlet.aspx")); %>
		</apn:WhenControl>
		<apn:WhenControl runat="server" type="RESULT">
			<% Server.Execute(resolvePath("/controls/result.aspx")); %>
		</apn:WhenControl>
	</apn:ChooseControl>	
<% } %>
</apn:control>