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
<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget") %>]'<% } %> class='card repeat uploads-render <% if ((bool)Context.Items["isSelectable"]) { %> selectable<% } %>' style='<%=control.Current.getCSSStyle()%>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite'<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name='<apn:name runat="server"/>' type='hidden' value='' />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<apn:control runat="server" type="default-instance">
	<div class='card-header clearfix'>
		<% if (!(bool)Context.Items["hideAddButton"] && !IsPdf && !IsSummary) { %><div class='float-right'><apn:control id="btnAdd" runat="server" type="prepare_add_instance"><button type='button' class='<%=Context.Items["btnAddCSSClass"]%>' style='<%=Context.Items["btnAddStyle"]%>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <% if (!GetTooltip(btnAdd.Current).Equals("")){ %>title='<%=GetTooltip(btnAdd.Current)%>' aria-label='<%=GetTooltip(btnAdd.Current)%>'<% } %>><%=Context.Items["btnAddTitle"]%></button></apn:control></div><% } %>
		<apn:forEach runat="server">
			<apn:forEach runat="server">
				<apn:forEach runat="server" id="headingControl">
					<% if ((headingControl.Current.getCSSClass().Contains("panel-heading-button") || headingControl.Current.getCSSClass().Contains("panel-heading-control")) && !IsPdf && !IsSummary) { Context.Items["render-proxy"] = true; ExecutePath("/controls/control.aspx"); Context.Items["render-proxy"] = false; } %>
				</apn:forEach>
			</apn:forEach>
		</apn:forEach>
		<h2 class="card-title"><% ExecutePath("/controls/custom/control-label.aspx"); %></h2>
	</div>
	</apn:control>
	<div class='drop-popup'><p>Drop your files here</p></div>
	<div class='card-body' id='div_<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>_table'>
		<table class='<%=control.Current.getCSSClass()%>'>
			<tbody>
			<apn:forEach runat="server" id="status">
				<% Context.Items["optionIndex"] = status.getCount(); %>
				<tr>
					<td>
						<table>
							<tr><td><% ExecutePath("/controls/controls.aspx"); %></td></tr>
							<tr><td class='text-right'>
								<apn:control runat="server" type="prepare_edit_instance">
									<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
									<% SessionField editBtn = GetProxyButton(Context.Items["repeatCode"]+"_edit", status.getCount()-1, ref eventTargets); %>
									<% if(editBtn != null && editBtn.isAvailable()) { %>
										<span 
										id='<apn:name runat="server"/>_<%= status.getCount()%>' 
										role='button'
										class='<%=editBtn.getCSSClass()%>' 
										style='<%=editBtn.getCSSStyle()%>'
										data-eventtarget='[<%=eventTargets%>]' 
										data-repeat-index-name='<%=Context.Items["hiddenName"]%>' 
										data-instance-pos='<%= status.getCount()%>' 
										aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
										title='<%=GetTooltip(editBtn)%>'>
											<%=editBtn.getLabel()%>
										</span>
									<% } %>
								</apn:control>
								<apn:control runat="server" type="delete">
									<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
									<% SessionField deleteBtn = GetProxyButton(Context.Items["repeatCode"]+"_delete", status.getCount()-1, ref eventTargets); %>
									<% if(deleteBtn != null && deleteBtn.isAvailable()) { %>
										<span 
										id='<apn:name runat="server"/>_<%= status.getCount()%>' 
										role='button'
										class='<%=deleteBtn.getCSSClass()%>' 
										style='<%=deleteBtn.getCSSStyle()%>'
										data-eventtarget='[<%=eventTargets%>]' 
										data-repeat-index-name='<%=Context.Items["hiddenName"]%>' 
										data-instance-pos='<%= status.getCount()%>' 
										aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
										title='<%=GetTooltip(deleteBtn)%>'>
											<%=deleteBtn.getLabel()%>
										</span>
									<% } %>
									<% SessionField cancelBtn = GetProxyButton(Context.Items["repeatCode"]+"_cancel", status.getCount()-1, ref eventTargets); %>
									<% if(cancelBtn != null && cancelBtn.isAvailable()) { %>
										<span 
										id='<apn:name runat="server"/>_<%= status.getCount()%>' 
										role='button'
										class='<%=cancelBtn.getCSSClass()%>' 
										style='<%=cancelBtn.getCSSStyle()%>'
										data-eventtarget='[<%=eventTargets%>]' 
										data-repeat-index-name='<%=Context.Items["hiddenName"]%>' 
										data-instance-pos='<%= status.getCount()%>' 
										aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
										title='<%=GetTooltip(cancelBtn)%>'>
											<%=cancelBtn.getLabel()%>
										</span>
									<% } %>
								</apn:control>
								<apn:control runat="server" type="insert">
									<% string eventTargets = ""; %>
									<% SessionField saveBtn = GetProxyButton(Context.Items["repeatCode"]+"_save", status.getCount()-1, ref eventTargets); %>
									<% if(saveBtn != null && saveBtn.isAvailable()) { %>
										<span 
										id='<apn:name runat="server"/>_<%= status.getCount()%>' 
										name='<%=saveBtn.getHtmlName()%>' 
										role='button'
										class='<%=saveBtn.getCSSClass()%>' 
										style='<%=saveBtn.getCSSStyle()%>' 
										data-eventtarget='[<%=eventTargets%>]' 
										data-repeat-index-name='<%=Context.Items["hiddenName"]%>' 
										data-instance-pos='<%=status.getCount()%>' 
										aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
										title='<%=GetTooltip(saveBtn)%>'>
											<%=saveBtn.getLabel()%>
										</span>
									<% } %>
								</apn:control>
							</td></tr>
						</table>
					</td>
				</tr>
			</apn:forEach>
			<% Context.Items["optionIndex"] = 0; %>
			</tbody>
		</table>
	</div>
</div>
</apn:control>