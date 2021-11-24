<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<%-- https://datatables.net/manual/index --%>
<%
smartlet.SmartletID = Request["appID"];
string tableName = Request["tableName"];
%>
<apn:SmartGuide ID="smartlet" smartletID="" dispatchToTemplates="false" runat="server" ProcessingEvent="Render" visible="true" />
<apn:api5 id="sg5" runat="server" />
<%
ISmartletRepeat repeat = (ISmartletRepeat)sg5.Smartlet.findFieldByName(tableName);

string selectClass = repeat.getMetaData("select-class");
string selectStyle = repeat.getMetaData("select-style");

string primaryKeyFieldName = repeat.getMetaData("id");
bool isSelectable = repeat.isSelectable();
string selectionType = repeat.getSelectionType();
%>
{
	"draw": <%=Request["sEcho"]%>,
	"recordsTotal": <%=repeat.getTotal()%>,
	"recordsFiltered": <%=repeat.getTotal()%>,
	"data": [
<%
	string repeatId = repeat.getId();
	ISmartletGroup[] groups = repeat.getGroups();
	for(int i=0;i<groups.Length;i++) {
		ISmartletGroup grp = groups[i];
		int id = i+1; // repeat counter starts at 1
%>
		<% if (i>0) Response.Write(","); %>
		{
			<% 
			// if selectable output the markup for the selector
			if (isSelectable) {
				java.util.ArrayList selections = (java.util.ArrayList)repeat.data("apn:selections");
				string check = "";
				if (selections != null) {
					ISmartletField pKey = grp.findFieldByName(primaryKeyFieldName);
					if (pKey != null)
					{
						string currentValue = pKey.getString();
						if (selections.contains(currentValue))
						{
							grp.selectGroup();
							check = "checked";
						}
						else
						{
							grp.unSelectGroup();
						}
					}
				}
				string inputs = "<input type='hidden' name='d_s" + repeatId + "[" + id + "]' value=''>" ;
				ISmartletField selectControl = grp.findFieldByName(repeat.getName() + "_select");
				if(selectControl != null) { 
					selectControl.calculateAvailability();
					if (selectControl.isAvailable()) {
						inputs = inputs + "<input type='"+selectionType+"' name='d_s"+repeatId+"["+id+"]' id='d_s"+repeatId+"["+id+"]' class='"+selectClass+"' style='"+selectStyle+"' value='true' "+check+">";
					}
				} else {
					//data-group='d_"+repeatId'
					inputs = inputs + "<input type='"+selectionType+"' name='d_s"+repeatId+"["+id+"]' id='d_s"+repeatId+"["+id+"]' class='"+selectClass+"' style='"+selectStyle+"' value='true' "+check+">";
				}
				inputs = HttpUtility.JavaScriptStringEncode(inputs);
				%>
				"selected":"<%=inputs%>",
				<%
			}
			
			ISmartletField[] fields = grp.getFields();
			for(int j=0;j<fields.Length;j++) {
				string fieldid = fields[j].getId();
				string label = fields[j].getLabel();
				string value = "";
				string tooltip = JavascriptEncode(fields[j].getTooltip());
				bool unsafeMeta = !String.IsNullOrEmpty(fields[j].getNonLocalizedMetaData("unsafe"));
				bool addtoresults = true;

				string tooltipStr = "";
				if(!tooltip.Equals("")) {
					tooltipStr = " title='" + tooltip + "' aria-label='" + tooltip + "'";
				}
				
				fields[j].calculateAvailability();
				if (!fields[j].isAvailable() || fields[j].getCSSClass().Contains("proxy") ) {
					value = ""; //"<span id='d_"+fieldid+"["+id+"]'></span>";
					addtoresults = false;
				} else if (fields[j].getTypeConst() == 190000) {
					// special case for buttons
					value = "<button id='d_"+fieldid+"["+id+"]' " + tooltipStr + " class='sg " + fields[j].getCSSClass() + "' style='" + fields[j].getCSSStyle() + "' target='" + fields[j].getNonLocalizedMetaData("target") + "' name='d_"+fieldid+"["+id+"]'>"+label+"</button>";
				} else if (fields[j].getTypeConst() == 80000) {
					// hidden fields
					if (unsafeMeta) { value = fields[j].getString(); }
				} else if (fields[j].getTypeConst() == 30000) {
					// group
					string grpValue = "<div class='no-col'><span class='"+ fields[j].getCSSClass()  +"' style='"+ fields[j].getCSSStyle() +"'>";
					ISmartletField[] grpFields = ((ISmartletGroup)fields[j]).getFields();
					for(int k=0; k<grpFields.Length;k++){
						tooltip = JavascriptEncode(grpFields[k].getTooltip());
						if(!tooltip.Equals("")) {
							tooltipStr = " title='" + tooltip + "' aria-label='" + tooltip + "'";
						}
						if(grpFields[k].isAvailable()) {
							grpValue = grpValue + "<button id='d_"+ grpFields[k].getId()+"["+id+"]' "+ tooltipStr +" class='sg " + grpFields[k].getCSSClass() + "' style='" + grpFields[k].getCSSStyle() + "' target='" + grpFields[k].getNonLocalizedMetaData("target") + "' name='d_"+grpFields[k].getId()+"["+id+"]'>"+grpFields[k].getLabel()+"</button>";
						} else {
							grpValue = grpValue + "<span id='d_"+ grpFields[k].getId()+"["+id+"]' class='form-group'></span>";
						}
					}
					grpValue += "</span></div>";
					value = grpValue;
				} else {
					value = value = "<span id='d_"+fieldid+"["+id+"]' class='form-group " + fields[j].getCSSClass() + "' style='"+ fields[j].getCSSStyle() +"'>" + fields[j].getString() + "</span>";
				}
				// escape sensitive chars
				value = HttpUtility.JavaScriptStringEncode(value);
			
				if (j>0 && addtoresults) Response.Write(",");
				if (addtoresults) Response.Write("\"" + fields[j].getName() + "\":\"" + value + "\"");
			} %>
		}
<% } %>
	]
}