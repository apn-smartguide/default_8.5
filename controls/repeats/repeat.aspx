<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
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
<% } else if (control.Current.getCSSClass().Contains("multifiles-upload")) {
	ExecutePath("/controls/repeats/uploads.aspx");
} else if (control.Current.getCSSClass().Contains("grid-render") || control.Current.getCSSClass().Contains("grid-view")) {
	ExecutePath("/controls/repeats/grid.aspx");
} else if (control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("block-view")) {
	ExecutePath("/controls/repeats/block.aspx");
} else if (control.Current.getCSSClass().Contains("table-render") || control.Current.getCSSClass().Contains("table-view")) {
	ExecutePath("/controls/repeats/table.aspx");
} else if (control.Current.getCSSClass().Contains("datatables") || control.Current.getCSSClass().Contains("datatables-view")) {
	ExecutePath("/controls/repeats/datatables.aspx");
} else {
	ExecutePath("/controls/repeats/table.aspx");
} %>
</apn:control>