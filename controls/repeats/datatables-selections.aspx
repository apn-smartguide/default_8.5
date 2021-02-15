<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%-- https://datatables.net/manual/index --%>
<%
smartlet.SmartletID = Request["appID"];
%>
<apn:SmartGuide ID="smartlet" smartletID="" dispatchToTemplates="false" RenderPage="false" CalculatePage="false" runat="server" ProcessingEvent="Render" visible="true" />
<apn:api5 id="sg5" runat="server" />
<%
ISmartletLogger log = sg5.Context.getLogger("selections");

string tableId = Request["tableId"];
// remove prefix and suffixes
if (tableId.IndexOf("d_s") == 0) {
	tableId = tableId.Substring(3);
	int pos = tableId.IndexOf("[");
	tableId = tableId.Substring(0, pos);
}
if (tableId.IndexOf("div_d_") == 0) {
	tableId = tableId.Substring(6);
}

log.debug("tableId: " + tableId);

ISmartletRepeat repeat = (ISmartletRepeat)sg5.Smartlet.findFieldById(tableId);

string primaryKeyFieldName = repeat.getMetaData("id");
bool isSelectable = repeat.isSelectable();
string selectionType = repeat.getSelectionType();

if (repeat.data("apn:selections") == null)
{
	log.debug("no apn:selections found, must create a new one!");
	repeat.data("apn:selections", new java.util.ArrayList());
}

java.util.ArrayList selections = (java.util.ArrayList)repeat.data("apn:selections");

if (selectionType.Equals("radio")) {
	// only one selection allowed, so we first clear everything
	selections.clear();
}

log.debug("number of selections before loop: " + selections.size());

foreach(ISmartletGroup grp in repeat.getGroups())
{
	ISmartletField pKey = grp.findFieldByName(primaryKeyFieldName);
	if (pKey != null) {
		string currentValue = pKey.getString();
		
		log.debug("primary key value: " + currentValue);
		
		if (grp.isGroupSelected())
		{
			if (!selections.contains(currentValue))
				selections.add(currentValue);
		}
		else
		{
			if (selections.contains(currentValue))
				selections.remove(currentValue);
		}
	}
}
log.debug("number of selections after loop: " + selections.size());
%>