<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<script runat="server">
	//We must declare the variable here, so it remains visible troughout the processing of the control.
	SG.Theme.Core.Repeat repeat = null;

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
<% 
	repeat = new SG.Theme.Core.Repeat(this, control);
	Logger.debug("Repeat:" + repeat.Name);
	repeat.HasPaging = "true".Equals(control.Current.getAttribute("hasPagination")) && !repeat.HideSearch;
	
	Context.Items["hiddenName"] = "";
	if (!IsAvailable(control)) {
		Execute("/controls/hidden.aspx");
	} else {
%>
<div id='div_<apn:name runat="server"/>' class='<%=Class("group-container")%><% if (repeat.NeverRefresh) { %> never-refresh <% } %> <% if (repeat.Borderless) { %> panel-borderless <% } %> repeat <apn:ifnotcontrolvalid runat="server"> has-error</apn:ifnotcontrolvalid>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'<% } %><% if(!control.Current.getAttribute("eventsource").Equals("")) { %> aria-live="polite"<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name="<apn:name runat="server"/>" type="hidden" value="" />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<% if (!repeat.HideHeading) { %>
	<div class='<%=Class("group-header")%>'>
		<% if (repeat.Collapsible) { %>
			<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='<%=Class("left")%>' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (repeat.IsOpen) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
		<% } %>
		<% if (control.Current.getLabel() != "") { %>
			<h5 class='<%=Class("group-title")%>' style='margin: 0px; <% if(LayoutEngine != "BS4") {Response.Output.Write("padding-top: 0.5rem;");}%>'><% Execute("/controls/custom/control-label.aspx"); %></h5>
		<% } %>
		<% if (!repeat.HideAddButton && !IsPdf && !IsSummary) { %>
			<apn:control type="insert" id="button" runat="server">
				<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
				<% SessionField addBtn = GetProxyButton(repeat.Field.getName() + "_add", ref eventTargets); %>
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
				if (headingControl.IsHeadingControl()) {
					ProxyRender = true;
					Execute("/controls/button.aspx");
					ProxyRender = false;
				} 
				%>
				</apn:WhenControl>
				<apn:Otherwise runat="server">
				<% 
				if(headingControl.IsHeadingControl()) {
					ProxyRender = true;
					Execute("/controls/control.aspx");
					ProxyRender = false;
				}
				%>
				</apn:Otherwise>
			</apn:ChooseControl>
		</apn:forEach></apn:forEach></apn:forEach>
		</apn:control>
	</div>
	<% } %>
	<% if (repeat.Collapsible) { %>
		<div id='div_<apn:name runat="server"/>_body' class='<%=Class("group-collapse")%> <% if (repeat.IsOpen) { %>in<% }%>'>
	<% } %>
	<div class='<%=Class("group-body")%>'>
		<apn:control runat="server" type="default-instance" id="filters">
			<apn:forEach runat="server" id="thFilterRow">
				<apn:forEach runat="server" id="thFilterCol">
					<apn:forEach runat="server" id="thFilterField">
						<%
						if(thFilterField.Current.getCSSClass().Contains("filters")) {
							ProxyRender = true;
							Execute("/controls/control.aspx");
							ProxyRender = false;
						}
						%>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>	
		</apn:control>
		<script>var dtOptions_div_<%=repeat.Id.Replace("[","_").Replace("]","")%><% if (!repeat.IsWETTable) { %> = <%=repeat.GetDatatablesInitOptions()%>;<% } else { %> = '';<% } %></script>
		<table class='<% = GetCleanCSSClass(control.Current) %>' style='<apn:cssStyle runat="server" />; width:100%;' data-page-length='<%=repeat.Limit%>' <apn:metadata runat="server" match="data-*" /> <% if (repeat.IsWETTable) { %> data-wb-tables='<%=repeat.GetDatatablesInitOptions()%>'<% } %>>
			<apn:control runat="server" type="default-instance" id="headerGroup">
			<thead>
				<tr>
				<% if (repeat.IsSelectableColumn()) { %>
					<th data-priority='1'>
						<% if(repeat.CSSClass.Contains("select-all") && repeat.SelectionType.Equals("checkbox")) { %>
							<input name='select_all' id='<%=repeat.Id%>-select-all' onclick='event.stopPropagation()' value="1" type='checkbox' class='<%=repeat.SelectAllCSSClass%>'  style='<%=repeat.SelectAllCSSStyle%>' />
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
											<% if(!thRowField.HideColumnLabel() && thRowField.IsVisible() && IsAvailable(thRowField) && !thRowField.HideFromListView() && !thField.IsHeadingControl() && !thField.IsProxy()) { %>
												<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thRowField.Current.getCode()%>' class='<%=GetCleanCSSClass(thRowField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thRowField.Current)%></th>
											<% } else if (!thRowField.IsHeadingControl() && !thRowField.IsProxy()){ %>
												<td <apn:metadata runat="server" match="data-priority"/> data-code='<%=thRowField.Current.getCode()%>' data-sortable="false"></td>
											<% } %>
										</apn:WhenControl>
										<apn:WhenControl type="TRIGGER" runat="server"><% if(IsAvailable(thRowField) && !thRowField.HideFromListView() && !thRowField.IsHeadingControl() && !thRowField.IsProxy()) { %><td data-code='<%=thRowField.Current.getCode()%>'><% if(!thRowField.HideColumnLabel()) GetLabel(thRowField.Current); %></td><% } %></apn:WhenControl>
										<apn:Otherwise runat="server">
											<% if(thRowField.IsVisible() && IsAvailable(thRowField) && !thRowField.HideFromListView() && !thRowField.IsHeadingControl() && !thRowField.IsProxy()) { %>
												<% if(!thRowField.HideColumnLabel()) { %>
													<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thRowField.Current.getCode()%>' class='<%=GetCleanCSSClass(thRowField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thRowField.Current)%></th>
												<% } else if (!thRowField.IsHeadingControl() && !thRowField.IsProxy()){ %>
													<td data-code='<%=thRowField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
												<% } %>
											<% } else if (!thRowField.IsHeadingControl() && !thRowField.IsProxy()){ %>
												<td class="hide" data-code='<%=thRowField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
											<% } %>
										</apn:Otherwise>
									</apn:forEach>
								</apn:forEach>
							</apn:WhenControl>
							<apn:WhenControl type="GROUP" runat="server">
								<% if(!thField.HideColumnLabel() && thField.IsVisible() && IsAvailable(thField) && !thField.HideFromListView() && !thField.IsHeadingControl() && !thField.IsProxy()) { %>
									<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thField.Current.getCode()%>' class='<%=GetCleanCSSClass(thField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thField.Current)%></th>
								<% } else if (!thField.IsHeadingControl() && !thField.IsProxy()){ %>
									<td <apn:metadata runat="server" match="data-priority"/> data-code='<%=thField.Current.getCode()%>' data-sortable="false"></td>
								<% } %>
							</apn:WhenControl>
							<apn:WhenControl type="TRIGGER" runat="server"><% if(IsAvailable(thField) && !thField.HideFromListView() && !thField.IsHeadingControl() && !thField.IsProxy()) { %><td data-code='<%=thField.Current.getCode()%>'><%= GetLabel(thField.Current) %></td><% } %></apn:WhenControl>
							<apn:WhenControl type="HIDDEN" runat="server"><td class="hide" data-code='<%=thField.Current.getCode()%>'></td></apn:WhenControl>
							<apn:Otherwise runat="server">
								<% if(thField.IsVisible() && IsAvailable(thField) && !thField.HideFromListView() && !thField.IsHeadingControl() && !thField.IsProxy()) { %>
									<% if(!thField.HideColumnLabel()) { %>
										<th <apn:metadata runat="server" match="data-priority"/> data-code='<%=thField.Current.getCode()%>' class='<%=GetCleanCSSClass(thField.Current).Replace("btn-toolbar","")%>' style='<apn:cssStyle runat="server" />'><%=GetLabel(thField.Current)%></th>
									<% } else if (!thField.IsHeadingControl() && !thField.IsProxy()){ %>
										<td data-code='<%=thField.Current.getCode()%>' data-priority='1' data-sortable="false"></td>
									<% } %>
								<% } else if (!thField.IsHeadingControl() && !thField.IsProxy()){ %>
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
			<% if(repeat.IsClienSide()) { %>
			<tbody>
				<apn:forEach runat="server" id="trGroup">
				<% Context.Items["repeatIndex"] = trGroup.Index; %>
				<% if (!control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("table-render") || control.Current.getCSSClass().Contains("table-view")) { %><tr><% } %>
				<% if (repeat.IsSelectableRow()) { %>
				<td>
					<apn:control runat="server" type="select_instance" id="sel">
						<%
							int rowId = trGroup.Index;
							string check = "true".Equals(sel.Current.getValue()) ? "checked" : "";
							Response.Output.Write(Repeat.RenderSelectionInput((ISmartletRepeat)repeat.Field, rowId, check));
						%>
					</apn:control>
				</td>
				<% } %>
					<apn:forEach runat="server" id="trRow">
						<apn:forEach runat="server" id="trCol">
							<apn:forEach runat="server" id="trField"> <%-- might be a row or a fied --%>
								<apn:ChooseControl runat="server">
									<apn:WhenControl type="ROW" runat="server">
										<%-- this needs to be refactored to be more generic --%>
										<apn:forEach runat="server" id="trRowCol">
											<apn:forEach runat="server" id="trRowField">
												<apn:ChooseControl runat="server">
													<apn:WhenControl type="GROUP" runat="server"><% if(IsAvailable(trField) && !trField.HideFromListView() && !trField.IsHeadingControl() && !trField.IsProxy()) { %><td style='<apn:cssStyle runat="server" />'><% Execute("/controls/control.aspx"); %></td><% } %></apn:WhenControl>
													<apn:WhenControl type="TRIGGER" runat="server"><% 
													System.Diagnostics.Debugger.Break();
													if(IsAvailable(trRowField) && !trRowField.HideFromListView() && !trRowField.IsHeadingControl() && !trRowField.IsProxy()) { %><td><% Execute("/controls/button.aspx"); %></td><% } %></apn:WhenControl>
													<apn:WhenControl type="HIDDEN" runat="server"><td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server"/><% } %></td></apn:WhenControl>
													<apn:Otherwise runat="server">
														<% if(IsAvailable(trRowField) && !trRowField.HideFromListView() && !trRowField.IsHeadingControl() && !trRowField.IsProxy()) { %>
															<% if(trRowField.Current.getCSSClass().Contains("datatable-editable")) { %>
																<td style='<apn:cssStyle runat="server" />'><% Execute("/controls/control.aspx"); %></td>
															<% } else if(!thRowField.IsHeadingControl() && !trRowField.IsProxy()) { %>
																<td id='<apn:name runat="server"/>' style='<apn:cssStyle runat="server" />'>
																<apn:ifcontrolattribute runat="server" attr="prefix"><apn:controlattribute runat="server" attr="prefix"/></apn:ifcontrolattribute>
																<apn:value runat="server"/>
																<apn:ifcontrolattribute runat="server" attr="suffix"><apn:controlattribute runat="server" attr="suffix"/></apn:ifcontrolattribute>
																</td>
															<% } else { %>
																<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
															<% } %>
														<% } else if (!trRowField.IsHeadingControl() && !trRowField.IsProxy()){ %>
															<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trRowField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
														<% } %>
													</apn:Otherwise>
												</apn:ChooseControl>
											</apn:forEach>
										</apn:forEach>
									</apn:WhenControl>
									<apn:WhenControl type="GROUP" runat="server"><% if(IsAvailable(trField) && !trField.HideFromListView() && !trField.IsHeadingControl() && !trField.IsProxy()) { %><td style='<apn:cssStyle runat="server" />'><% Execute("/controls/control.aspx"); %></td><% } %></apn:WhenControl>
									<apn:WhenControl type="TRIGGER" runat="server"><% 
									//System.Diagnostics.Debugger.Break();
									if(IsAvailable(trField) && !trField.HideFromListView() && !trField.IsHeadingControl() && !trField.IsProxy()) { %><td><% Execute("/controls/button.aspx"); %></td><% } %></apn:WhenControl>
									<apn:WhenControl type="HIDDEN" runat="server"><td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trField.Current, "unsafe").Equals("true")) { %><apn:value runat="server"/><% } %></td></apn:WhenControl>
									<apn:Otherwise runat="server">
										<% if(IsAvailable(trField) && !trField.HideFromListView() && !trField.IsHeadingControl() && !trField.IsProxy()) { %>
											<% if(trField.Current.getCSSClass().Contains("datatable-editable")) { %>
												<td style='<apn:cssStyle runat="server" />'><% Execute("/controls/control.aspx"); %></td>
											<% } else if(!trField.IsHeadingControl() && !trField.IsProxy()) { %>
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
										<% } else if (!trField.IsHeadingControl() && !trField.IsProxy()){ %>
											<td id='<apn:name runat="server"/>' class="hide"><% if(GetMetaDataValue(trField.Current, "unsafe").Equals("true")) { %><apn:value runat="server" /><% } %></td>
										<% } %>
									</apn:Otherwise>
								</apn:ChooseControl>
							</apn:forEach>
						</apn:forEach>
					</apn:forEach>
				<% if (!repeat.CSSClass.Contains("block-render") || repeat.CSSClass.Contains("table-render") || repeat.CSSClass.Contains("table-view")) { %></tr><% } %>
				</apn:forEach>
				<% Context.Items["repeatIndex"] = 0; %>
			</tbody>
			<% } %>
		</table>
	</div>
	<% if (repeat.Collapsible) { %>
	</div>
	<% } %>
</div>
<% } %>
<% repeat = null; %>
</apn:control>