<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SG.Page" Trace="false"%>
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
%>
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else { %>
<%
	if (control.Current.getCSSClass().IndexOf("datatables") > -1) {
		Server.Execute(resolvePath("/controls/repeats/datatables.aspx"));
	} else if (control.Current.getCSSClass().IndexOf("grid-view") > -1) {
			Server.Execute(resolvePath("/controls/repeats/crud.aspx"));
	} else {
		if ( (control.Current.getAttribute("rendermode").Equals("table") || control.Current.getCSSClass().IndexOf("table-render") > -1) && control.Current.getCSSClass().IndexOf("block-render") == -1) {
			Server.Execute(resolvePath("/controls/repeats/table.aspx"));
		} else {
			Server.Execute(resolvePath("/controls/repeats/block.aspx"));
		}
	}
%>
<% } %>
</apn:control>