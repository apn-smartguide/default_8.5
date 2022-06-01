<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%-- https://datatables.net/manual/index --%>
<apn:SmartGuide ID="smartlet" smartletID="" dispatchToTemplates="false" RenderPage="false" CalculatePage="false" runat="server" ProcessingEvent="Render" visible="true" />
<apn:api5 id="sg5" runat="server" />
<script runat="server">
	string tableId = HttpUtility.JavaScriptStringEncode(Request["tableId"]);
	SetDatatablesSelections(tableId);

	protected override void OnPreRender(EventArgs e) {
		smartlet.SmartletID = (string)HttpUtility.JavaScriptStringEncode(Request["appID"]);
	}
</script>