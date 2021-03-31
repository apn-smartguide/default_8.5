<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ForEach id="field" runat="server">
		<% Context.Items["aria-labelledby"] = Context.Items["labelIdPrefix"].ToString()+"col"+field.getCount(); //override aria-labelledby by table header %>
		<% Context.Items["IsVisible"] = (!field.Current.getAttribute("style").Equals("visibility:hidden;") && !field.Current.getAttribute("visible").Equals("false") && !field.Current.getCSSClass().Contains("hide-from-list-view") && !field.Current.getCSSClass().Contains("proxy")); %>
		<% Context.Items["zClass"] = control.Current.getLayoutAttribute("all") ; %>
		
		<apn:ChooseControl runat="server">
			<apn:whencontrol runat="server" type="INPUT"><% RenderTD("/controls/input.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA"><% RenderTD("/controls/textarea.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET"><% RenderTD("/controls/secret.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE"><% RenderTD("/controls/date.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT"><% RenderTD("/controls/select.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT1"><% RenderTD("/controls/select1.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT"><% RenderTD("/controls/statictext.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="IMAGE">% RenderTD("/controls/image.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="UPLOAD"><% RenderTD("/controls/upload.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:whencontrol runat="server" type="TRIGGER"><% RenderTD("/controls/button.aspx", (bool)Context.Items["IsVisible"], (string)Context.Items["zClass"]); %></apn:whencontrol>
			<apn:Otherwise runat="server"><% ExecutePath("/controls/repeats/table-col.aspx"); %></apn:Otherwise>
	</apn:ChooseControl>
	</apn:forEach>
</apn:control>
<script runat="server">
	public void RenderTD(string ctrl, bool isVisible, string zClass) {
		if(isVisible) Response.Write("<td>");
		ExecutePath(ctrl);
		if(isVisible) Response.Write("</td>");
	}
</script>