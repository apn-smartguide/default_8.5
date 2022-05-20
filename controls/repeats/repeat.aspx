<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
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

	if (!IsAvailable(control.Current)) {
		Execute("/controls/hidden.aspx");
	} else if (control.Current.getCSSClass().Contains("uploads-render") || control.Current.getCSSClass().Contains("uploads-view")) {
		Execute("/controls/repeats/uploads.aspx");
	} else if (control.Current.getCSSClass().Contains("grid-render") || control.Current.getCSSClass().Contains("grid-view")) {
		Execute("/controls/repeats/grid.aspx");
	} else if (control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("block-view")) {
		Execute("/controls/repeats/block.aspx");
	} else if (control.Current.getCSSClass().Contains("table-render") || control.Current.getCSSClass().Contains("table-view")) {
		Execute("/controls/repeats/table.aspx");
	} else if (control.Current.getCSSClass().Contains("datatables") || control.Current.getCSSClass().Contains("datatables-view")) {
		Execute("/controls/repeats/datatables.aspx");
	} else {
		Execute("/controls/repeats/table.aspx");
	} %>
</apn:control>