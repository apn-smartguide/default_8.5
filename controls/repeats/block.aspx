<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false" %>
<% 
	Context.Items["hiddenName"] = "";
	Context.Items["isOnlyStatic"] = true ;
	Context.Items["optionIndex"] = 0;
%>
<apn:control runat="server" id="control">
<%
	string CSSClass = control.Current.getCSSClass();
	Context.Items["repeatCode"] = control.Current.getCode();
	Context.Items["hideAddButton"] = CSSClass.Contains("hide-add-btn");
	Context.Items["showMoveUpDownButton"] = CSSClass.Contains("show-moveupdown-btn");
	Context.Items["hideDeleteButton"] = CSSClass.Contains("hide-delete-btn");
	Context.Items["hidePagination"] = CSSClass.Contains("hide-pagination") ;
	Context.Items["hideSearch"] = CSSClass.Contains("hide-search");
	Context.Items["hideHeading"] = CSSClass.Contains("hide-heading");
	Context.Items["plain-group"] = CSSClass.Contains("plain-group");
	Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
	Context.Items["isSelectable"] = control.Current.getAttribute("isselectable").Equals("true");
	Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination")) && !((bool)Context.Items["hideSearch"]);
	Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");
	Context.Items["panel-borderless"] =  CSSClass.Contains("panel-borderless");
	string collapseCSS, containerCSS, headerCSS;

	if (BootstrapVersion == "4") {
		containerCSS = "card";
		collapseCSS = "collapse";
		headerCSS = "card-header";
	} else {
		containerCSS = "panel panel-default";
		collapseCSS = "panel-collapse collapse";
		headerCSS = "panel-heading";
	}
%>
	<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> class='repeat mt-2 mb-2 <%=control.Current.getCSSClass().Replace("plain-group","") %>' style='<%=control.Current.getCSSStyle()%>' <!-- #include file="../aria-live.inc" -->>
		<div class='<% if (!(bool)Context.Items["hidePagination"]) { %>bootpag<% } %>'>
			<div class='<%= containerCSS%> responsive <%= ((bool)Context.Items["hasPagination"] ? "hasPagination" : "") %>' <%= ((bool)Context.Items["hasPagination"] ? "data-total-pages='" + control.Current.getAttribute("totalPages") +"'": "")  %>>
				<% if (!(bool)Context.Items["hideHeading"]) { %>
				<div class="<%= headerCSS%>">
				<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
					<a data-toggle='collapse' href='#div_<apn:name runat="server"/>_body' class='pull-left' style='margin-right:10px;' title='<apn:localize runat="server" key="theme.text.accordion-btn"/> - <%=control.Current.getLabel()%>'><span class='<% if (control.Current.getCSSClass().Contains("open")) { %><apn:localize runat="server" key="theme.text.accordion-close"/><% } else { %><apn:localize runat="server" key="theme.text.accordion-open"/><% } %>'></span></a>
				<% } %>
				<apn:control runat="server" type="default-instance" id="defaultGroup">
					<apn:control runat="server" type="repeat-index" id="repeatIndex">
						<input name='<apn:name runat="server"/>' type='hidden' value='' />
						<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
					</apn:control>
						<% if (!(bool)Context.Items["hideAddButton"] && !IsPdf && !IsSummary) { %>
						<div class='float-right'>	
							<apn:control runat="server" type="insert" id="button">
								<% string eventTargets = control.Current.getAttribute("eventtarget"); %>
								<% SessionField addBtn = GetProxyButton(Context.Items["repeatCode"] + "_add", ref eventTargets); %>
								<% if(addBtn != null && addBtn.isAvailable()) { %>
									<span data-eventtarget='[<%=eventTargets%>]' aria-controls='<apn:name runat="server"/>' title='<%=GetTooltip(addBtn)%>' aria-label='<%=GetLabel(addBtn)%>' class='<%=GetCleanCSSClass(addBtn)%>' style='<%=GetCSSStyle(addBtn)%>' id='<apn:name runat="server"/>'><%=GetLabel(addBtn)%></span>
								<% } else { %>
									<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='div_<apn:name runat="server"/>' title='<apn:localize runat="server" key="theme.text.add"/>' aria-label='<apn:localize runat="server" key="theme.text.add"/>' class='<apn:localize runat="server" key="theme.icon.add"/> repeat_block_add_btn pull-right' id='<apn:name runat="server"/>'></span>
								<% } %>
							</apn:control>
						</div>
						<% } %>
						<% if (!control.Current.getLabel().Equals("")) { %><h5 class="mb-0"><% ExecutePath("/controls/custom/control-label.aspx"); %></h5><% } %>
				</apn:control>
				<% if ((bool)Context.Items["hasPagination"] && !IsPdf && !IsSummary) { %>
					<div class='container form-inline' style='padding:10px'>
						<div class='row' style="width: 100%;">
							<div class='<% if (BootstrapVersion == "4") { Response.Output.Write("col-6"); } else { Response.Output.Write("col-xs-6");}%>'>
								<b>Page <span class='paginationInfo'><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%> / <%=control.Current.getAttribute("totalPages")%></b></span> &nbsp;&nbsp;&nbsp;<apn:localize runat="server" key="theme.text.datatable.fetch" />
								<apn:control runat="server" type="repeat-page-limit" id="pageSize">
									<% if (" 10 20 50 75 ".Contains(" " + pageSize.Current.getValue() + " ")) { %>
									<select name='<apn:name runat="server" />' class='form-control input-sm pageSize'>
										<option value='10' <%= pageSize.Current.getValue().Equals("10") ? "selected" : "" %>>10</option>
										<option value='20' <%= pageSize.Current.getValue().Equals("20") ? "selected" : "" %>>20</option>
										<option value='50' <%= pageSize.Current.getValue().Equals("50") ? "selected" : "" %>>50</option>
										<option value='75' <%= pageSize.Current.getValue().Equals("75") ? "selected" : "" %>>75</option>
									</select>
									<% } else { %>
									<input type='text' class='form-control input-sm pageSize' value='<apn:value runat="server" />' name='<apn:name runat="server" />' />
									<% } %>
								</apn:control>
								<apn:localize runat="server" key="theme.text.datatable.entry" />
							</div>
							<div class='<% if (BootstrapVersion == "4") { Response.Output.Write("col-6"); } else { Response.Output.Write("col-xs-6");}%>'>
								<% if(!(bool)Context.Items["hideSearch"]) {%>
									<% if (BootstrapVersion == "4") {%> 
									<div class="input-group input-group-sm mb-3">
									<%}%>
										<div class="input-group-prepend"><span class="input-group-text"><apn:localize runat="server" key="theme.text.datatable.filter" />:</span></div>
										<apn:control type="repeat-filter" runat="server" id="filter"><input type='text' class='form-control searchBox' placeholder='<%=GetAttribute(filter.Current, "placeholder")%>' value='<apn:value runat="server" />' name='<apn:name runat="server" />' /></apn:control>
									<% if (BootstrapVersion == "4") {%> 
										<button type="submit" class='searchBtn btn btn-sm btn-secondary' title='<apn:localize runat="server" key="theme.icon.search"/>' aria-label='<apn:localize runat="server" key="theme.icon.search"/>'><span class='<apn:localize runat="server" key="theme.icon.search"/>' aria-hidden='true' /></button>
									</div>
									<%} else { %>
										<span class='searchBtn'><span class='<apn:localize runat="server" key="theme.icon.search"/>' aria-hidden='true' /></span>
									<%}%>
								<% } %>
							</div>
						</div>
					</div>
				<% } %>
				</div>
				<% } %>
				<% if ((bool)Context.Items["hasPagination"] && !control.Current.getAttribute("totalPages").Equals("") && !(bool)Context.Items["hidePagination"]) { %><apn:control type="repeat-current-page" runat="server"><input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatCurrentPage' /></apn:control><% } %>
				<% if ("true".Equals(control.Current.getAttribute("hasSort"))) { %>
				<apn:control type="repeat-sort" runat="server"><input type='hidden' value='<apn:value runat="server" />' name='<apn:name runat="server" />' class='repeatSort' /></apn:control>
				<% } %>
				<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
				<div id='div_<apn:name runat="server"/>_body' class='<%= collapseCSS%> <% if (control.Current.getCSSClass().Contains("open")) { %>in<% }%>'>
				<% } %>
				<apn:forEach id="status" runat="server">
					<% Context.Items["optionIndex"] = status.getCount(); 
						string bodyCSS, pullCSS;
						if (BootstrapVersion == "4") {
							bodyCSS = "card-body";
							pullCSS = "float-right";
						} else {
							bodyCSS = "panel-body";
							pullCSS = "pull-right";
						}
					%>
					<div class='<% if ((bool)Context.Items["plain-group"] || (bool)Context.Items["panel-borderless"]) { %> panel-borderless <% } else { Response.Output.Write(bodyCSS); } %> repeatinstance' id='div_<apn:name runat="server" />_<%= status.getCount()%>'>
						<% if (!(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"] || (bool)Context.Items["isSelectable"]) { %>
						<div class='row block-controls'>
						<div class='col-12'>
							<% if ((bool)Context.Items["isSelectable"]) { %>
							<div>
								<apn:control runat="server" type="select_instance" id="sel">
									<input type='hidden' name='<apn:name runat="server"/>' value='' />
									<input type='<%=Context.Items["selectionType"]%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' class='form-check-input <%=getSelectCSSClass()%>' style='<%=getSelectCSSStyle()%>' data-group='<%=control.Current.getName()%>' value='true' <%= "true".Equals(sel.Current.getValue()) ? "checked" : "" %> />
									<label class='form-check-label' for='<apn:name runat="server"/>' data-toggle='tooltip' data-html='true' title='<%=getSelectLabel()%>'><span class='field-name <% if(getSelectCSSClass().Contains("hide-label")) {%>sr-only<% } %>'><%=getSelectLabel()%></span></label>
								</apn:control>
								<%= status.getCount()%>.
							</div>
							<% } %>
							<% if ((!(bool)Context.Items["hideDeleteButton"] || (bool)Context.Items["showMoveUpDownButton"]) && !IsPdf && !IsSummary) { %>
							<div class='<%= pullCSS%>'>
								<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
								<apn:control runat="server" type="delete"><span title='<apn:localize runat="server" key="theme.text.deleteinstance"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='div_<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.deleteinstance"/>' class='<apn:localize runat="server" key="theme.icon.delete"/> repeat_table_del_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
								<% } %>
								<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
								<apn:control type="moveup" runat="server"><span title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='div_<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>' class='<apn:localize runat="server" key="theme.icon.up"/> repeat_block_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
								<apn:control type="movedown" runat="server"><span title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='div_<apn:name runat="server"/>_<%= status.getCount()%>' title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>' class='<apn:localize runat="server" key="theme.icon.down"/> repeat_block_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>' id='<apn:name runat="server"/>_<%= status.getCount()%>'></span></apn:control>
								<% } %>
							</div>
							<% } %>
						</div>
						</div>
						<% } %>
						<div class='row block-form'><div class='col-12'><% ExecutePath("/controls/controls.aspx"); %></div></div>
					</div>
				</apn:forEach>
				</table>
				<% Context.Items["optionIndex"] = ""; %>
				<% if (control.Current.getCSSClass().Contains("collapsible")) { %>
				</div>
				<% } %>
			</div>
			<% if (!(bool)Context.Items["hidePagination"] && (bool)Context.Items["hasPagination"] && !IsPdf && !IsSummary) { %>
				<div class='pull-left'>&nbsp;&nbsp;&nbsp;&nbsp;<b>Page <span class='paginationInfo'><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%> / <%=control.Current.getAttribute("totalPages")%></b></span></div>
			<% } %>
		</div>
		
	</div>
</apn:control>
<script runat="server" lang="c#">
// Helper method to get a MetaDataValue for this DataTable, will return empty string or value, but not null.
	public string getMetaDataValue(string meta) {
		return (control.Current.getMetaDataValue(meta).Equals("")) ? "" : control.Current.getMetaDataValue(meta);
	}

	// ** Start Styling Bloc **//
	// Get the Select All CSS Class to apply from data-attribute: Datatable -> select-all-class -> [value]
	public string getSelectAllCSSClass() { return getMetaDataValue("select-all-class"); }

	// Get the Select All CSS Style to apply from data-attribute: Datatable -> select-all-style -> [value]
	public string getSelectAllCSSStyle() { return getMetaDataValue("select-all-style"); }
	 
	// Get the Select CSS Class to apply from data-attribute: Datatable -> select-class -> [value]
	public string getSelectCSSClass() { return getMetaDataValue("select-class"); }

	// Get the Select CSS Style to apply from data-attribute: Datatable -> select-style -> [value]
	public string getSelectCSSStyle() { return getMetaDataValue("select-style"); }
	// ** End Styling Bloc **//

	// Get the Select Label to use from data-attribute: Datatable -> select-label -> [value]
	public string getSelectLabel() { return getMetaDataValue("select-label"); }

	public bool isSelectable() {
		return control.Current.getAttribute("isselectable").Equals("true");
	}
</script>