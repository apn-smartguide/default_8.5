<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.upload" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<apn:SmartGuide ID="smartlet" smartletID="" dispatchToTemplates="false" runat="server" ProcessingEvent="Render" visible="true" />
<apn:api5 id="sg5" runat="server" />
<%-- https://datatables.net/manual/index --%>
<%

//This is required for multiple-table scenario in same page.
//You need to add a field on the page that will contain the name of the current table being processed, and it's value set via a "OnFieldRender" action updatedTableName = requestParameter("tableName")
//Then you need to add a condition on the service call that populates each table to verifiy that it's actually our table that being processed.
//i.e. requestParameter("tableName") == our tableName
string tableName = HttpUtility.JavaScriptStringEncode(Request["tableName"]);

ISmartletRepeat repeat = (ISmartletRepeat)sg5.Smartlet.findFieldByName(tableName);

string selectClass = repeat.getMetaData("select-class");
string selectStyle = repeat.getMetaData("select-style");

string primaryKeyFieldName = repeat.getMetaData("id");
bool isSelectable = repeat.isSelectable();
string selectionType = repeat.getSelectionType();
string draw = "1";
if(Request["sEcho"] != null && !Request["sEcho"].Equals("")) {
	draw = HttpUtility.JavaScriptStringEncode(Request["sEcho"]);
}

%>
{
	"draw": <%=draw%>,
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
				string ctlValue = fields[j].getString();
				string value = "";
				string tooltip = JavascriptEncode(fields[j].getTooltip());
				bool unsafeMeta = !String.IsNullOrEmpty(fields[j].getNonLocalizedMetaData("unsafe"));
				bool addtoresults = true;

				string tooltipStr = "";
				if(!tooltip.Equals("")) {
					tooltipStr = " title='" + tooltip + "' aria-label='" + tooltip + "'";
				} else {
					tooltipStr = "";
				}
				
				fields[j].calculateAvailability();
				if (!fields[j].isAvailable() || fields[j].getCSSClass().Contains("proxy") ) {
					value = "";
					addtoresults = false;
				} else if (fields[j].getTypeConst() == 190000) {
					// special case for buttons
					//Treatment to retrieve the data event targets
					string targetFieldIds = "";
					ISmartletField[] targetFields = fields[j].getEventTarget();
					foreach(ISmartletField targetField in targetFields) {
						if(targetField != null) {
							targetFieldIds += "\"" + targetField.getHtmlName() + "\",";
						}
					}
					if(!string.IsNullOrEmpty(targetFieldIds)) {
						//Remove last comma
						targetFieldIds = targetFieldIds.Substring(0, targetFieldIds.Length-1);
					}
					
					if(fields[j].getCSSClass().Contains("btn-link") && !ctlValue.Equals("")) {
						label = ctlValue;
					}

					value = "<button id='d_"+fieldid+"["+id+"]' " + tooltipStr + " type='button' class='sg " + fields[j].getCSSClass() + "' style='" + fields[j].getCSSStyle() + "' target='" + fields[j].getNonLocalizedMetaData("target") + "' name='d_"+fieldid+"["+id+"]' data-eventtarget='[" + targetFieldIds + "]'>" + label + fields[j].getNonLocalizedMetaData("label-suffix") + "</button>";
				} else if (fields[j].getTypeConst() == 80000) {
					// hidden fields
					if (unsafeMeta) { value = fields[j].getString(); }
				} else if (fields[j].getTypeConst() == 30000) {
					// group
					string grpValue = "";
					grpValue = "<div class='"+ fields[j].getCSSClass()  +"' style='"+ fields[j].getCSSStyle() +"'>";
					ISmartletField[] grpFields = ((ISmartletGroup)fields[j]).getFields();
					for(int k=0; k<grpFields.Length;k++){
						tooltip = JavascriptEncode(grpFields[k].getTooltip());
						if(!tooltip.Equals("")) {
							tooltipStr = " title='" + tooltip + "' aria-label='" + tooltip + "'";
						} else {
							tooltipStr = "";
						}

						string targetFieldIds = "";
						ISmartletField[] targetFields = grpFields[k].getEventTarget();
						foreach(ISmartletField targetField in targetFields) {
							if(targetField != null) {
								targetFieldIds += "\"" + targetField.getHtmlName() + "\",";
							}
						}
						if(!string.IsNullOrEmpty(targetFieldIds)) {
							//Remove last comma
							targetFieldIds = targetFieldIds.Substring(0, targetFieldIds.Length-1);
						}
						string ctrlLabel = grpFields[k].getLabel();
						string ctrlValue = grpFields[k].getString();
						if(grpFields[k].getCSSClass().Contains("btn-link") && !ctrlValue.Equals("")) {
							ctrlLabel = ctrlValue;
						}

						if(grpFields[k].isAvailable()) {
							if(grpFields[k].getTypeConst() == DotnetConstants.ElementType.UPLOAD) {
								if(string.IsNullOrEmpty(grpFields[k].getString())) {
									grpValue = grpValue + "<input type='file' class='form-control' name='d_"+grpFields[k].getId()+"["+id+"]' id='d_"+grpFields[k].getId()+"["+id+"]' style='"+ grpFields[k].getCSSStyle() +"'/>";
								} else {
									ISmartletUpload upload = (ISmartletUpload)grpFields[k];
									grpValue = grpValue + "<div><a target='_blank' href='upload/do.aspx/" + upload.getFileName() + "?id=d_" + grpFields[k].getId()+"["+id+"]&interviewID=" + sg5.Smartlet.getCode() + "'>" + upload.getFileName() + "</a></div>";
								}
							} else {
								grpValue = grpValue + "<button id='d_"+ grpFields[k].getId()+"["+id+"]' "+ tooltipStr +" type='button' class='sg " + grpFields[k].getCSSClass() + "' style='" + grpFields[k].getCSSStyle() + "' target='" + grpFields[k].getNonLocalizedMetaData("target") + "' name='d_"+grpFields[k].getId()+"["+id+"]' data-eventtarget='[" + targetFieldIds + "]'>"+ctrlLabel+"</button>";
							}
						} else {
							grpValue = grpValue + "<span id='d_"+ grpFields[k].getId()+"["+id+"]' class='form-group'></span>";
						}
					}
					grpValue += "</div>";
					value = grpValue;
				} else if (fields[j].getTypeConst() == DotnetConstants.ElementType.UPLOAD) {
					if(string.IsNullOrEmpty(fields[j].getString())) {
						value = "<input type='file' class='form-control' name='d_"+fieldid+"["+id+"]' id='d_"+fieldid+"["+id+"]' style='"+ fields[j].getCSSStyle() +"'/>";
					} else {
						ISmartletUpload upload = (ISmartletUpload)fields[j];
						value = "<div><a target='_blank' href='upload/do.aspx/" + upload.getFileName() + "?id=d_" + fieldid+"["+id+"]&interviewID=" + sg5.Smartlet.getCode() + "'>" + upload.getFileName() + "</a></div>";
					}
				} else {
				    value = "<span id='d_"+fieldid+"["+id+"]' class='form-group " + fields[j].getCSSClass() + "' style='"+ fields[j].getCSSStyle() +"'>" + fields[j].getString() + "</span>";
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
<script runat="server">
	protected override void OnPreRender(EventArgs e) {
		smartlet.SmartletID = (string)HttpUtility.JavaScriptStringEncode(Request["appID"]);
	}
</script>