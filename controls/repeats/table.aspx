<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session.field" %>
<apn:control runat="server" id="control">
<%
	Context.Items["hiddenName"] = "";
	Context.Items["repeatCode"] = control.Current.getCode();
	string CSSClass = control.Current.getCSSClass();
	Context.Items["hideAddButton"] = CSSClass.Contains("hide-add-btn");
	Context.Items["hideEditButton"] = CSSClass.Contains("hidee-dit-btn");
	Context.Items["hideDeleteButton"] = CSSClass.Contains("hide-delete-btn");
	Context.Items["hideRowAddButton"] = CSSClass.Contains("hide-row-add-btn");
	Context.Items["showMoveUpDownButton"] = CSSClass.Contains("show-moveupdown-btn");
	Context.Items["hidePagination"] = CSSClass.Contains("hide-pagination");
	Context.Items["hideSearch"] = CSSClass.Contains("hide-search");
	Context.Items["hideHeading"] = CSSClass.Contains("hide-heading");
	Context.Items["useDataTables"] = (CSSClass.Contains("datatables") || CSSClass.Contains("wb-tables"));
	Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
	Context.Items["isSelectable"] = "true".Equals(control.Current.getAttribute("isselectable"));
	Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination"));
	Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");
	Context.Items["panel-borderless"] =  CSSClass.Contains("panel-borderless");
%>
	<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> class='card <% if ((bool)Context.Items["panel-borderless"]) { %> panel-borderless<% } %> repeat<apn:ifnotcontrolvalid runat="server" > has-error</apn:ifnotcontrolvalid> <% if ((bool)Context.Items["hidePagination"]) { %> hide-pagination<% } %> <% if ((bool)Context.Items["hideSearch"]) { %> hide-search<% } %>' style='<%=control.Current.getCSSStyle()%>' <!-- #include file="../aria-live.inc" -->>
		<% if(((string)Context.Items["hiddenName"]).Length == 0) { %>
		<apn:control runat="server" type="repeat-index" id="repeatIndex">
			<input name='<apn:name runat="server"/>' type="hidden" value="" />
			<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
		</apn:control>
		<% } %>
		<% if (!(bool)Context.Items["hideHeading"]) { %>
		<div class='card-header'>
			<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
				<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='pull-left' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (control.Current.getCSSClass().Contains("open")) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
			<% } %>
			<% if (!(bool)Context.Items["hideAddButton"] && !IsPdf && !IsSummary) { %>
				<apn:control type="insert" id="button" runat="server">
					<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
					<% SessionField addBtn = GetProxyButton(Context.Items["repeatCode"] + "_add", ref eventTargets); %>
					<% if(addBtn != null && addBtn.isAvailable()) { %>
						<span data-eventtarget='[<%=eventTargets%>]' aria-controls='tr_<apn:name runat="server"/>' title='<%=GetTooltip(addBtn)%>' aria-label='<%=GetLabel(addBtn)%>' class='<%=GetCleanCSSClass(addBtn)%>' style='<%=GetCSSStyle(addBtn)%>' id='<apn:name runat="server"/>'><%=GetLabel(addBtn)%></span>
					<% } else { %>
						<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>' title='<apn:localize runat="server" key="theme.text.addinstance"/>' class='repeat_table_add_btn float-right' id='<apn:name runat="server"/>'><span class='<apn:localize runat="server" key="theme.icon.add"/>'></span></span>
					<% } %>
				</apn:control>
			<% } %>
			<% if (control.Current.getLabel() != "") { %>
				<h5 class="mb-0 panel-title"><% ExecutePath("/controls/custom/control-label.aspx"); %></h5>
			<% } %>
		</div>
		<% } %>
		<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
			<div id='div_<apn:name runat="server"/>_body' class='collapse <% if (control.Current.getCSSClass().Contains("open")) { %>in<% }%>'>
		<% } %>
		<div class='card-body <% if (!(bool)Context.Items["hidePagination"] && !(bool)Context.Items["useDataTables"]) { %>bootpag<% } %>'>
			<script>var dtOptions_div_<%=control.Current.getName().Replace("[","_").Replace("]","")%> = '';</script>
			<% int totalPages = Convert.ToInt32(control.Current.getAttribute("totalPages")); %>
			<% if (totalPages == 0) totalPages = totalPages + 1; %>
			<% Context.Items["totalPages"] = totalPages; %>
			<% if (!IsPdf && !(bool)Context.Items["useDataTables"]) { %>
			<div class='form-inline' style='padding-bottom:5px'>
				<div class='row' style="width: 100%;">
					<% if(!(bool)Context.Items["hideSearch"]) { %>
						<div class="col-12 col-lg-5">
							<div class="input-group input-group-sm mb-3">
								<div class="input-group-prepend"><span class="input-group-text"><apn:localize runat="server" key="theme.text.datatable.filter" />:</span></div>
								<input id='datatable-search' type='text' class='form-control' value='<apn:value runat="server" />' name='<apn:name runat="server" />' placeholder='<%=GetAttribute(control.Current, "placeholder")%>'>
								<button type="submit" class='sg searchBtn btn btn-sm btn-default' title='<apn:localize runat="server" key="theme.text.search"/>' aria-label='<apn:localize runat="server" key="theme.text.search"/>'><span class='<apn:localize runat="server" key="theme.icon.search"/>'></span></button>
							</div>
						</div>
					<% } %>
					<% if(!(bool)Context.Items["hidePagination"]) { %>
						<div class='col-12 col-lg-7 mb-3 mb-lg-0 text-lg-right'>
							<b>Page <span class='paginationInfo'><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1 %> / <%= Context.Items["totalPages"] %></b></span> &nbsp;&nbsp;&nbsp;
							<apn:localize runat="server" key="theme.text.datatable.fetch" />
							<apn:control runat="server" type="repeat-page-limit" id="pageSize">
								<%if (" 10 20 50 75 ".Contains(" " + pageSize.Current.getValue() + " ")) {%>
								<select name='<apn:name runat="server" />' class='form-control w-auto form-control-sm pageSize'>
									<option value='10' <%= pageSize.Current.getValue().Equals("10") ? "selected='selected'" : "" %>>10</option>
									<option value='20' <%= pageSize.Current.getValue().Equals("20") ? "selected='selected'" : "" %>>20</option>
									<option value='50' <%= pageSize.Current.getValue().Equals("50") ? "selected='selected'" : "" %>>50</option>
									<option value='75' <%= pageSize.Current.getValue().Equals("75") ? "selected='selected'" : "" %>>75</option>
								</select>
								<% } else { %>
								<input type='text' class='form-control form-control-sm pageSize' aria-labelledby='<apn:name runat="server"/>_entries-input' value='<apn:value runat="server" />'' name=' <apn:name runat="server" />'/>
								<% } %>
								<span id='<apn:name runat="server"/>_entries-input'><apn:localize runat="server" key="theme.text.datatable.entry" /></span>
							</apn:control>
						</div>
						<% } %>
				</div>
			</div>
			<% } %>
			<table class='<%=control.Current.getCSSClass()%> <%= ((bool)Context.Items["hasPagination"] ? "hasPagination" : "")%>' <%= ((bool)Context.Items["hasPagination"] ? "data-total-pages='" + control.Current.getAttribute("totalPages") + "'" : "")  %>>
				<% if ((bool)Context.Items["hasPagination"]) { %><apn:control type="repeat-current-page" runat="server"><input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatCurrentPage' /></apn:control><% } %>
				<% if ("true".Equals(control.Current.getAttribute("hasSort"))) { %><apn:control type="repeat-sort" runat="server"><input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatSort' /></apn:control><% } %>
				<apn:control runat="server" type="default-instance" id="defaultGroup">
					<thead>
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
															<% if(!gfield.Current.getAttribute("style").Equals("visibility:hidden;") && !gfield.Current.getAttribute("visible").Equals("false") && !gfield.Current.getCSSClass().Contains("hide-from-list-view") && !gfield.Current.getCSSClass().Contains("proxy")) { %>
																<th <apn:metadata runat="server" match="data-priority"/> class='w-auto <%=gcol.Current.getLayoutAttribute("all")%>' id='<%=Context.Items["labelIdPrefix"].ToString()+"col"+gcol.getCount()%>'>
																	<span class='<apn:cssclass runat="server"/>'><% ExecutePath("/controls/custom/control-label.aspx"); %></span>
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
												<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") && !field.Current.getAttribute("visible").Equals("false") && !field.Current.getCSSClass().Contains("hide-from-list-view") && !field.Current.getCSSClass().Contains("proxy")) { %>
												<th <apn:metadata runat="server" match="data-priority"/> class='w-auto <%=col.Current.getLayoutAttribute("all")%>' id='<%=Context.Items["labelIdPrefix"].ToString()+"col"+col.getCount()%>'>
													<span class='<apn:cssclass runat="server"/>'><% ExecutePath("/controls/custom/control-label.aspx"); %></span>
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
							<% if (!(bool)Context.Items["hideRowAddButton"] || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %><td data-priority="1" data-orderable="false"></td><% } %>
						</tr>
					</thead>
				</apn:control>
				<%-- if you have a custom editable checkbox/radio and are client-side paged, add a onChange Ajax action to update server view of state --%>
				<tbody>
					<apn:forEach id="status" runat="server">
						<% Context.Items["optionIndex"] = status.getCount(); %>
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
							<% ExecutePath("/controls/repeats/table-col.aspx"); %>
							<% BareRender = false; %>	
							<% if (!IsPdf) { %>
								<% if ( (!(bool)Context.Items["hideAddButton"] && !(bool)Context.Items["hideRowAddButton"]) || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %><td class='repeatbutton nowrap'><% } %>
									<% if (!(bool)Context.Items["hideAddButton"]) { %><% if (!(bool)Context.Items["hideRowAddButton"]) { %><apn:control type="insert" id="addbutton" runat="server"><span class='<apn:localize runat="server" key="theme.icon.add"/> repeat_table_insert_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.modal.add"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><% } %><% } %>
									<% if (!(bool)Context.Items["hideDeleteButton"]) { %><apn:control type="delete" id="deletebutton" runat="server"><span class='<apn:localize runat="server" key="theme.icon.delete"/> repeat_table_del_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.deleteinstance"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><% } %>
									<% if ((bool)Context.Items["showMoveUpDownButton"]) { %><apn:control type="moveup" id="moveupbutton" runat="server"><span class='<apn:localize runat="server" key="theme.icon.up"/> repeat_table_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><apn:control type="movedown" id="movedownbutton" runat="server"><span class='<apn:localize runat="server" key="theme.icon.down"/> repeat_table_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span></apn:control><% } %>
								<% if ( (!(bool)Context.Items["hideAddButton"] && !(bool)Context.Items["hideRowAddButton"]) || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %></td><% } %>
							<% } else { %><td></td><% } %>
						</tr>
						<% Context.Items.Remove("aria-labelledby"); %>
					</apn:forEach>
					<% Context.Items["optionIndex"] = ""; %>
				</tbody>
				<%
				string tableFooterGroupName = control.Current.getCode() + "_footer";
				SessionGroup tableFooterGroup = (SessionGroup)sg.getSmartlet().getSessionSmartlet().getCurrentSessionPage().findFieldByName(tableFooterGroupName);
				%>
				<% if (tableFooterGroup != null) { %>
				<tfooter>
					<tr>
						<% if ((bool)Context.Items["isSelectable"]) { %><td></td><% } %>
						<% foreach(ISmartletField footerField in tableFooterGroup.findAllFields()) { %>
							<% if(footerField.isAvailable()  && !footerField.getCSSClass().Contains("hide-from-list-view") && !footerField.getCSSClass().Contains("proxy")) { %><td id='div_d_<%=footerField.getId()%>' class='form-group <%=footerField.getCSSClass()%>' style='<%=footerField.getCSSStyle()%>' ><%=footerField.getValue()%></td><% } %>
						<% } %>
					</tr>
				</tfooter>
				<% } %>
			</table>
			<% if (!(bool)Context.Items["hidePagination"] && (bool)Context.Items["hasPagination"] && !IsPdf && !IsSummary && !(bool)Context.Items["useDataTables"]) { %>
			<div class='pull-left'>&nbsp;&nbsp;&nbsp;&nbsp;<b>Page <span class='paginationInfo'><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1 %> / <%= Context.Items["totalPages"] %></b></span></div>
			<% } %>
		</div>
		<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
		</div>
		<% } %>
	</div>
</apn:control>