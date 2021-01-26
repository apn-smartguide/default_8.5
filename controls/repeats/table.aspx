<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session.field" %>
<apn:control runat="server" id="control">
<%
	Context.Items["hiddenName"] = "";
	string CSSClass = control.Current.getCSSClass();
	Context.Items["hideAddButton"] = CSSClass.Contains("hide-add-btn");
	Context.Items["hideRowAddButton"] = control.Current.getCSSClass().Contains("hide-row-add-btn");
	Context.Items["showMoveUpDownButton"] = CSSClass.Contains("show-moveupdown-btn");
	Context.Items["hideDeleteButton"] = CSSClass.Contains("hide-delete-btn");
	Context.Items["hidePagination"] = CSSClass.Contains("hide-pagination");
	Context.Items["hideSearch"] = CSSClass.Contains("hide-search");
	Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
	Context.Items["isSelectable"] = control.Current.getAttribute("isselectable").Equals("true");
	Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination")) && !((bool)Context.Items["hideSearch"]);
	Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");
%>
	<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> class='panel panel-default repeatgroup repeat <%=control.Current.getCSSClass()%> <apn:ifnotcontrolvalid runat="server" >has-error</apn:ifnotcontrolvalid>' style='<%=control.Current.getCSSStyle()%>' <!-- #include file="../aria-live.inc" -->>
		<% if(((string)Context.Items["hiddenName"]).Length == 0) { %>
		<apn:control runat="server" type="repeat-index" id="repeatIndex">
			<input name='<apn:name runat="server"/>' type="hidden" value="" />
			<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
		</apn:control>
		<% } %>
		<div class='panel-heading'>
			<h2 class='panel-title'>
				<% ExecutePath("/controls/custom/control-label.aspx"); %>
			</h2>
		</div>
		<div class='panel-body bootpag'>
			<% if ((bool)Context.Items["hasPagination"]) { %>
			<div class='form-inline' style='padding-bottom:5px'>
				<div class='row'>
					<% if(!(bool)Context.Items["hideSearch"]) {%>
					<div class='datatable-search pull-right'>
						<div class="form-group">
							<label class="sr-only" for="datatable-search"><apn:localize runat="server" key="theme.text.datatable.filter" />:</label>
							<div class="input-group">
								<div class="input-group-addon"><apn:localize runat="server" key="theme.text.datatable.filter" />:</div>
								<input id='datatable-search' type='text' class="form-control input-sm searchBox" value='<apn:value runat="server" />' name='<apn:name runat="server" />' placeholder='<apn:controlattribute attr="placeholder" runat="server"/>'>
							</div>
						</div>
						<button type="submit" class='searchBtn btn btn-sm btn-default'><span class='<apn:localize runat="server" key="theme.icon.search"/>'></span></button>
					</div>
					<% } %>
					<div class='col-md-8 col-sm-4'>
						<b>Page
							<span class='paginationInfo'><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%>
								/
								<%=control.Current.getAttribute("totalPages")%></b></span> &nbsp;&nbsp;&nbsp;
						<apn:localize runat="server" key="theme.text.datatable.fetch" />
						<apn:control runat="server" type="repeat-page-limit" id="pageSize">
							<%if (" 10 20 50 75 ".Contains(" " + pageSize.Current.getValue() + " ")) {%>
							<select name='<apn:name runat="server" />' class='form-control input-sm pageSize'>
								<option value='10' <%= pageSize.Current.getValue().Equals("10") ? "selected='selected'" : "" %>>10</option>
								<option value='20' <%= pageSize.Current.getValue().Equals("20") ? "selected='selected'" : "" %>>20</option>
								<option value='50' <%= pageSize.Current.getValue().Equals("50") ? "selected='selected'" : "" %>>50</option>
								<option value='75' <%= pageSize.Current.getValue().Equals("75") ? "selected='selected'" : "" %>>75</option>
							</select>
							<% } else { %>
							<input type='text' class='form-control input-sm pageSize' value='<apn:value runat="server" />'' name=' <apn:name runat="server" />'/>
							<% } %>
						</apn:control>
						<apn:localize runat="server" key="theme.text.datatable.entry" />
					</div>
				</div>
			</div>
			<% } %>
			<table class='responsive <%= ((bool)Context.Items["hasPagination"] ? "hasPagination" : "")%>' <%= ((bool)Context.Items["hasPagination"] ? "data-total-pages='" + control.Current.getAttribute("totalPages") + "'" : "")  %>>
				<% if ((bool)Context.Items["hasPagination"]) { %>
				<apn:control type="repeat-current-page" runat="server">
					<input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatCurrentPage' />
				</apn:control>
				<% } %>
				<% if ("true".Equals(control.Current.getAttribute("hasSort"))) { %>
				<apn:control type="repeat-sort" runat="server">
					<input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatSort' />
				</apn:control>
				<% } %>
				<apn:control runat="server" type="default-instance" id="defaultGroup">
					<thead>
						<tr id='tr_<apn:name runat="server"/>'>
							<% if ((bool)Context.Items["isSelectable"]) { %>
								<td></td> <!-- intentional use of td instead of th for suppressing WCAG requirement -->
							<% } %>
							<apn:forEach runat="server" id="row">
								<apn:forEach runat="server" id="col">
									<apn:forEach runat="server" id="field">
										<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") 
										&& !field.Current.getAttribute("visible").Equals("false") 
										&& !field.Current.getCSSClass().Contains("hide-from-list-view")
										&& !field.Current.getCSSClass().Contains("proxy")
										) { %>
										<th class='<%=col.Current.getLayoutAttribute("all")%>' id='<%=Context.Items["labelIdPrefix"].ToString()+"col"+col.getCount()%>'>
											<% ExecutePath("/controls/custom/control-label.aspx"); %>
											<% if ("true".Equals(field.Current.getAttribute("isSortable"))) { %>
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
									</apn:forEach>
								</apn:forEach>
							</apn:forEach>
							<% if (!(bool)Context.Items["hideAddButton"]) { %>
							<td data-priority='1' style='text-align:center'>
								<apn:control type="insert" id="button" runat="server">
									<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>' title='<apn:localize runat="server" key="theme.text.addinstance"/>' class='btn btn-sm btn-primary repeat_table_add_btn' id='<apn:name runat="server"/>'><%--<span class='<apn:localize runat="server" key="theme.icon.add"/>'></span>--%><apn:localize runat="server" key="theme.modal.add"/></span>
								</apn:control>
							</td>
							<% } else if (!(bool)Context.Items["hideRowAddButton"] || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %>
								<td></td>
							<% } %>
						</tr>
					</thead>
				</apn:control>
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
							<apn:forEach id="field2" runat="server">
								<%Context.Items["aria-labelledby"] = Context.Items["labelIdPrefix"].ToString()+"col"+field2.getCount(); //override aria-labelledby by table header %>
								<%Context.Items["optionIndex"] = status.getCount(); %>
								<apn:choosecontrol runat="server">
									<apn:whencontrol type="RECAP" runat="server">
										<td>
											<% ExecutePath("/controls/summary/summary.aspx"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol runat="server" type="ROW">
										<apn:control runat="server" id="controlrow">
											<apn:forEach runat="server" id="col3">
												<apn:choosecontrol runat="server">
													<apn:whencontrol runat="server" type="COL">
														<% 
															Context.Items["aria-labelledby"] = Context.Items["labelIdPrefix"].ToString()+"col"+col3.getCount();
															ExecutePath("/controls/repeats/col.aspx"); 
															Context.Items.Remove("aria-labelledby"); 
														%>
													</apn:whencontrol>
												</apn:choosecontrol>
											</apn:forEach>
										</apn:control>
									</apn:whencontrol>
									<apn:whencontrol runat="server" type="COL">
										<% ExecutePath("/controls/col.aspx"); %>
									</apn:whencontrol>
									<apn:whencontrol type="GROUP" runat="server">
										<td>
											<% ExecutePath("/controls/group.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="REPEAT" runat="server">
										<td>
											<% ExecutePath("/controls/repeats/repeat.aspx"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="INPUT" runat="server">
										<% if(
											!field2.Current.getAttribute("style").Equals("visibility:hidden;") 
											&& !field2.Current.getAttribute("visible").Equals("false") 
											&& !field2.Current.getCSSClass().Contains("hide-from-list-view")
											&& !field2.Current.getCSSClass().Contains("proxy")
										) { %>
										<td>
										<% } %>
											<% ExecutePath("/controls/input.aspx?bare_control=true"); %>
										<% if(
											!field2.Current.getAttribute("style").Equals("visibility:hidden;") 
											&& !field2.Current.getAttribute("visible").Equals("false") 
											&& !field2.Current.getCSSClass().Contains("hide-from-list-view")
											&& !field2.Current.getCSSClass().Contains("proxy")
										) { %>
										</td>
										<% } %>
									</apn:whencontrol>
									<apn:whencontrol type="TEXTAREA" runat="server">
										<td>
											<% ExecutePath("/controls/textarea.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="SECRET" runat="server">
										<td>
											<% ExecutePath("/controls/secret.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="DATE" runat="server">
										<td>
											<% ExecutePath("/controls/date.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="SELECT" runat="server">
										<td>
											<% ExecutePath("/controls/select.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="SELECT1" runat="server">
										<td>
											<% ExecutePath("/controls/select1.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="STATICTEXT" runat="server">
										<td>
											<% ExecutePath("/controls/statictext.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="IMAGE" runat="server">
										<td>
											<% ExecutePath("/controls/image.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:WhenControl runat="server" type="UPLOAD">
										<td>
											<% ExecutePath("/controls/upload.aspx"); %>
										</td>
									</apn:WhenControl>
									<apn:WhenControl runat="server" type="TRIGGER">
										<td>
											<% ExecutePath("/controls/button.aspx"); %>
										</td>
									</apn:WhenControl>
									<apn:whencontrol type="SUB-SMARTLET" runat="server">
										<td>
											<% ExecutePath("/controls/subsmartlet.aspx?bare_control=true"); %>
										</td>
									</apn:whencontrol>
									<apn:whencontrol type="RESULT" runat="server">
										<td>
											<% ExecutePath("/controls/result.aspx"); %>
										</td>
									</apn:whencontrol>
								</apn:choosecontrol>
							</apn:forEach>
							<% if ( (!(bool)Context.Items["hideAddButton"] && !(bool)Context.Items["hideRowAddButton"]) || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %>
							<td class='repeatbutton nowrap'>
							<% } %>
								<% if (!(bool)Context.Items["hideAddButton"]) { %>
									<% if (!(bool)Context.Items["hideRowAddButton"]) { %>
									<apn:control type="insert" id="addbutton" runat='server'>
										<span class='<apn:localize runat="server" key="theme.icon.add"/> repeat_table_add_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>'' id='<apn:name runat="server"/>_<%= status.getCount()%>'' title='<apn:localize runat="server" key="theme.modal.add"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span>
									</apn:control>
									<% } %>
								<% } %>
								<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
								<apn:control type="delete" id="deletebutton" runat="server">
									<span class='<apn:localize runat="server" key="theme.icon.delete"/> repeat_table_del_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.deleteinstance"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span>
								</apn:control>
								<% } %>
								<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
								<apn:control type="moveup" id="moveupbutton" runat="server">
									<span class='<apn:localize runat="server" key="theme.icon.up"/> repeat_table_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span>
								</apn:control>
								<apn:control type="movedown" id="movedownbutton" runat="server">
									<span class='<apn:localize runat="server" key="theme.icon.down"/> repeat_table_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'></span>
								</apn:control>
								<% } %>
							<% if ( (!(bool)Context.Items["hideAddButton"] && !(bool)Context.Items["hideRowAddButton"]) || !(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) { %>
							</td>
							<% } %>
						</tr>
						<%Context.Items.Remove("aria-labelledby"); %>
					</apn:forEach>
					<%Context.Items["optionIndex"] = ""; %>
				</tbody>
				<%
				string tableFooterGroupName = control.Current.getCode() + "_footer";
				SessionGroup tableFooterGroup = (SessionGroup)sg.getSmartlet().getSessionSmartlet().getCurrentSessionPage().findFieldByName(tableFooterGroupName);
				%>
				<% if (tableFooterGroup != null) { %>
				<tfooter>
					<tr>
						<% if ((bool)Context.Items["isSelectable"]) { %>
						<td></td>
						<% } %>
						<% foreach(ISmartletField footerField in tableFooterGroup.findAllFields()) { %>
							<% if(footerField.isAvailable() 
							&& !footerField.getCSSClass().Contains("hide-from-list-view")
							&& !footerField.getCSSClass().Contains("proxy")
							) { %> 
							<td id='div_d_<%=footerField.getId()%>' class='form-group <%=footerField.getCSSClass()%>' style='<%=footerField.getCSSStyle()%>' >
								<%=footerField.getValue()%>
							</td>
							<% } %>
						<% } %>
					</tr>	
				</tfooter>
				<% } %>
			</table>
			<% if ((bool)Context.Items["hasPagination"]) { %>
			<div class='pull-left'>
				&nbsp;&nbsp;&nbsp;&nbsp;<b>Page <span class='paginationInfo'><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%> / <%=control.Current.getAttribute("totalPages")%></b></span>
			</div>
			<% } %>
		</div>
	</div>
</apn:control>