<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
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

string CSSClass = control.Current.getCSSClass();
Context.Items["hideAddButton"] = CSSClass.Contains("hide-add-btn");
Context.Items["showViewButton"] = CSSClass.Contains("show-view-btn");
Context.Items["showMoveUpDownButton"] = CSSClass.Contains("show-moveupdown-btn");
Context.Items["hideDeleteButton"] = CSSClass.Contains("hide-delete-btn");
Context.Items["hidePagination"] = CSSClass.Contains("hide-pagination");
Context.Items["hideSearch"] = CSSClass.Contains("hide-search");
Context.Items["hideHeading"] = CSSClass.Contains("hide-heading");
Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
Context.Items["useDataTables"] = (CSSClass.Contains("datatables") || CSSClass.Contains("wb-tables"));
Context.Items["isSelectable"] = "true".Equals(control.Current.getAttribute("isselectable"));
Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination"));
Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");
Context.Items["hideEditButton"] = CSSClass.Contains("hide-edit-btn");
Context.Items["panel-borderless"] =  CSSClass.Contains("panel-borderless");

Context.Items["btnAddTitle"] = "Add";
Context.Items["btnAddCSSClass"] = "btn btn-sm btn-primary repeat_prepare_add_btn";
Context.Items["btnAddStyle"] = "";
Context.Items["btnAddType"] = "prepare_add_instance";
//ISmartletField btnAdd = (ISmartletField)CurrentPage.findFieldByName(Context.Items["repeatCode"]  + "_add");
//if(btnAdd != null) {
//	Context.Items["btnAddTitle"] = btnAdd.getLabel();
//	Context.Items["btnAddCSSClass"] = btnAdd.getCSSClass().Replace("proxy","");
//	Context.Items["btnAddStyle"] = btnAdd.getCSSStyle();
//}
%>
<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget") %>]'<% } %> class='card <% if ((bool)Context.Items["panel-borderless"]) { %> panel-borderless<% } %> repeat <% if ((bool)Context.Items["isSelectable"]) { %> selectable<% } %> <%--=control.Current.getCSSClass()--%>' style='<%=control.Current.getCSSStyle()%>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite'<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name='<apn:name runat="server"/>' type='hidden' value='' />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<apn:control runat="server" type="default-instance">
	<% if (!(bool)Context.Items["hideHeading"]) { %>
	<div class='card-header clearfix'>
		<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
			<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='pull-left' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (control.Current.getCSSClass().Contains("open")) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
		<% } %>
		<% if (!(bool)Context.Items["hideAddButton"] && !IsPdf && !IsSummary) { %>
			<div class='float-right'>
				<apn:control id="button" runat="server" type="prepare_add_instance">
					<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
					<% SessionField addBtn = GetProxyButton(Context.Items["repeatCode"] + "_add", ref eventTargets); %>
					<% if(addBtn != null && addBtn.isAvailable()) { %>
						<span data-eventtarget='[<%=eventTargets%>]' aria-controls='<apn:name runat="server"/>' title='<%=GetTooltip(addBtn)%>' aria-label='<%=GetLabel(addBtn)%>' class='<%=GetCSSClass(addBtn)%>' style='<%=GetCSSStyle(addBtn)%>' id='<apn:name runat="server"/>'><%=GetLabel(addBtn)%></span>
					<% } else { %>
						<button type='button' class='<%=Context.Items["btnAddCSSClass"]%>' style='<%=Context.Items["btnAddStyle"]%>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-level='<%=Context.Items["repeat-level"]%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <% if (!GetTooltip(button.Current).Equals("")){ %>title='<%=GetTooltip(button.Current)%>' aria-label='<%=GetTooltip(button.Current)%>'<% } %>><%=Context.Items["btnAddTitle"]%></button>
					<% } %>
				</apn:control>
			</div>
		<% } %>
		<apn:forEach runat="server"><apn:forEach runat="server"><apn:forEach runat="server" id="headingControl"><% if (headingControl.Current.getCSSClass().Contains("panel-heading-button") || headingControl.Current.getCSSClass().Contains("panel-heading-control")) { Context.Items["render-proxy"] = true; ExecutePath("/controls/control.aspx"); Context.Items["render-proxy"] = false; } %></apn:forEach></apn:forEach></apn:forEach>
		<h5 class="mt-1 mb-1"><% ExecutePath("/controls/custom/control-label.aspx"); %></h5>
	</div>
	<% } %>
	</apn:control>
	<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
		<div id='div_<apn:name runat="server"/>_body' class='collapse <% if (control.Current.getCSSClass().Contains("open")) { %>in<% }%>'>
	<% } %>
	<div class='card-body'  id='div_<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>_table'>
	<script>var dtOptions_div_<%=control.Current.getName().Replace("[","_").Replace("]","")%> = '';</script>
	<table class='<%=control.Current.getCSSClass()%> <%= ((bool)Context.Items["hasPagination"] ? "hasPagination" : "")%>' <%= ((bool)Context.Items["hasPagination"] ? " data-total-pages='" + control.Current.getAttribute("totalPages") +"'": "") %>>
		<% if ((bool)Context.Items["hasPagination"]) { %><apn:control type="repeat-current-page" runat="server" ><input type='hidden' value='<apn:value runat="server"/>' name='<apn:name runat="server" />' class='repeatCurrentPage'/></apn:control><% } %>
		<% if ("true".Equals(control.Current.getAttribute("hasSort"))) { %>
		<apn:control type="repeat-sort" runat="server" ><input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatSort'/></apn:control>
		<% } %>
		<thead>
			<tr id='tr_<apn:name runat="server"/>' role='row'>
			<% if ((bool)Context.Items["isSelectable"]) { %><th data-priority='1' class='selectBoxControl'></th><% } %>
			<apn:control runat="server" type="default-instance">
			<apn:forEach runat="server" id="thRow">
				<apn:forEach runat="server" id="thCol">
					<apn:forEach runat="server" id="thField">
						<apn:ChooseControl runat="server">
							<apn:WhenControl type="ROW" runat="server">
								<%-- special case where SG generated a row inside a col, and not a field --%>
								<%-- this needs to be refactored to be more generic --%>
								<apn:forEach runat="server" id="thRowCol">
									<apn:forEach runat="server" id="thRowField">
										<apn:ChooseControl runat="server">
											<apn:WhenControl type="TRIGGER" runat="server"><td data-priority='1' data-sortable="false"></td></apn:WhenControl>
											<apn:WhenControl type="HIDDEN" runat="server"><td class="hide" data-priority='1' data-sortable="false"></td></apn:WhenControl>
											<apn:Otherwise runat="server">
												<% if(!thRowField.Current.getAttribute("style").Equals("visibility:hidden;") && !thRowField.Current.getAttribute("visible").Equals("false") && !thRowField.Current.getCSSClass().Contains("hide-from-list-view") && !thRowField.Current.getCSSClass().Contains("proxy")) { %>
													<% if (thRowField.Current.getType()==1000 && !thRowField.Current.getCSSClass().Contains("hide-column-label")) { %>
													<th <apn:metadata runat="server" match="data-priority"/> data-orderable='<%=Convert.ToString(!thRowField.Current.getCSSClass().Contains("hide-sort")).ToLower()%>'><% ExecutePath("/controls/controls.aspx"); %></th>
													<% } else { %>
													<th <apn:metadata runat="server" match="data-priority"/> data-orderable='<%=Convert.ToString(!thRowField.Current.getCSSClass().Contains("hide-sort")).ToLower()%>'>
														<% if (!thRowField.Current.getCSSClass().Contains("hide-column-label")) { %><%= GetAttribute(thRowField.Current, "label") %><% } %>
														<% if (!thRowField.Current.getCSSClass().Contains("hide-sort") && !(bool)Context.Items["useDataTables"]) { %>
															&nbsp;&nbsp;
															<span data-sort='<%=thRowField.Current.getAttribute("sort")%>' data-field-id='<%=thRowField.Current.getFieldId()%>' 
															<% if ("asc".Equals(thRowField.Current.getAttribute("sort"))) { %>
																class='<apn:localize runat="server" key="theme.icon.sort-asc"/>'
															<% } else if ("desc".Equals(thRowField.Current.getAttribute("sort"))) { %>
																class='<apn:localize runat="server" key="theme.icon.sort-desc"/>'
															<% } else { %>
																class='<apn:localize runat="server" key="theme.icon.sort-asc"/>' style='color:LightGrey'
															<% } %>
														<% } %>
													</th>
													<% } %>
												<% } %>
											</apn:Otherwise>
										</apn:ChooseControl>
									</apn:forEach>
								</apn:forEach>
							</apn:WhenControl>
							<apn:whencontrol type="GROUP" runat="server">
								<% if(!thField.Current.getAttribute("visible").Equals("false") && !thField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("proxy")) { %>
									<% if(!thField.Current.getCSSClass().Contains("hide-column-label")) { %>
										<th <apn:metadata runat="server" match="data-priority"/> class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><%=GetAttribute(thField.Current, "label")%></th>
									<% } else { %>
										<td <apn:metadata runat="server" match="data-priority"/> data-sortable="false"></td>
									<% } %>
								<% } %>
							</apn:whencontrol>
							<apn:WhenControl type="TRIGGER" runat="server"><td data-priority='1' data-sortable="false"></td></apn:WhenControl>
							<apn:WhenControl type="HIDDEN" runat="server"><td class="hide" data-priority='1' data-sortable="false"></td></apn:WhenControl>
							<apn:Otherwise runat="server">
								<% if(!thField.Current.getAttribute("style").Equals("visibility:hidden;") && !thField.Current.getAttribute("visible").Equals("false") && !thField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("proxy")) { %>
									<% if (thField.Current.getType()==1000 && !thField.Current.getCSSClass().Contains("hide-column-label")) { %>
									<th <apn:metadata runat="server" match="data-priority"/> data-orderable='<%=Convert.ToString(!thField.Current.getCSSClass().Contains("hide-sort")).ToLower()%>'><% ExecutePath("/controls/controls.aspx"); %></th>
									<% } else { %>
									<th <apn:metadata runat="server" match="data-priority"/> data-orderable='<%=Convert.ToString(!thField.Current.getCSSClass().Contains("hide-sort")).ToLower()%>'>
										<% if (!thField.Current.getCSSClass().Contains("hide-column-label")) { %><%= GetAttribute(thField.Current, "label") %><% } %>
										<% if (!thField.Current.getCSSClass().Contains("hide-sort") && !(bool)Context.Items["useDataTables"]) { %>
											&nbsp;&nbsp;
											<span data-sort='<%=thField.Current.getAttribute("sort")%>' data-field-id='<%=thField.Current.getFieldId()%>' 
											<% if ("asc".Equals(thField.Current.getAttribute("sort"))) { %>
												class='<apn:localize runat="server" key="theme.icon.sort-asc"/>'
											<% } else if ("desc".Equals(thField.Current.getAttribute("sort"))) { %>
												class='<apn:localize runat="server" key="theme.icon.sort-desc"/>'
											<% } else { %>
												class='<apn:localize runat="server" key="theme.icon.sort-asc"/>' style='color:LightGrey'
											<% } %>
										<% } %>
									</th>
									<% } %>
								<% } %>
							</apn:Otherwise>
						</apn:ChooseControl>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
			</apn:control>
			<% if (!IsPdf) { %>
				<td data-priority='1' data-sortable="false"></td>
			<% } %>
			</tr>
		</thead>
		<tbody>
		<apn:forEach id="status" runat="server">
			<% Context.Items["optionIndex"] = status.getCount(); %>
			<% Context.Items["isEditOrDelete"] = "true".Equals(status.Current.getAttribute("edit-instance")) || "true".Equals(status.Current.getAttribute("new-instance")); %>
			<tr role='row' id='tr_<apn:name runat="server"/>_<%= status.getCount()%>' class='<%=((bool)Context.Items["isEditOrDelete"]? "active" : "")%>'>
				<% if ((bool)Context.Items["isSelectable"]) { %>
				<td class='selectBoxControl'>
					<apn:control runat="server" type="select_instance" id="sel">
						<input type='hidden' name='<apn:name runat="server"/>' value='' />
						<input type='<%=Context.Items["selectionType"]%>' data-group='<%=control.Current.getName()%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='true' <%= "true".Equals(sel.Current.getValue()) ? "checked" : "" %> />
					</apn:control>
				</td>
				<% } %>
				<apn:forEach runat="server" id="trRow">
					<apn:forEach runat="server" id="trCol">
						<apn:forEach runat="server" id="trField">
							<apn:ChooseControl runat="server">
								<apn:WhenControl type="ROW" runat="server">
									<%-- this needs to be refactored to be more generic --%>
									<apn:forEach runat="server" id="trRowCol">
										<apn:forEach runat="server" id="trRowField">
											<apn:ChooseControl runat="server">
												<apn:WhenControl type="GROUP" runat="server"><td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% if(!trRowField.Current.getAttribute("visible").Equals("false") && !trRowField.Current.getCSSClass().Contains("hide-from-list-view") && !trRowField.Current.getCSSClass().Contains("proxy")) { ExecutePath("/controls/controls.aspx"); } %></td></apn:WhenControl>
												<apn:WhenControl type="TRIGGER" runat="server"><td><% if(!trRowField.Current.getAttribute("visible").Equals("false") && !trRowField.Current.getCSSClass().Contains("hide-from-list-view") && !trRowField.Current.getCSSClass().Contains("proxy")) { ExecutePath("/controls/button.aspx"); } %></td></apn:WhenControl>
												<apn:WhenControl type="HIDDEN" runat="server"><td class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server"/><% } %></td></apn:WhenControl>
												<apn:Otherwise runat="server">
												<% if(!trRowField.Current.getAttribute("visible").Equals("false") && !trRowField.Current.getCSSClass().Contains("hide-from-list-view") && !trRowField.Current.getCSSClass().Contains("proxy")) { %>
													<% if(trRowField.Current.getCSSClass().Contains("datatable-editable") && (!IsSummary && !IsPdf)) { %>
														<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% ExecutePath("/controls/control.aspx"); %></td>
													<% } else if(trRowField.Current.getType() == 1014 /*date*/ ) { %>
														<td data-order='<%=GetSortableDate(trField.Current)%>'><apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute><apn:value runat="server"/><apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute></td>
													<% } else if(trRowField.Current.getType() == 1006 /*select*/ || trRowField.Current.getType() == 1007 /*select1*/ ) { %>
														<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><%=trRowField.Current.getSelectedLabel()%></td>
													<% } else { %>
														<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><apn:value runat="server"/></td>
													<% } %>
												<% } %>
												</apn:Otherwise>
											</apn:ChooseControl>
										</apn:forEach>
									</apn:forEach>
								</apn:WhenControl>
								<apn:WhenControl type="GROUP" runat="server"><td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% if(!trField.Current.getAttribute("visible").Equals("false") && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("proxy")) { ExecutePath("/controls/control.aspx"); } %></td></apn:WhenControl>
								<apn:WhenControl type="TRIGGER" runat="server"><td><% if(!trField.Current.getAttribute("visible").Equals("false") && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("proxy")) { ExecutePath("/controls/button.aspx"); }  %></td></apn:WhenControl>
								<apn:WhenControl type="HIDDEN" runat="server"><td class="hide"><% if(GetMetaDataValue(trField.Current, "unsafe").Equals("true")) { %><apn:value runat="server"/><% } %></td></apn:WhenControl>
								<apn:Otherwise runat="server">
								<% if(!trField.Current.getAttribute("visible").Equals("false") && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("proxy")) { %>
									<% if(trField.Current.getCSSClass().Contains("datatable-editable") && (!IsSummary && !IsPdf)) { %>
										<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% ExecutePath("/controls/control.aspx"); %></td>
									<% } else if(trField.Current.getType() == 1014 /*date*/) { %>
										<td data-order='<%=GetSortableDate(trField.Current)%>'><apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute><apn:value runat="server"/><apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute></td>
									<% } else if(trField.Current.getType() == 1006 /*select*/ || trField.Current.getType() == 1007 /*select1*/ ) { %>
										<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><%=trField.Current.getSelectedLabel()%></td>
									<% } else { %>
										<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><apn:value runat="server"/></td>
									<% } %>
								<% } %>
								</apn:Otherwise>
							</apn:ChooseControl>
						</apn:forEach>
					</apn:forEach>
				</apn:forEach>
				<% if (!IsPdf) { %>
					<% if (!(bool)Context.Items["hideEditButton"] ||!(bool)Context.Items["hideDeleteButton"] ||(bool)Context.Items["showMoveUpDownButton"]) { %>
					<td class='repeatbutton'>
						<% if (!(bool)Context.Items["hideEditButton"]) { %>
						<apn:control runat="server" type="prepare_edit_instance"><span title='<apn:localize runat="server" key="theme.modal.edit"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' data-level='<%=Context.Items["repeat-level"]%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.edit"/> repeat_prepare_edit_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span> </apn:control>
						<% } %>
						<% if ((bool)Context.Items["showViewButton"]) { %>
						<apn:control runat="server" type="prepare_edit_instance"><span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' data-level='<%=Context.Items["repeat-level"]%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.edit"/> repeat_prepare_edit_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span> </apn:control>
						<% } %>
						<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
						<apn:control runat="server" type="delete"><span title='<apn:localize runat="server" key="theme.text.deleteinstance"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.delete"/> repeat_del_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span> </apn:control>
						<% } %>
						<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
						<apn:control type="moveup" runat="server"><span title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.up"/> repeat_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
						<apn:control type="movedown" runat="server"><span title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.down"/> repeat_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
						<% } %>
					</td>
					<% } else { %><td></td><% } %>
				<% } %>
			</tr>
		</apn:forEach>
		<% Context.Items["optionIndex"] = 0; %>
		</tbody>
	</table>
	</div>
	<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
	</div>
	<% } %>
	<!-- modal -->
	<apn:forEach runat="server" id="group1">
		<% if ("true".Equals(group1.Current.getAttribute("new-instance"))) { %>
			<% Context.Items["modal-mode"] = "add"; %>
			<% ExecutePath("/controls/repeats/crud-modal.aspx"); %>
		<% } else if ("true".Equals(group1.Current.getAttribute("edit-instance"))) { %>
			<% Context.Items["modal-mode"] = "edit"; %>
			<% ExecutePath("/controls/repeats/crud-modal.aspx"); %>
		<% } %>
		<% Context.Items["modal-mode"] = ""; %>
	</apn:forEach>
</div>
<% 
Context.Items["repeat-name-" + Context.Items["repeat-level"]] = null;
Context.Items["repeat-event-targets-edit-" + Context.Items["repeat-level"]] = null;
Context.Items["repeat-event-targets-cancel-" + Context.Items["repeat-level"]] = null;
Context.Items["repeat-event-targets-add-" + Context.Items["repeat-level"]] = null;
Context.Items["repeat-level"] = ((int)Context.Items["repeat-level"])-1;
%>
</apn:control>