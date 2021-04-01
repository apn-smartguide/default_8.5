<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<%
Context.Items["hiddenName"] = ""; 
Context.Items["repeatCode"] = control.Current.getCode();
Context.Items["repeat-name-" + Context.Items["repeat-level"]] = control.Current.getName();
// compute event targets for edit and add modals
string repeatEventTargets = control.Current.getAttribute("eventtarget");
// remove the current div id as it should not be processed through the modal
repeatEventTargets = repeatEventTargets.Replace("\""+control.Current.getName()+"\"","");
if (String.IsNullOrEmpty(repeatEventTargets))
{
	repeatEventTargets = "\"\"";
}
Context.Items["repeat-event-targets-edit-" + Context.Items["repeat-level"]] = repeatEventTargets + ",\"" + control.Current.getName() + "_edit_modal_body" + "\",\"" + control.Current.getName() + "_table" + "\"";
Context.Items["repeat-event-targets-cancel-" + Context.Items["repeat-level"]] = repeatEventTargets + ",\"" + control.Current.getName() + "\"";
Context.Items["repeat-event-targets-add-" + Context.Items["repeat-level"]] = repeatEventTargets + ",\"" + control.Current.getName() + "_add_modal_body" + "\",\"" + control.Current.getName() + "_table" + "\"";

Context.Items["isOnlyStatic"] = true ; 
Context.Items["isSelectable"] = "true".Equals(control.Current.getAttribute("isselectable"));

string CSSClass = control.Current.getCSSClass();
Context.Items["hideAddButton"] = CSSClass.Contains("hide-add-btn");

Context.Items["btnAddTitle"] = "Add";
Context.Items["btnAddCSSClass"] = "btn btn-sm btn-primary repeat_prepare_add_btn";
Context.Items["btnAddStyle"] = "";
Context.Items["btnAddType"] = "prepare_add_instance";

%>
<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget") %>]'<% } %> class='panel panel-default repeat uploads-render <% if ((bool)Context.Items["isSelectable"]) { %> selectable<% } %>' style='<%=control.Current.getCSSStyle()%>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite'<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name='<apn:name runat="server"/>' type='hidden' value='' />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<apn:control runat="server" type="default-instance">
	<div class='panel-heading clearfix'>
		<% if (!(bool)Context.Items["hideAddButton"] && !IsPdf) { %><div class='pull-right'><apn:control id="btnAdd" runat="server" type="prepare_add_instance"><button type='button' class='<%=Context.Items["btnAddCSSClass"]%>' style='<%=Context.Items["btnAddStyle"]%>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <% if (!GetTooltip(btnAdd.Current).Equals("")){ %>title='<%=GetTooltip(btnAdd.Current)%>' aria-label='<%=GetTooltip(btnAdd.Current)%>'<% } %>><%=Context.Items["btnAddTitle"]%></button></apn:control></div><% } %>
		<apn:forEach runat="server">
			<apn:forEach runat="server">
				<apn:forEach runat="server" id="headingControl">
					<% if (headingControl.Current.getCSSClass().Contains("panel-heading-button")) { Context.Items["render-proxy"] = true; ExecutePath("/controls/control.aspx"); Context.Items["render-proxy"] = false; } %>
				</apn:forEach>
			</apn:forEach>
		</apn:forEach>
		<h2 class="panel-title"><% ExecutePath("/controls/custom/control-label.aspx"); %></h2>
	</div>
	</apn:control>
	<div class='drop-popup'><p>Drop your files here</p></div>
	<div class='panel-body' id='div_<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>_table'>
		<table class='<%=control.Current.getCSSClass()%>'>
			<tbody>
			<apn:forEach runat="server" id="status">
				<tr>
					<td>
						<table>
							<tr><td><% ExecutePath("/controls/controls.aspx"); %></td></tr>
							<tr><td>
								<apn:control runat="server" type="delete" id="button">
									<button type='submit' name='<apn:name runat="server"/>_<%= status.getCount()%>' data-eventtarget='["<%=control.Current.getName()%>"]' class='repeat_delbtn <%= Context.Items["hiddenName"] %>_<%= status.getCount()%> btn btn-danger btn-sm pull-right' aria-labelledby='lbl_<apn:name runat="server"/>' onclick='this.value=""; return true;' title='<apn:localize runat="server" key="theme.upload.delete" />'><span class='<apn:localize runat="server" key="theme.icon.delete"/>'></span></button>
								</apn:control>
								<apn:control runat="server" type="prepare_edit_instance">
									<button type='button' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' data-level='<%=Context.Items["repeat-level"]%>' style='cursor:pointer' class='btn btn-primary btn-sm pull-right repeat_prepare_edit_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'><span class='<apn:localize runat="server" key="theme.icon.edit"/>'></span></button>
								</apn:control>
								<apn:control runat="server" type="cancel_add_instance">
									<button type='button' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' data-level='<%=Context.Items["repeat-level"]%>' style='cursor:pointer' class='btn btn-default btn-sm pull-right repeat_cancel_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'><apn:localize runat="server" key="theme.text.cancel"/></button>
								</apn:control>
							</td></tr>
						</table>
					</td>
				</tr>
			</apn:forEach>
			</tbody>
		</table>
	</div>
</div>
</apn:control>