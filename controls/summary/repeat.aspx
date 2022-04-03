<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
	Context.Items["hiddenName"] = "";
	Context.Items["isOnlyStatic"] = true ;
	int currentLevel = -1;
	if(Context.Items["repeat-level"] != null) {
		currentLevel = (int)Context.Items["repeat-level"];
	}
	currentLevel++;
	Context.Items["repeat-level"] = currentLevel;
	Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
%>
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if (control.Current.getCSSClass().Contains("uploads-render") || control.Current.getCSSClass().Contains("uploads-view")) {
	ExecutePath("/controls/repeats/uploads.aspx");
} else if (control.Current.getCSSClass().Contains("grid-render") || control.Current.getCSSClass().Contains("grid-view")) {
	ExecutePath("/controls/summary/table.aspx");
} else if (control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("block-view")) {
	ExecutePath("/controls/repeats/block.aspx");
} else if (control.Current.getCSSClass().Contains("table-render") || control.Current.getCSSClass().Contains("table-view")) {
	ExecutePath("/controls/summary/table.aspx");
} else if (control.Current.getCSSClass().Contains("datatables") || control.Current.getCSSClass().Contains("datatables-view")) {
	ExecutePath("/controls/summary/table.aspx");
} else {
	ExecutePath("/controls/summary/table.aspx");
} %>
</apn:control>