<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
	string CSSClass = control.Current.getCSSClass();
	Context.Items["isSelectable"] = "true".Equals(control.Current.getAttribute("isselectable"));
	Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
	Context.Items["useDataTables"] = (CSSClass.Contains("datatables") || CSSClass.Contains("wb-tables"));
	Context.Items["hideAddButton"] = CSSClass.Contains("hide-add-btn");
	Context.Items["hideEditButton"] = CSSClass.Contains("hidee-dit-btn");
	Context.Items["hideDeleteButton"] = CSSClass.Contains("hide-delete-btn");
	Context.Items["hideRowAddButton"] = CSSClass.Contains("hide-row-add-btn");
	Context.Items["showMoveUpDownButton"] = CSSClass.Contains("show-moveupdown-btn");
	Context.Items["hidePagination"] = CSSClass.Contains("hide-pagination");
	Context.Items["hideSearch"] = CSSClass.Contains("hide-search");
	Context.Items["hideHeading"] = CSSClass.Contains("hide-heading");
	Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");
%>
	<div style='overflow-x: auto;'>
	<table width="100%">
	<thead>
		<apn:control runat="server" type="default-instance" id="headerGroup">
		<tr id='tr_<apn:name runat="server"/>'>
			<% if ((bool)Context.Items["isSelectable"]) { %><td data-priority="1"></td> <!-- intentional use of td instead of th for suppressing WCAG requirement --> <% } %>
			<apn:forEach runat="server" id="row">
				<apn:forEach runat="server" id="col">
					<apn:forEach runat="server" id="field">
						<apn:ChooseControl runat="server">
							<apn:whencontrol runat="server" type="GROUP">
								<apn:forEach runat="server" id="grow">
									<apn:forEach runat="server" id="gcol">
										<apn:forEach runat="server" id="gfield">
											<% if(!gfield.Current.getAttribute("style").Equals("visibility:hidden;") && !gfield.Current.getAttribute("visible").Equals("false") && !gfield.Current.getCSSClass().Contains("hide-from-list-view") && !gfield.IsProxy()) { %>
												<th <apn:metadata runat="server" match="data-priority"/> class='<%=gcol.Current.getLayoutAttribute("all")%>' id='<%=Context.Items["labelIdPrefix"].ToString()+"col"+gcol.getCount()%>'>
													<span class='<apn:cssclass runat="server"/>'><% Execute("/controls/custom/control-label.aspx"); %></span>
													<% if ("true".Equals(gfield.Current.getAttribute("isSortable")) && !(bool)Context.Items["useDataTables"]) { %>
													&nbsp;&nbsp;
													<span data-sort="<%=gfield.Current.getAttribute("sort")%>" data-field-id="<%=gfield.Current.getFieldId()%>"
														<%if ("asc".Equals(gfield.Current.getAttribute("sort"))) {%>
														class='<apn:localize runat="server" key="theme.icon.sort-asc"/>'
														<% } else if ("desc".Equals(gfield.Current.getAttribute("sort"))) {%>
														class='<apn:localize runat="server" key="theme.icon.sort-desc"/>'
														<% } else { %>
														class='<apn:localize runat="server" key="theme.icon.sort-asc"/>' style="color:LightGrey"
														<% } %>></span>
													<% } %>
												</th>
												<% } %>
										</apn:forEach>
									</apn:forEach>
								</apn:forEach>
							</apn:whencontrol>
							<apn:Otherwise runat="server">
								<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") && !field.Current.getAttribute("visible").Equals("false") && !field.Current.getCSSClass().Contains("hide-from-list-view") && !field.IsProxy()) { %>
								<th <apn:metadata runat="server" match="data-priority"/> class='<%=col.Current.getLayoutAttribute("all")%>' id='<%=Context.Items["labelIdPrefix"].ToString()+"col"+col.getCount()%>'>
									<span class='<apn:cssclass runat="server"/>'><% Execute("/controls/custom/control-label.aspx"); %></span>
									<% if ("true".Equals(field.Current.getAttribute("isSortable")) && !(bool)Context.Items["useDataTables"]) { %>
									&nbsp;&nbsp;
									<span data-sort="<%=field.Current.getAttribute("sort")%>" data-field-id="<%=field.Current.getFieldId()%>"
										<%if ("asc".Equals(field.Current.getAttribute("sort"))) {%>
										class='<apn:localize runat="server" key="theme.icon.sort-asc"/>'
										<% } else if ("desc".Equals(field.Current.getAttribute("sort"))) {%>
										class='<apn:localize runat="server" key="theme.icon.sort-desc"/>'
										<% } else { %>
										class='<apn:localize runat="server" key="theme.icon.sort-asc"/>' style="color:LightGrey"
										<% } %>></span>
									<% } %>
								</th>
								<% } %>
							</apn:Otherwise>
						</apn:ChooseControl>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
			<% if ((!(bool)Context.Items["hideRowAddButton"] || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) && !IsPdf && !IsSummary) { %><td data-priority="1" data-orderable="false"></td><% } %>
		</tr>
		</apn:control>
	</thead>
	<tbody>
		<apn:forEach id="status" runat="server">
			<tr id='tr_<apn:name runat="server"/>_<%= status.getCount()%>'>
				<% if ((bool)Context.Items["isSelectable"]) { %>
				<td>
					<apn:control runat="server" type="select_instance" id="sel">
						<input type='hidden' name='<apn:name runat="server"/>' value='' />
						<input type='<%=Context.Items["selectionType"]%>' data-group='<%=control.Current.getName()%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked='checked'" : "" %> />
					</apn:control>
				</td>
				<% } %>
				<% BareRender = true; %>
				<% Context.Items["optionIndex"] = status.getCount(); %>
				<% Execute("/controls/repeats/table-col.aspx"); %>
				<% BareRender = false; %>	
				<% if (!IsPdf && !IsSummary) { %>
					<% if ( (!(bool)Context.Items["hideAddButton"] && !(bool)Context.Items["hideRowAddButton"]) || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %><td class='repeatbutton nowrap'><% } %>
						<% if (!(bool)Context.Items["hideAddButton"]) { %><% if (!(bool)Context.Items["hideRowAddButton"]) { %><apn:control type="insert" id="addbutton" runat="server"><span class='<apn:localize runat="server" key="theme.style.button.add"/> <apn:localize runat="server" key="theme.icon.add"/> repeat_table_insert_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.modal.add"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><% } %><% } %>
						<% if (!(bool)Context.Items["hideDeleteButton"]) { %><apn:control type="delete" id="deletebutton" runat="server"><span class='<apn:localize runat="server" key="theme.style.button.delete"/> <apn:localize runat="server" key="theme.icon.delete"/> repeat_table_del_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.deleteinstance"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><% } %>
						<% if ((bool)Context.Items["showMoveUpDownButton"]) { %><apn:control type="moveup" id="moveupbutton" runat="server"><span class='<apn:localize runat="server" key="theme.icon.up"/> repeat_table_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><apn:control type="movedown" id="movedownbutton" runat="server"><span class='<apn:localize runat="server" key="theme.icon.down"/> repeat_table_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><% } %>
					<% if ( (!(bool)Context.Items["hideAddButton"] && !(bool)Context.Items["hideRowAddButton"]) || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %></td><% } %>
				<% } %>
			</tr>
			<% Context.Items.Remove("aria-labelledby"); %>
		</apn:forEach>
		<% Context.Items["optionIndex"] = ""; %>
	</tbody>
	</table>
</div>
</apn:control>