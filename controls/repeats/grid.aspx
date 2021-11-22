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
Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
Context.Items["useDataTables"] = (CSSClass.Contains("datatables") || CSSClass.Contains("wb-tables"));
Context.Items["isSelectable"] = "true".Equals(control.Current.getAttribute("isselectable"));
Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination"));
Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");

Context.Items["hideEditButton"] = CSSClass.Contains("hide-edit-btn");

Context.Items["btnAddTitle"] = "Add";
Context.Items["btnAddCSSClass"] = "btn btn-sm btn-primary repeat_prepare_add_btn";
Context.Items["btnAddStyle"] = "";
Context.Items["btnAddType"] = "prepare_add_instance";
ISmartletField btnAdd = (ISmartletField)CurrentPage.findFieldByName(Context.Items["repeatCode"]  + "_add");
if(btnAdd != null) {
	Context.Items["btnAddTitle"] = btnAdd.getLabel();
	Context.Items["btnAddCSSClass"] = btnAdd.getCSSClass().Replace("proxy","");
	Context.Items["btnAddStyle"] = btnAdd.getCSSStyle();
}
%>
<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget") %>]'<% } %> class='panel panel-default repeat <% if ((bool)Context.Items["isSelectable"]) { %> selectable<% } %> <%--=control.Current.getCSSClass()--%>' style='<%=control.Current.getCSSStyle()%>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite'<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name='<apn:name runat="server"/>' type='hidden' value='' />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<apn:control runat="server" type="default-instance">
	<div class='panel-heading clearfix'>
		<% if (!(bool)Context.Items["hideAddButton"] && !IsPdf) { %><div class='pull-right'><apn:control id="button" runat="server" type="prepare_add_instance"><button type='button' class='<%=Context.Items["btnAddCSSClass"]%>' style='<%=Context.Items["btnAddStyle"]%>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-level='<%=Context.Items["repeat-level"]%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <% if (!GetTooltip(button.Current).Equals("")){ %>title='<%=GetTooltip(button.Current)%>' aria-label='<%=GetTooltip(button.Current)%>'<% } %>><%=Context.Items["btnAddTitle"]%></button></apn:control></div><% } %>
		<apn:forEach runat="server"><apn:forEach runat="server"><apn:forEach runat="server" id="headingControl"><% if (headingControl.Current.getCSSClass().Contains("panel-heading-button")) { ExecutePath("/controls/button.aspx"); } %></apn:forEach></apn:forEach></apn:forEach>
		<h2 class="panel-title"><% ExecutePath("/controls/custom/control-label.aspx"); %></h2>
	</div>
	</apn:control>
	<div class='panel-body'  id='div_<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>_table'>
	<script>var dtOptions_div_<apn:name runat="server"/> = '';</script>
	<table class='<%=control.Current.getCSSClass()%> <%= ((bool)Context.Items["hasPagination"] ? "hasPagination" : "")%>' <%= ((bool)Context.Items["hasPagination"] ? " data-total-pages='" + control.Current.getAttribute("totalPages") +"'": "") %>>
		<% if ((bool)Context.Items["hasPagination"]) { %><apn:control type="repeat-current-page" runat="server" ><input type='hidden' value='<apn:value runat="server"/>' name='<apn:name runat="server" />' class='repeatCurrentPage'/></apn:control><% } %>
		<% if ("true".Equals(control.Current.getAttribute("hasSort"))) { %>
		<apn:control type="repeat-sort" runat="server" ><input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatSort'/></apn:control>
		<% } %>
		<thead>
			<tr id='tr_<apn:name runat="server"/>' role='row'>
			<% if ((bool)Context.Items["isSelectable"]) { %><th data-priority='1' class='selectBoxControl'></th><% } %>
			<apn:control runat="server" type="default-instance">
			<apn:forEach runat="server" id="row">
				<apn:forEach runat="server" id="col">
					<apn:forEach runat="server" id="field">
					<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") && !field.Current.getAttribute("visible").Equals("false") && !field.Current.getCSSClass().Contains("hide-from-list-view") && !field.Current.getCSSClass().Contains("proxy")) { %>
						<% if (field.Current.getType()==1000 && !field.Current.getCSSClass().Contains("hide-column-label")) { %>
						<th <apn:metadata runat="server" match="data-priority"/> data-orderable='<%=Convert.ToString(!field.Current.getCSSClass().Contains("hide-sort")).ToLower()%>'><% ExecutePath("/controls/controls.aspx"); %></th>
						<% } else { %>
						<th <apn:metadata runat="server" match="data-priority"/> data-orderable='<%=Convert.ToString(!field.Current.getCSSClass().Contains("hide-sort")).ToLower()%>'>
							<% if (!field.Current.getCSSClass().Contains("hide-column-label")) { %><%= GetAttribute(field.Current, "label") %><% } %>
							<% if (!field.Current.getCSSClass().Contains("hide-sort") && !(bool)Context.Items["useDataTables"]) { %>
								&nbsp;&nbsp;
								<span data-sort='<%=field.Current.getAttribute("sort")%>' data-field-id='<%=field.Current.getFieldId()%>' 
								<% if ("asc".Equals(field.Current.getAttribute("sort"))) { %>
									class='<apn:localize runat="server" key="theme.icon.sort-asc"/>'
								<% } else if ("desc".Equals(field.Current.getAttribute("sort"))) { %>
									class='<apn:localize runat="server" key="theme.icon.sort-desc"/>'
								<% } else { %>
									class='<apn:localize runat="server" key="theme.icon.sort-asc"/>' style='color:LightGrey'
								<% } %>
							<% } %>
						</th>
						<% } %>
					<% } %>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
			</apn:control>
			<% if(!CSSClass.Contains("hide-edit-btn") || !CSSClass.Contains("hide-delete-btn")) { %><td data-priority='1' data-orderable="false"></td><% } %>
			</tr>
		</thead>
		<tbody>
		<apn:forEach id="status" runat="server">
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
				<apn:forEach runat="server" id="row1">
					<apn:forEach runat="server" id="col1">
						<apn:forEach runat="server" id="field1">
							<% if(!field1.Current.getAttribute("style").Equals("visibility:hidden;") && !field1.Current.getAttribute("visible").Equals("false") && !field1.Current.getCSSClass().Contains("hide-from-list-view") && !field1.Current.getCSSClass().Contains("proxy")) { %>
								<apn:ChooseControl runat="server">
									<apn:WhenControl type="GROUP" runat="server"><td class='<%=field1.Current.getCSSClass()%>'><% ExecutePath("/controls/control.aspx"); %></td></apn:WhenControl>
									<apn:WhenControl type="TRIGGER" runat="server">
										<td>
											<% if (!IsPdf) { %>
												<% if (field1.Current.getAttribute("class").Equals("button")) {%>
													<button type='button' class='<apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if (!GetTooltip(field1.Current).Equals("")){ %>title='<%=GetTooltip(field1.Current)%>' aria-label='<%=GetTooltip(field1.Current)%>'<% } %>><apn:value runat="server"/></button>
												<% } else if (field1.Current.getAttribute("class").Equals("pdf-button")) {%>
													<a href='genpdf/do.aspx/view.pdf?cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' target='_blank' data-toggle='tooltip' data-html='true' <% if (!GetTooltip(control.Current).Equals("")){ %>title='<%=GetTooltip(control.Current)%>' aria-label='<%=GetTooltip(control.Current)%>'<% } %> class='btn <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>'><apn:value runat="server"/></a>
												<% } else if (field1.Current.getAttribute("class").Equals("view-xml-button")) { %>
													<a href='genxml/do.aspx/view.xml?cache=<%= System.Guid.NewGuid().ToString() %>&xsd=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' target='_blank' data-toggle='tooltip' data-html='true' <% if (!GetTooltip(control.Current).Equals("")){ %>title='<%=GetTooltip(control.Current)%>' aria-label='<%=GetTooltip(control.Current)%>'<% } %> class='btn <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>'><apn:value runat="server"/></a>
												<% } %>
											<% } %>
										</td>
									</apn:WhenControl>
									<% if(!field1.Current.getCSSClass().Contains("render-value")) { %>
									<apn:whencontrol runat="server" type="SELECT">
										<td data-order='<apn:value runat="server" tohtml="true"/>'>
											<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
											<p><%=field1.Current.getSelectedLabel()%></p>
											<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
										</td>
									</apn:whencontrol>
									<apn:whencontrol runat="server" type="SELECT1">
										<td data-order='<apn:value runat="server" tohtml="true"/>'>
										<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
										<p><%=field1.Current.getSelectedLabel()%></p>
										<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
									</td>
									</apn:whencontrol>
									<% } %>
									<apn:Otherwise runat="server">
									<% if(field1.Current.getType()==1014) { %>
										<%
											long staticvalue = 0;
											try {
												string dateFormat = field1.Current.getAttribute("format");
												dateFormat = dateFormat.Replace("mois","MM").Replace("jj","dd").Replace("aaaa","yyyy").Replace("aa","yy").Replace("mm","MM");
												staticvalue = DateTime.ParseExact(field1.Current.getValue(), dateFormat, System.Globalization.CultureInfo.InvariantCulture).Ticks;
											} catch(Exception e) { }
										%>
										<td data-order='<%=staticvalue%>'>
											<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
											<apn:value runat="server" tohtml="true"/>
											<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
										</td>
									<% } else { %>
										<td>
											<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
											<% if (field1.Current.getCSSClass().Contains("render-html")) { %>
											<apn:value runat="server" />
											<% } else { %>
											<apn:value runat="server" tohtml="true"/>
											<% } %>
											<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
										</td>
									<% } %>
									</apn:Otherwise>
								</apn:ChooseControl>
							<% } %>
						</apn:forEach>
					</apn:forEach>
				</apn:forEach>
				<% if (!IsPdf) { %>
					<% if (!(bool)Context.Items["hideEditButton"] ||!(bool)Context.Items["hideDeleteButton"] ||(bool)Context.Items["showMoveUpDownButton"]) { %>
					<td class='repeatbutton'>
						<% if (!(bool)Context.Items["hideEditButton"]) { %>
						<apn:control runat="server" type="prepare_edit_instance"><span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' data-level='<%=Context.Items["repeat-level"]%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.edit"/> repeat_prepare_edit_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span> </apn:control>
						<% } %>
						<% if ((bool)Context.Items["showViewButton"]) { %>
						<apn:control runat="server" type="prepare_edit_instance"><span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' data-level='<%=Context.Items["repeat-level"]%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.edit"/> repeat_prepare_edit_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span> </apn:control>
						<% } %>
						<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
						<apn:control runat="server" type="delete"><span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.delete"/> repeat_del_btn' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span> </apn:control>
						<% } %>
						<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
						<apn:control type="moveup" runat="server"><span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.up"/> repeat_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
						<apn:control type="movedown" runat="server"><span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' data-repeat-index-name='<%=Context.Items["hiddenName"]%>' data-instance-pos='<%= status.getCount()%>' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' style='cursor:pointer' class='<apn:localize runat="server" key="theme.icon.down"/> repeat_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
						<% } %>
					</td>
					<% } %>
				<% } else { %><td></td><% } %>
			</tr>
		</apn:forEach>
		</tbody>
	</table>
	</div>
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