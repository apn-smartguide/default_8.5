<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:SmartGuide ID="smartlet" smartletID="" dispatchToTemplates="false" runat="server" ProcessingEvent="Render" visible="true" />
<apn:api5 id="sg5" runat="server" />
<%-- https://datatables.net/manual/index --%>
<%
//This is required for multiple-table scenario in same page.
//You need to add a field on the page that will contain the name of the current table being processed, and it's value set via a "OnFieldRender" action updatedTableName = requestParameter("tableName")
//Then you need to add a condition on the service call that populates each table to verifiy that it's actually our table that being processed.
//i.e. requestParameter("tableName") == our tableName
string tableName = HttpUtility.JavaScriptStringEncode(Request["tableName"]);
Logger.debug("datatables-json:" + tableName);
string draw = "1";
if(Request["sEcho"] != null && !Request["sEcho"].Equals(""))
{
	draw = HttpUtility.JavaScriptStringEncode(Request["sEcho"]);
}
Response.Output.Write(Repeat.GetDatatablesJSONResult(this, tableName, draw));
%>
<script runat="server">
	protected override void OnPreRender(EventArgs e) {
		smartlet.SmartletID = (string)HttpUtility.JavaScriptStringEncode(Request["appID"]);
	}
</script>