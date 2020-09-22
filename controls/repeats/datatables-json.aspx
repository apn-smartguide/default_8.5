<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
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
				//data-group='d_"+repeatId'
				string inputs = "<input type='hidden' name='d_s"+repeatId+"["+id+"]' value=''><input type='"+selectionType+"'" 
					+" name='d_s"+repeatId+"["+id+"]' id='d_s"+repeatId+"["+id+"]' class='"+selectClass+"' style='"+selectStyle+"' value='true' "+check+">";
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
				
				if (!fields[j].isAvailable()) {
					value = "<span id='div_d_"+fieldid+"["+id+"]' class='form-group'></span>";
				} else if (fields[j].getTypeConst() == 190000) {
					// special case for buttons
					value = "<span id='div_d_"+fieldid+"["+id+"]' class='form-group'><button class='" + fields[j].getCSSClass() + "' style='" + fields[j].getCSSStyle() + "' name='d_"+fieldid+"["+id+"]' style=' '>"+label+"</button></span>	";
				} else if (fields[j].getTypeConst() == 30000) {
					// group
					string grpValue = "<div class='no-col'><span class='"+ fields[j].getCSSClass()  +"' style='"+ fields[j].getCSSStyle() +"'>";
					ISmartletField[] grpFields = ((ISmartletGroup)fields[j]).getFields();
					for(int k=0; k<grpFields.Length;k++){
						if(grpFields[k].isAvailable()) {
							grpValue = grpValue + "<span id='div_d_"+ grpFields[k].getId()+"["+id+"]' class='form-group'><button class='" + grpFields[k].getCSSClass() + "' style='" + grpFields[k].getCSSStyle() + "' name='d_"+grpFields[k].getId()+"["+id+"]' style=' '>"+grpFields[k].getLabel()+"</button></span>";
						} else {
							grpValue = grpValue + "<span id='div_d_"+ grpFields[k].getId()+"["+id+"]' class='form-group'></span>";
						}
					}
					grpValue += "</span></div>";
					value = grpValue;
				} else {
					value = value = "<span id='div_d_"+fieldid+"["+id+"]' class='form-group'>" + fields[j].getString() + "</span>";
				}
				// escape sensitive chars
				value = HttpUtility.JavaScriptStringEncode(value);
			%>
			<% if (j>0) Response.Write(","); %>
				"<%=fields[j].getName()%>":"<%=value%>"
			<% } %>
		}
<% } %>
	]
}