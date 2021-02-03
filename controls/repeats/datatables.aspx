<!-- TODO: Refactor to not dependent of WET Nomenclature -->
<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="com.alphinat.sg5.widget.repeat" %>
<%@ Import Namespace="com.alphinat.sg5.widget.group" %>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else { %>
<% Context.Items["repeat-name"] = control.Current.getCode(); %>
<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'<% } %> <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	<apn:control runat="server" type="repeat-index" id="repeatIndex">
		<input name="<apn:name runat="server"/>" type="hidden" value="" />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<span>
		<% ExecutePath("/controls/custom/control-label.aspx"); %>
	</span>
	<table class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />' <apn:metadata runat="server" match="data-*" /> data-wb-tables='<%=getDatatablesInitOptions()%>' >
		<apn:control runat="server" type="default-instance" id="headerGroup">
		<thead>
			<tr>
			<% if (isSelectable()) { %><th><% if(control.Current.getCSSClass().Contains("select-all") && control.Current.getAttribute("selectiontype").Equals("checkbox")) { %><input name='select_all' id='<%=control.Current.getCode()%>-select-all' onclick='event.stopPropagation()' value="1" type='checkbox' class='<%=getSelectAllCSSClass()%>'  style='<%=getSelectAllCSSStyle()%>' /><% } %></th><% } %>
			<apn:forEach runat="server" id="thRow">
				<apn:forEach runat="server" id="thCol">
					<apn:forEach runat="server" id="thField"> <%-- might be a row or a fied --%>
					<apn:ChooseControl runat="server">
						<apn:WhenControl type="ROW" runat="server">
							<%-- special case where SG generated a row inside a col, and not a field --%>
							<%-- this needs to be refactored to be more generic --%>
							<apn:forEach runat="server" id="thColField">
								<apn:forEach runat="server" id="thRowField">
									<% if(!thRowField.Current.getAttribute("style").Contains("visibility:hidden") && !thRowField.Current.getAttribute("visible").Equals("false") && !thRowField.Current.getCSSClass().Contains("hide-from-list-view") && !thRowField.Current.getCSSClass().Contains("proxy")) { %>
										<% if(!thRowField.Current.getCSSClass().Contains("hide-column-label")) { %>
											<th><%=GetAttribute(thRowField.Current, "label")%></th>
										<% } else if (!thRowField.Current.getCSSClass().Contains("proxy")){ %>
											<td></td>
										<% } %>
									<% } else { %>
										<td></td>
									<% } %>
								</apn:forEach>
							</apn:forEach>
						</apn:WhenControl>
						<apn:WhenControl type="GROUP" runat="server">
							<% if(!thField.Current.getCSSClass().Contains("hide-column-label")) { %>
								<th><%=GetAttribute(thField.Current, "label")%></th>
							<% } else { %>
								<td></td>
							<% } %>
						</apn:WhenControl>
						<apn:WhenControl type="HIDDEN" runat="server">
							<td></td>
						</apn:WhenControl>
						<apn:Otherwise runat="server">
							<% if(!thField.Current.getAttribute("style").Contains("visibility:hidden") && !thField.Current.getAttribute("visible").Equals("false") && !thField.Current.getCSSClass().Contains("hide-from-list-view") && !thField.Current.getCSSClass().Contains("proxy")) { %>
								<% if(!thField.Current.getCSSClass().Contains("hide-column-label")) { %>
									<th class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><%=GetAttribute(thField.Current, "label")%></th>
								<% } else if (!thField.Current.getCSSClass().Contains("proxy")){ %>
									<td></td>
								<% } %>
							<% } else { %>
								<td></td>
							<% } %>
						</apn:Otherwise>
					</apn:ChooseControl>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
			</tr>
		</thead>
		</apn:control>
		<% if(!serverSide()) { %>
		<tbody>
			<apn:forEach runat="server" id="trGroup">
			<% if (!control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("table-render")) { %><tr><% } %>
			<apn:forEach runat="server" id="trRow">
				<% if (control.Current.getCSSClass().Contains("block-render")) { %><tr><% } %>
					<% if (isSelectable()) { %>
						<td>
							<apn:control runat="server" type="select_instance" id="sel">
								<input type="hidden" name='<apn:name runat="server"/>' value="" />
								<% ISmartletField selectControl = sg.getSmartlet().getSessionSmartlet().getCurrentSessionPage().findFieldByName((string)Context.Items["repeat-name"] + "_select"); %>
               					<% if(selectControl != null) { %>
									<% if (selectControl.isAvailable()) { %>
									<input type='<%=control.Current.getAttribute("selectiontype")%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' class='<%=getSelectCSSClass()%>' style='<%=getSelectCSSStyle()%>' data-group='<%=control.Current.getName()%>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked" : "" %> />
									<% } %>
								<% } else { %>
								<input type='<%=control.Current.getAttribute("selectiontype")%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' class='<%=getSelectCSSClass()%>' style='<%=getSelectCSSStyle()%>' data-group='<%=control.Current.getName()%>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked" : "" %> />
								<% } %>
							</apn:control>
						</td>
					<% } %>
					<apn:forEach runat="server" id="trCol">
						<apn:forEach runat="server" id="trField"> <%-- might be a row or a fied --%>
							<apn:ChooseControl runat="server">
								<apn:WhenControl type="ROW" runat="server">
									<%-- this needs to be refactored to be more generic --%>
									<apn:forEach runat="server" id="trFieldRow">
										<apn:forEach runat="server" id="col">
										<apn:ChooseControl runat="server">
											<apn:WhenControl type="GROUP" runat="server"><td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% ExecutePath("/controls/control.aspx"); %></td></apn:WhenControl>
											<apn:WhenControl type="TRIGGER" runat="server"><td><% ExecutePath("/controls/button.aspx"); %></td></apn:WhenControl>
											<apn:WhenControl type="HIDDEN" runat="server"><td><!-- #include file="../hidden.inc" --></td></apn:WhenControl>
											<apn:Otherwise runat="server">
												<% if(!trFieldRow.Current.getAttribute("visible").Equals("false") && !trFieldRow.Current.getCSSClass().Contains("hide-from-list-view") && !trFieldRow.Current.getCSSClass().Contains("proxy")) { %>
													<% if(trFieldRow.Current.getCSSClass().Contains("datatable-editable")) { %>
														<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% ExecutePath("/controls/control.aspx"); %></td>
													<% } else if(!trFieldRow.Current.getCSSClass().Contains("proxy")) { %>	
														<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% if (trFieldRow.Current.getCSSClass().Contains("render-html")) { %><apn:value runat="server"/><% } else { %><apn:value runat="server" tohtml="true"/><% } %></td>
													<% } else { %>
														<td></td>
													<% } %>
												<% } else { %>
													<td><!-- #include file="../hidden.inc" --></td>
												<% } %>
											</apn:Otherwise>
										</apn:ChooseControl>
										</apn:forEach>
									</apn:forEach>
								</apn:WhenControl>
								<apn:WhenControl type="GROUP" runat="server"><td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% ExecutePath("/controls/controls.aspx"); %></td></apn:WhenControl>
								<apn:WhenControl type="TRIGGER" runat="server"><td><% ExecutePath("/controls/button.aspx"); %></td></apn:WhenControl>
								<apn:WhenControl type="HIDDEN" runat="server"><td><!-- #include file="../hidden.inc" --></td></apn:WhenControl>
								<apn:Otherwise runat="server">
									<% if(!trField.Current.getAttribute("visible").Equals("false") && !trField.Current.getCSSClass().Contains("hide-from-list-view") && !trField.Current.getCSSClass().Contains("proxy"))  { %>
										<% if(trField.Current.getCSSClass().Contains("datatable-editable")) { %>
											<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />'><% ExecutePath("/controls/control.aspx"); %></td>
										<% } else if(!trField.Current.getCSSClass().Contains("proxy")) { %>
											<%-- if you need to output html formatted content, add the render-html class --%>
											<%-- check type and format if applicable --%>
											<%
												string type = trField.Current.getMetaDataValue("type");
												if ("date".Equals(type)) {
													// check format and extract number of "ticks" to use for sort
													string dateFormat = trField.Current.getMetaDataValue("format");
													long staticvalue = 0;
													try {
														staticvalue = DateTime.ParseExact(trField.Current.getValue(), dateFormat, System.Globalization.CultureInfo.InvariantCulture).Ticks/10000000;
													} catch(Exception e) {
													}                       

													Context.Items["dataOrder"] = "data-order=\""+staticvalue+"\"";
												} else {
													Context.Items["dataOrder"] = "";
												}
											%>
											<td class='<apn:cssClass runat="server" />' style='<apn:cssStyle runat="server" />' <%=Context.Items["dataOrder"]%>><% if (trField.Current.getCSSClass().Contains("render-html")) { %><apn:value runat="server"/><% } else { %><apn:value runat="server" tohtml="true"/><% } %></td>
										<% } else { %>
											<td></td>
										<% } %>
									<% } else { %>
										<td><!-- #include file="../hidden.inc" --></td>
									<% } %>
								</apn:Otherwise>
							</apn:ChooseControl>	
						</apn:forEach>
					</apn:forEach>
				<% if (control.Current.getCSSClass().Contains("block-render")) { %></tr><% } %>
			</apn:forEach>
			<% if (!control.Current.getCSSClass().Contains("block-render") || control.Current.getCSSClass().Contains("table-render")) { %></tr><% } %>
			</apn:forEach>
		</tbody>
		<% } %>
	</table>
</div>
<% } %>
</apn:control>
<script runat="server" lang="c#">
	// note: datatable implementation uses the WET systax.
	// https://datatables.net/manual/index
	//
	// Make sure to include the smartguide.wet-dataTables.js file in body_footer_core.aspx
	// Make sure to call it init() and bindEvents() in you custom.js implementation.
	//
	// Configuration options available via data-attributes in the designer
	// Control -> Control -> datatable : using the custom control attribute, will render this repeat using the datatables.aspx, i.e. this file
	// Datatable -> data-page-length -> [-1, 10 (default), 25, 50, 100] : configures the default page length to use on this datatable.
	// Datatable -> id -> (value) : inform the datatable of the field to use as the unique id for the entries
	// Datatable -> data-wb-tables -> settings :
	// 	static override of the initialization of the datatable options and settings, must be valid JSON, does not support variables.
	// 	by default, datatables.aspx will generate the initialization setting dynamically, but it is possible to deactivate this and use a static override, note using this mode is not recommended.
	// 	to implement, add a hidden field on the page, named as the repeat name with the suffix "-data-wb-tables"
	// Datatable -> data-aopts -> settings :
	// 	allows to add addiontionnal options supported by WET-datatables
	// 	to implement, add a hidden field on the page, named as the repeat name with the suffix "-data-aopts"
	// Configuration of selection options; checkbox (for multi) or radio (for single) is done via the designer
	// Additional options configurable bia data-attributes below.

	public ISmartletLogger logger() {return sg.Context.getLogger("datatables.aspx");}
 	
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

	public bool isSelectable() {
		return control.Current.getAttribute("isselectable").Equals("true");
	}

	public bool serverSide() { return getMetaDataValue("render-mode").Equals("true"); }

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
	private JObject getRenderMode(JObject jOptions) {
		// check render mode
		string renderMode = getMetaDataValue("render-mode");
		if (renderMode != null && renderMode.Equals("true")) {
			jOptions.Add("serverSide", true);
			// if server side, must add the ajaxSource
			jOptions.Add("ajaxSource",  ResolvePath("/controls/repeats/datatables-json.aspx") + "?appID=" + sg.Smartlet.getCode() + "&tableName=" + control.Current.getCode());
		}
		return jOptions;
	}

	// Get any additional parameters defined in data-attributes: Datatable -> Init -> [json]
	// These are injected as-is into the dynamically build data-wb-tables
	// Therefore duplicates may occurs, validate by inspecting the data-wb-tables in the browser console.
	private JObject getInitParameters(JObject jOptions) {
		// check init parameters
		string initParams = getMetaDataValue("init");
		if (!String.IsNullOrEmpty(initParams)) {
			JObject jInit = JObject.Parse(initParams);
			// loop entries and append to main options
			foreach(var pair in jInit) {
				jOptions.Add(pair.Key, pair.Value);
			}
		}
		return jOptions;
	}

	// If the "Allow selecting instance with" option is enabled, will add a Column at position 0.
	// Can support multiple selection using the type "Checkbox" of single selection using the type "Radio".
	// When in multiple selection mode, an additional Checkbox is presented on top of the column to support the select all mode.
	// Note: the Select All option only applies to the visible entries on the current page.
	// It is possible to configure the styling of the Select All and Select option via additional data-attributes. 
	// Options for these are described above.
	private JArray getSelectableColumnDef(JArray columns, Dictionary<string, int> fieldNameToId) {

		if(isSelectable()){
			JArray target = new JArray(0);
			JObject col = new JObject();
			col.Add("data","selected");
			col.Add("targets", target);

			string selectAllCSSClass = getSelectAllCSSClass();

			if(!selectAllCSSClass.Equals("")) {
				if (selectAllCSSClass.Contains("hide-sort")) {
					col.Add("orderable", false);
				}
				if (selectAllCSSClass.Contains("nonsearchable")) {
					col.Add("searchable", false);
				}
				if (selectAllCSSClass.Contains("hide-from-list-view")) {
					col.Add("visible", false);
				}
				col.Add("className", selectAllCSSClass.Replace("hide-sort","").Replace("nonsearchable","").Replace("hide-from-list-view",""));
			}

			columns.Add(col);
			fieldNameToId.Add("selected", 0);
		}

		return columns;
	}

	// Will build column definitions out of the fields that are placed in the designer surface.
	// Assigning the class "hide-sort" to the field, will convert the column to "orderable:false"
	// Assigning the class "nonsearchable" to the field will remove the column from dataTables search function.
	// Assigning the class "hide-from-list-view" will mark the column as hidden this supporting search.
	// Any additionnal CSS Classes defined will be passed to the className attribute.
	// Note: a field make as never display in the appearance tab will not be rendered.
	private JObject getColumnDefs(ISmartletGroup defaultGroup, JObject jOptions, Dictionary<string, int> fieldNameToId) {
		// add array of columns
		JArray columns = new JArray();

		// counter for columns id
		int counter = 0;
		columns = getSelectableColumnDef(columns, fieldNameToId);
		if(columns.Count > 0) counter++;

		ISmartletField[] fields = defaultGroup.getFields(); 

		for(int i=0;i<fields.Length;i++) {
			
			JObject col = new JObject();
			JArray target = new JArray(counter);

			string cssClass = fields[i].getCSSClass();
			string cssStyle = fields[i].getCSSStyle();
			col.Add("targets", target);
			col.Add("data",fields[i].getName());
			if (cssClass.Contains("hide-sort")) {
				col.Add("orderable", false);
			}
			if (cssClass.Contains("nonsearchable")) {
				col.Add("searchable", false);
			}

			//https://datatables.net/reference/option/columns.type
			if(fields[i].getMetaData("type") != null) {
				col.Add("type", fields[i].getMetaData("type"));
			}

			//Cannot add a non available field to the collection, it will not exist in the header's collection of fields.
			if(fields[i].isAvailable() && !cssClass.Contains("proxy")) {
				if (fields[i].getTypeConst() == 80000 || cssStyle.Contains("visibility:hidden;") || cssStyle.Contains("display:none;") || cssClass.Contains("hide-from-list-view")) {
					col.Add("visible", false);
				} else {
					col.Add("autoWidth", true);
				}

				string colClass = "";
				if(cssClass.Contains("hidden-xs")) {
					colClass = "hidden-xs ";
				}
				if(cssClass.Contains("hidden-sm")) {
					colClass += "hidden-sm ";
				} 
				if(cssClass.Contains("hidden-md")) {
					colClass += "hidden-md ";
				}
				if(cssClass.Contains("hidden-lg")) {
					colClass += "hidden-lg";
				}
				if(!colClass.Equals("")) {
					col.Add("className", colClass);
				}

				columns.Add(col);

				fieldNameToId.Add(fields[i].getName(), counter);

				counter++;
			}
		}
		
		jOptions.Add("columnDefs", columns);

		return jOptions;
	}

	// Sort options via the data-attribute: Datatable -> sorts -> [value]
	// e.g. "order": ["name", "asc"], or "order": [["name", "asc"], ["product_url", "asc"]]
	// It is possible to set multiple sort by default.
	// Special consideration, setting a sort on the "select" column will force the display of the sorting widgets.
	// Use the field name as identifier with a desired direction [asc|desc]
	private JObject getSorts(ISmartletGroup defaultGroup, JObject jOptions, Dictionary<string, int> fieldNameToId) {
		logger().debug("Preparing sort options");
		string sortMeta = getMetaDataValue("sorts");
		if (!String.IsNullOrEmpty(sortMeta)) {
			logger().debug("sortMeta: " + sortMeta);
			JObject jSortMeta = JObject.Parse(sortMeta);
			// parse and replace field names by their internal id
			JArray sortCols = (JArray)jSortMeta["order"];
			JArray finalSortCols = new JArray();
			foreach(Object sortCol in sortCols) {
				if (sortCol is JArray) {
					// means double structure with several columns specified
					JArray col = (JArray)sortCol;
					string key = ((JValue)col[0]).Value.ToString();
					if (fieldNameToId.ContainsKey(key))
						col[0] = fieldNameToId[key];
				}
				if (sortCol is JValue) {
					string key = ((JValue)sortCol).Value.ToString();
					if (fieldNameToId.ContainsKey(key))
						sortCols[0] = fieldNameToId[key];
					break;
				}
			}
			jOptions.Add("order", sortCols);
		} else {
			// fall back on repeat sort field properties, if defined
			string sort = control.Current.getAttribute("sort");
			logger().debug("sort attribute: " + sort);
			if (!String.IsNullOrEmpty(sort)) {
				// split on "," and iterate
				string[] sortFields = sort.Split(',');
				bool bMulti = false;
				if (sortFields.Length > 1)
					bMulti = true;
					
				JArray sortCols = new JArray();

				foreach(string sortField in sortFields) {
					string dir = "asc";
					if (sortField.Trim().StartsWith("-")) {
						dir = "desc";
					}
					string sortFieldId = sortField.Trim().Substring(1);
					string name = defaultGroup.findFieldById(sortFieldId).getName();
					
					if (bMulti) {
						JArray col = new JArray();
						if (fieldNameToId.ContainsKey(name)) {
							col.Add(fieldNameToId[name]);
							col.Add(dir);

							sortCols.Add(col);
						}
					} else {
						if (fieldNameToId.ContainsKey(name)) {
							sortCols.Add(fieldNameToId[name]);
							sortCols.Add(dir);
						}
					}
				}
				
				jOptions.Add("order", sortCols);
			}
		}
		return jOptions;
	}

	// The recommended approach to configuration is to let this script generate the Init options via the designers configurations.
	// Alternatively, it is possible to provide a static data-wb-tables json configuration via data-attribute: Datatable -> data-wb-tables -> settings
	// For this you'll need to place a field (hidden), on the designer prefixed with the name of the [dataTableName]-data-wb-tables 
	// This field must contain valid JSON content.
	// If such a settings is provided, none of the other configuration options will be enabled.
	public string getDatatablesInitOptions() {

		// check if data-wb-tables meta exists
		string datatablesInitOptions = getMetaDataValue("data-wb-tables");

		if (datatablesInitOptions == null || datatablesInitOptions.Length == 0) {
			JObject jOptions = new JObject();
			Dictionary<string, int> fieldNameToId = new Dictionary<string, int>();
			ISmartletGroup defaultGroup = ((ISmartletRepeat)sg.Smartlet.findFieldByName(control.Current.getCode())).getDefaultGroup();

			jOptions.Add("responsive", true);
			jOptions.Add("scrollX", true);
			jOptions.Add("deferRender", true);
			jOptions = getRenderMode(jOptions);
			jOptions = getInitParameters(jOptions);
			jOptions = getColumnDefs(defaultGroup, jOptions, fieldNameToId);
			jOptions = getSorts(defaultGroup, jOptions, fieldNameToId);

			datatablesInitOptions = jOptions.ToString();
		}

		return datatablesInitOptions;
	}

</script>