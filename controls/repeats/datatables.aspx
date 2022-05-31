<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="System.Text" %>
<apn:control runat="server" id="control">
<%
	Context.Items["hiddenName"] = "";
	CurrentRepeat = (ISmartletRepeat)FindFieldByName(control.Current.getCode());
	Logger.debug("Repeat:" + CurrentRepeat.getName());

	HasPaging = "true".Equals(control.Current.getAttribute("hasPagination")) && !HideSearch;

	if (!IsAvailable(control.Current)) {
		Execute("/controls/hidden.aspx");
	} else {
%>
<div id='div_<apn:name runat="server"/>' class='<%=Class("group-container")%><% if (NeverRefresh) { %> never-refresh <% } %> <% if (Borderless) { %> panel-borderless <% } %> repeat <apn:ifnotcontrolvalid runat="server"> has-error</apn:ifnotcontrolvalid>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'<% } %><% if(!control.Current.getAttribute("eventsource").Equals("")) { %> aria-live="polite"<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name="<apn:name runat="server"/>" type="hidden" value="" />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<% if (!HideHeading) { %>
	<div class='<%=Class("group-header")%>'>
		<% if (Collapsible) { %>
			<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='<%=Class("left")%>' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (control.Current.getCSSClass().Contains("open")) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
		<% } %>
		<% if (control.Current.getLabel() != "") { %>
			<h5 class='<%=Class("group-title")%>' style='margin: 0px; <% if(LayoutEngine != "BS4") {Response.Output.Write("padding-top: 0.5rem;");}%>'><% Execute("/controls/custom/control-label.aspx"); %></h5>
		<% } %>
		<% if (!HideAddButton && !IsPdf && !IsSummary) { %>
			<apn:control type="insert" id="button" runat="server">
				<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
				<% SessionField addBtn = GetProxyButton(CurrentRepeat.getName() + "_add", ref eventTargets); %>
				<% if(addBtn != null && addBtn.isAvailable()) { %>
					<span data-eventtarget='[<%=eventTargets%>]' aria-controls='tr_<apn:name runat="server"/>' title='<%=GetTooltip(addBtn)%>' aria-label='<%=GetLabel(addBtn)%>' class='<%=GetCleanCSSClass(addBtn)%>' style='<%=GetCSSStyle(addBtn)%>' id='<apn:name runat="server"/>'><%=GetLabel(addBtn)%></span>
				<% } else { %>
					<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>' title='<apn:localize runat="server" key="theme.text.addinstance"/>' class='repeat_table_add_btn <% if(LayoutEngine == "BS4") { Response.Output.Write("ml-auto"); } else { Response.Output.Write("pull-right"); }%>' id='<apn:name runat="server"/>'><span class='<apn:localize runat="server" key="theme.style.button.add"/>'><span class='<apn:localize runat="server" key="theme.icon.add"/>'></span></span></span>
				<% } %>
			</apn:control>
		<% } %>
		<apn:control runat="server" type="default-instance" id="header">
		<apn:forEach runat="server"><apn:forEach runat="server"><apn:forEach runat="server" id="headingControl">
			<apn:ChooseControl runat="server">
				<apn:WhenControl type="TRIGGER" runat="server">
				<% 
				if (headingControl.Current.getCSSClass().Contains("panel-heading-button")) {
					Context.Items["render-proxy"] = true;
					Execute("/controls/button.aspx");
					Context.Items["render-proxy"] = false;
				} 
				%>
				</apn:WhenControl>
				<apn:Otherwise runat="server">
				<% 
				if(headingControl.Current.getCSSClass().Contains("panel-heading-control")) { 
					Context.Items["render-proxy"] = true;
					Execute("/controls/control.aspx");
					Context.Items["render-proxy"] = false;
				}
				%>
				</apn:Otherwise>
			</apn:ChooseControl>
		</apn:forEach></apn:forEach></apn:forEach>
		</apn:control>
	</div>
	<% } %>
	<% if (Collapsible) { %>
		<div id='div_<apn:name runat="server"/>_body' class='<%=Class("group-collapse")%> <% if (RepeatCSSClass.Contains("open")) { %>in<% }%>'>
		<% } %>
	<div class='<%=Class("group-body")%>'>
		<apn:control runat="server" type="default-instance" id="filters">
			<apn:forEach runat="server" id="thFilterRow">
				<apn:forEach runat="server" id="thFilterCol">
					<apn:forEach runat="server" id="thFilterField">
						<%
						if(thFilterField.Current.getCSSClass().Contains("filters")) {
							Context.Items["render-proxy"] = true;
							Execute("/controls/control.aspx");
							Context.Items["render-proxy"] = false;
						}
						%>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>	
		</apn:control>
		<script>var dtOptions_div_<%=control.Current.getName().Replace("[","_").Replace("]","")%><% if (!IsWETTable) { %> = <%=GetDatatablesInitOptions(CurrentRepeat)%>;<% } else { %> = '';<% } %></script>
		<table class='<% = GetCleanCSSClass(control.Current) %>' style='<apn:cssStyle runat="server" />; width:100%;' data-page-length='<%=Limit%>' <apn:metadata runat="server" match="data-*" /> <% if (IsWETTable) { %> data-wb-tables='<%=GetDatatablesInitOptions(CurrentRepeat)%>'<% } %>>
			<apn:control runat="server" type="default-instance" id="headerGroup">
			<thead>
				<tr>
				<% if (IsSelectableColumn(CurrentRepeat)) { %>
					<th data-priority='1'>
						<% if(RepeatCSSClass.Contains("select-all") && CurrentRepeat.getSelectionType().Equals("checkbox")) { %>
							<input name='select_all' id='<%=CurrentRepeat.getName()%>-select-all' onclick='event.stopPropagation()' value="1" type='checkbox' class='<%=SelectAllCSSClass%>'  style='<%=SelectAllCSSStyle%>' />
						<% } %>
					</th>
				<% } %>
				<apn:forEach runat="server" id="thRow">
					<apn:forEach runat="server" id="thCol">
						<apn:forEach runat="server" id="thField"> <%-- might be a row or a fied --%>
						<apn:ChooseControl runat="server">
							<apn:WhenControl type="ROW" runat="server">
								<%-- special case where SG generated a row inside a col, and not a field --%>
								<%-- this needs to be refactored to be more generic --%>
								<apn:forEach runat="server" id="thColField">
									<apn:forEach runat="server" id="thRowField">
										<apn:WhenControl type="GROUP" runat="server">
											<% if(!thRowField.Current.getCSSClass().Contains("hide-column-label") && !thRowField.Current.getAttribute("style").Contains("visibility:hidden") && IsAvailable(thRowField.Current) && !thRowField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)) { %>
												<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thRowField.Current.getCode()%>' class='<%=GetCleanCSSClass(thRowField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thRowField.Current)%></th>
											<% } else if (!thRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thRowField.Current)){ %>
												<td <apn:metadata runat="server" match="data-priority"/> data-code='<%=thRowField.Current.getCode()%>' data-sortable="false"></td>
											<% } %>
										</apn:WhenControl>
										<apn:WhenControl type="TRIGGER" runat="server"><% if(IsAvailable(thRowField.Current) && !thRowField.Current.getCSSClass().Contains("hide-from-list-view") && !thRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thRowField.Current)) { %><td data-code='<%=thRowField.Current.getCode()%>'><% if(!thRowField.Current.getCSSClass().Contains("hide-column-label")) GetLabel(thRowField.Current); %></td><% } %></apn:WhenControl>
										<apn:Otherwise runat="server">
											<% if(!thRowField.Current.getAttribute("style").Contains("visibility:hidden") && IsAvailable(thRowField.Current) && !thRowField.Current.getCSSClass().Contains("hide-from-list-view") && !thRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thRowField.Current)) { %>
												<% if(!thRowField.Current.getCSSClass().Contains("hide-column-label")) { %>
													<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thRowField.Current.getCode()%>' class='<%=GetCleanCSSClass(thRowField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thRowField.Current)%></th>
												<% } else if (!thRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thRowField.Current)){ %>
													<td data-code='<%=thRowField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
												<% } %>
											<% } else if (!thRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thRowField.Current)){ %>
												<td class="hide" data-code='<%=thRowField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
											<% } %>
										</apn:Otherwise>
									</apn:forEach>
								</apn:forEach>
							</apn:WhenControl>
							<apn:WhenControl type="GROUP" runat="server">
								<% if(!thField.Current.getCSSClass().Contains("hide-column-label") && !thField.Current.getAttribute("style").Contains("visibility:hidden") && IsAvailable(thField.Current) && !thField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)) { %>
									<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thField.Current.getCode()%>' class='<%=GetCleanCSSClass(thField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thField.Current)%></th>
								<% } else if (!thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)){ %>
									<td <apn:metadata runat="server" match="data-priority"/> data-code='<%=thField.Current.getCode()%>' data-sortable="false"></td>
								<% } %>
							</apn:WhenControl>
							<apn:WhenControl type="TRIGGER" runat="server"><% if(IsAvailable(thField.Current) && !thField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)) { %><td data-code='<%=thField.Current.getCode()%>'><%= GetLabel(thField.Current) %></td><% } %></apn:WhenControl>
							<apn:WhenControl type="HIDDEN" runat="server"><td class="hide" data-code='<%=thField.Current.getCode()%>'></td></apn:WhenControl>
							<apn:Otherwise runat="server">
								<% if(!thField.Current.getAttribute("style").Contains("visibility:hidden") && IsAvailable(thField.Current) && !thField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)) { %>
									<% if(!thField.Current.getCSSClass().Contains("hide-column-label")) { %>
										<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thField.Current.getCode()%>' class='<%=GetCleanCSSClass(thField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thField.Current)%></th>
									<% } else if (!thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)){ %>
										<td data-code='<%=thField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
									<% } %>
								<% } else if (!thField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(thField.Current)){ %>
									<td class="hide" data-code='<%=thField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
								<% } %>
							</apn:Otherwise>
						</apn:ChooseControl>
						</apn:forEach>
					</apn:forEach>
				</apn:forEach>
				</tr>
			</thead>
			</apn:control>
			<% if(IsClienSide(CurrentRepeat)) { %>
			<tbody>
				<apn:forEach runat="server" id="trGroup">
				<% Context.Items["optionIndex"] = trGroup.getCount(); %>
				<% if (!control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("table-render") || control.Current.getCSSClass().Contains("table-view")) { %><tr><% } %>
				<apn:forEach runat="server" id="trRow">
					<% if (control.Current.getCSSClass().Contains("block-render")) { %><tr><% } %>
						<% if (IsSelectableRow(CurrentRepeat)) { %>
							<td>
								<apn:control runat="server" type="select_instance" id="sel">
									<input type="hidden" name='<apn:name runat="server"/>' value="" />
									<% ISmartletField selectControl = sg.getSmartlet().getSessionSmartlet().getCurrentSessionPage().findFieldByName(CurrentRepeat.getName() + "_select"); %>
									<% if(selectControl != null) { %>
										<% if (selectControl.isAvailable()) { %>
										<input type='<%=control.Current.getAttribute("selectiontype")%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' class='form-check-input <%=SelectCSSClass%>' style='<%=SelectCSSStyle%>' data-group='<%=control.Current.getName()%>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked" : "" %> />
										<label class='form-check-label' for='<apn:name runat="server"/>' data-toggle='tooltip' data-html='true' title='<%=SelectLabel%>'><span class='field-name <% if(SelectCSSClass.Contains("hide-label")) {%>sr-only<% } %>'><%=SelectLabel%></span></label>
										<% } %>
									<% } else { %>
									<input type='<%=control.Current.getAttribute("selectiontype")%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' class='form-check-input <%=SelectCSSClass%>' style='<%=SelectCSSStyle%>' data-group='<%=control.Current.getName()%>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked" : "" %> />
									<label class='form-check-label' for='<apn:name runat="server"/>' data-toggle='tooltip' data-html='true' title='<%=SelectLabel%>'><span class='field-name <% if(SelectCSSClass.Contains("hide-label")) {%>sr-only<% } %>'><%=SelectLabel%></span></label>
									<% } %>
								</apn:control>
							</td>
						<% } %>
						<apn:forEach runat="server" id="trCol">
							<apn:forEach runat="server" id="trField"> <%-- might be a row or a fied --%>
								<apn:ChooseControl runat="server">
									<apn:WhenControl type="ROW" runat="server">
										<%-- this needs to be refactored to be more generic --%>
										<apn:forEach runat="server" id="trRowCol">
											<apn:forEach runat="server" id="trRowField">
												<apn:ChooseControl runat="server">
													<apn:WhenControl type="GROUP" runat="server"><td style='<apn:cssStyle runat="server" />'><% if(IsAvailable(trField.Current) && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trField.Current)) { Execute("/controls/control.aspx"); } %></td></apn:WhenControl>
													<apn:WhenControl type="TRIGGER" runat="server"><% if(IsAvailable(trRowField.Current) && !trRowField.Current.getCSSClass().Contains("hide-from-list-view") && !trRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trRowField.Current)) { %><td><% Execute("/controls/button.aspx"); %></td><% } %></apn:WhenControl>
													<apn:WhenControl type="HIDDEN" runat="server"><td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server"/><% } %></td></apn:WhenControl>
													<apn:Otherwise runat="server">
														<% if(IsAvailable(trRowField.Current) && !trRowField.Current.getCSSClass().Contains("hide-from-list-view") && !trRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trRowField.Current)) { %>
															<% if(trRowField.Current.getCSSClass().Contains("datatable-editable")) { %>
																<td style='<apn:cssStyle runat="server" />'><% Execute("/controls/control.aspx"); %></td>
															<% } else if(!thRowField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trRowField.Current)) { %>
																<td id='<apn:name runat="server"/>' style='<apn:cssStyle runat="server" />'>
																<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
																<apn:value runat="server"/>
																<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
																</td>
															<% } else { %>
																<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
															<% } %>
														<% } else { %>
															<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
														<% } %>
													</apn:Otherwise>
												</apn:ChooseControl>
											</apn:forEach>
										</apn:forEach>
									</apn:WhenControl>
									<apn:WhenControl type="GROUP" runat="server"><td style='<apn:cssStyle runat="server" />'><% if(IsAvailable(trField.Current) && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trField.Current)) { Execute("/controls/control.aspx"); } %></td></apn:WhenControl>
									<apn:WhenControl type="TRIGGER" runat="server"><% if(IsAvailable(trField.Current) && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trField.Current)) { %><td><% Execute("/controls/button.aspx"); %></td><% } %></apn:WhenControl>
									<apn:WhenControl type="HIDDEN" runat="server"><td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trField.Current, "unsafe").Equals("true")) { %><apn:value runat="server"/><% } %></td></apn:WhenControl>
									<apn:Otherwise runat="server">
										<% if(IsAvailable(trField.Current) && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trField.Current)) { %>
											<% if(trField.Current.getCSSClass().Contains("datatable-editable")) { %>
												<td style='<apn:cssStyle runat="server" />'><% Execute("/controls/control.aspx"); %></td>
											<% } else if(!trField.Current.getCSSClass().Contains("panel-heading-") && !IsProxy(trField.Current)) { %>
												<%-- check type and format if applicable --%>
												<%
													string type = trField.Current.getMetaDataValue("type");
													if ("date".Equals(type)) {
														Context.Items["dataOrder"] = "data-order=\""+ GetSortableDate(trField.Current) +"\"";
													}
												%>
												<td id='<apn:name runat="server"/>' style='<apn:cssStyle runat="server" />' <%=Context.Items["dataOrder"]%>>
													<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
													<apn:value runat="server"/>
													<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
												</td>
											<% } else { %>
												<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
											<% } %>
										<% } else { %>
											<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
										<% } %>
									</apn:Otherwise>
								</apn:ChooseControl>
							</apn:forEach>
						</apn:forEach>
					<% if (RepeatCSSClass.Contains("block-render")) { %></tr><% } %>
				</apn:forEach>
				<% if (!RepeatCSSClass.Contains("block-render") || RepeatCSSClass.Contains("table-render") || RepeatCSSClass.Contains("table-view")) { %></tr><% } %>
				</apn:forEach>
				<% Context.Items["optionIndex"] = 0; %>
			</tbody>
			<% } %>
		</table>
	</div>
	<% if (Collapsible) { %>
	</div>
	<% } %>
</div>
<% } %>
<% CurrentRepeat = null; %>
</apn:control>
<script runat="server">
	// Obtain the configure RenderMode from data-attribute: Datatable -> RenderMode [Server Side|Client Side]
	// Note; for server-side paging, you must configure the service that provides the data with the following:
	// Input [filter] this is a fulltext filtering on all columns displayed that are not flag nonsearcheable
	// Input [limit] this is the maximum items per page to return.
	// Example beanshell for this input, adjust [datatable] to whatever your datatable is names ex.: "employees_list"
	// ${
	// limit = requestParameter("iDisplayLength");
	// if (limit == null || limit.equals("")) {
	//     // fallback on meta if specified
	//     limit = field([datatable]).meta("data-page-length");
	// }
	// if (limit == null || limit.equals("")) {
	//     // otherwise the field specified value if defined
	//     limit = field([datatable]).getLimit();
	// }
	// if (limit == null || limit.equals("")) {
	//     // use default of 10
	//     limit = 10;
	// }
	//return limit;}$
	//
	// Input [page] this is the page to load.
	// Example beanshell for this input, adjust [datatable] to whatever your datatable is names ex.: "employees_list"
	// ${
	// limit = requestParameter("iDisplayLength");
	// if (limit == null || limit.equals("")) {
	//     // fallback on meta if specified
	//     limit = field([datatable]).meta("data-page-length");
	// }
	// if (limit == null || limit.equals("")) {
	//     // otherwise the field specified value if defined
	//     limit = field([datatable]).getLimit();
	// }
	// if (limit == null || limit.equals("")) {
	//     // use default of 10
	//     limit = 10;
	// }

	// start = requestParameter("iDisplayStart");
	// if (start == null || start.equals("")) {
	//     // fallback on current page number
	// 	// which we must multiply by the limit since SG considers a page number instead of item index
	//     start = NUM(field([datatable]).getCurrentPage()) * NUM(limit);
	// }
	// if (start == null || start.equals("")) {
	//     // default to page 1, so "0" as the starting index
	//     start = 0;
	// }

	// page = NUM(start)/NUM(limit) + 1;
	// return page;}$
	//
	// Output [total] this is the total entries matching the filter (all if no filter).
	// Actual names of the Inputs may vary depending on you service implementation.
</script>