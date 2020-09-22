<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
Context.Items["hiddenName"] = ""; 

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

Context.Items["hideAddButton"] = control.Current.getCSSClass().Contains("hide-add-btn");
Context.Items["showMoveUpDownButton"] = control.Current.getCSSClass().Contains("show-moveupdown-btn");
Context.Items["hideDeleteButton"] = control.Current.getCSSClass().Contains("hide-delete-btn");
Context.Items["hidePagination"] = control.Current.getCSSClass().Contains("hide-pagination");
Context.Items["hideSearch"] = control.Current.getCSSClass().Contains("hide-search");
Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
Context.Items["isSelectable"] = control.Current.getAttribute("isselectable").Equals("true");
Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination")) && !((bool)Context.Items["hideSearch"]);
Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");

Context.Items["hideEditButton"] = control.Current.getCSSClass().Contains("hide-edit-btn");
%>
<div id="div_<apn:name runat='server'/>" 
		<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'<% } %>
		class="panel panel-default repeat <% if ((bool)Context.Items["isSelectable"]) {%>selectable<%}%> <%=control.Current.getCSSClass()%>" 
		style="<%=control.Current.getCSSStyle()%>" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	<apn:control runat='server' type="repeat-index" id="repeatIndex">
		<input name="<apn:name runat='server'/>" type="hidden" value="" />
		<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
	</apn:control>
	<apn:control runat='server' type="default-instance" id="defaultGroup">
	<div class="panel-heading">
		<h2 class="panel-title">
			<div class="pull-right"><% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %></div>
			<apn:label runat='server'/>
			<apn:ifcontrolattribute runat='server' attr='title'>
				<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
			</apn:ifcontrolattribute>
		</h2>
	</div>
    
	<div class="panel-body bootpag"  id="div_<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>_table">
<% if ((bool)Context.Items["hasPagination"]) { %>
	<div class="container form-inline" style="padding-bottom:5px">
	<div class="row">
		<div class="col-md-4">
			<b>Page 
				<span class="paginationInfo"><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%>
				/
				<%=control.Current.getAttribute("totalPages")%></b></span> &nbsp;&nbsp;&nbsp;
			<apn:localize runat="server" key="theme.text.datatable.fetch"/>
			<apn:control runat='server'  type="repeat-page-limit" id="pageSize">
				<%if (" 10 20 50 75 ".Contains(" " + pageSize.Current.getValue() + " ")) {%>
				<select name="<apn:name runat='server' />" class="form-control input-sm pageSize">
					<option value="10" <%= pageSize.Current.getValue().Equals("10") ? "selected=\"selected\"" : "" %>>10</option>
					<option value="20" <%= pageSize.Current.getValue().Equals("20") ? "selected=\"selected\"" : "" %>>20</option>
					<option value="50" <%= pageSize.Current.getValue().Equals("50") ? "selected=\"selected\"" : "" %>>50</option>
					<option value="75" <%= pageSize.Current.getValue().Equals("75") ? "selected=\"selected\"" : "" %>>75</option>
				</select>
				<% }  else {%>
					<input type="text" class="form-control input-sm pageSize" value="<apn:value runat='server' />" name="<apn:name runat='server' />"/>
				<% } %>
			</apn:control>
			<apn:localize runat="server" key="theme.text.datatable.entry"/>
		</div>
		<div class="col-md-3 col-md-offset-5">
			<% if(!(bool)Context.Items["hideSearch"]) {%>
			<apn:localize runat="server" key="theme.text.datatable.filter"/>:
			<apn:control type="repeat-filter" runat='server' >
				<input type="text" class="form-control input-sm searchBox" placeholder="" value="<apn:value runat='server' />" name="<apn:name runat='server' />" />
			</apn:control>
			<span class="searchBtn">
				<span class="btn btn-sm glyphicon glyphicon-search" aria-hidden="true"/>
			</span>
			<% } %>
		</div>
	</div>
	</div>
<%} %>
    <table class="responsive <%= ((bool)Context.Items["hasPagination"] ? "hasPagination" : "")%>"
			<%= ((bool)Context.Items["hasPagination"] ? "data-total-pages='" + control.Current.getAttribute("totalPages") +"'": "")  %>>
		<% if ((bool)Context.Items["hasPagination"]) { %>
		<apn:control type="repeat-current-page" runat='server' >
			<input type="hidden" value="<apn:value runat='server' />" name="<apn:name runat='server' />" class="repeatCurrentPage"/>
		</apn:control>
		<% } 
		  if ("true".Equals(control.Current.getAttribute("hasSort"))) { 
		%>
		<apn:control type="repeat-sort" runat='server' >
			<input type="hidden" value="<apn:value runat='server' />" name="<apn:name runat='server' />" class="repeatSort"/>
		</apn:control>
		<% } %>
		<thead>
			<tr id="tr_<apn:name runat='server'/>">
			<% if ((bool)Context.Items["isSelectable"]) { %>
				<th class="selectBoxControl"></th>
			<% } %>
			<apn:forEach runat='server' id="row">
				<apn:forEach runat='server' id="col">
					<apn:forEach runat='server' id="field">
			<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") 
						&& !field.Current.getAttribute("visible").Equals("false") 
						&& !field.Current.getCSSClass().Contains("hide-from-list-view")) { %> 
			<th>
				<apn:label runat='server'/>
				<% if ("true".Equals(field.Current.getAttribute("isSortable"))) { %>
					&nbsp;&nbsp;
					
					<span data-sort="<%=field.Current.getAttribute("sort")%>" data-field-id="<%=field.Current.getFieldId()%>" 
					<%if ("asc".Equals(field.Current.getAttribute("sort"))) {%>
						class="glyphicon glyphicon-sort-by-attributes sortBtn" 
					<% } else if ("desc".Equals(field.Current.getAttribute("sort"))) {%>
						class="glyphicon glyphicon glyphicon-sort-by-attributes-alt sortBtn" 
					<% } else { %>
						class="glyphicon glyphicon-sort-by-attributes sortBtn"  style="color:LightGrey"
					<% } %>
				<% } %>
			</th>
			<% } %>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
				<th class="repeatbutton" data-priority="1">
					<% if (!(bool)Context.Items["hideAddButton"]) { %>
					<apn:control type="prepare_add_instance" id="button" runat='server'>
						<button type="button" 
								class="btn btn-sm btn-primary repeat_prepare_add_btn" 
								data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
                                data-level='<%=Context.Items["repeat-level"]%>'
								title='<apn:localize runat="server" key="theme.modal.add"/>' 
								name="<apn:name runat='server'/>" 
								id="<apn:name runat='server'/>"> <apn:localize runat="server" key="theme.modal.add"/> </button>
					</apn:control>
					<% } %>
				</th>
			</tr>
		</thead>
	</apn:control>
		<tbody>
	<apn:forEach id="status" runat="server"> <!-- status and group in jsp -->
		<% 	Context.Items["isEditOrDelete"] = "true".Equals(status.Current.getAttribute("edit-instance")) || "true".Equals(status.Current.getAttribute("new-instance")); %>
		<tr id='tr_<apn:name runat='server'/>_<%= status.getCount()%>' class='<%=((bool)Context.Items["isEditOrDelete"]? "active" : "")%>'>
			<% if ((bool)Context.Items["isSelectable"]) { %>
			<td class="selectBoxControl">
				<apn:control runat="server" type="select_instance" id="sel">
					<input type="hidden" name='<apn:name runat="server"/>' value="" />
					<input type='<%=Context.Items["selectionType"]%>' data-group='<%=control.Current.getName()%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked=\"checked\"" : "" %> />
				</apn:control>
			</td>
			<% } %>
			<apn:forEach runat='server' id="row1">
				<apn:forEach runat='server' id="col1">
					<apn:forEach runat='server' id="field1">
						<% if(!field1.Current.getAttribute("style").Equals("visibility:hidden;") 
								&& !field1.Current.getAttribute("visible").Equals("false")
								&& !field1.Current.getCSSClass().Contains("hide-from-list-view")) { //hidden field %> 
							<apn:ChooseControl runat='server'>
								<apn:WhenControl type="TRIGGER" runat='server'>
									<td>
										<% if (field1.Current.getAttribute("class").Equals("button")) {%>
											<button class='btn <apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' 
												name="<apn:name runat='server'/>" 
												style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>" >
													<apn:value runat='server'/>
											</button>
										<% } else if (field1.Current.getAttribute("class").Equals("pdf-button")) {%> 
											<a 
												href='genpdf/do.aspx/view.pdf?cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' 
												target="_blank"  
												title="<apn:tooltip runat='server'/>" 
												class="btn <apn:cssclass runat='server'/>" 
												style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>"><apn:value runat='server'/></a>
										<% } else if (field1.Current.getAttribute("class").Equals("view-xml-button")) { %>  
											<a 
												href='genxml/do.aspx/view.xml?cache=<%= System.Guid.NewGuid().ToString() %>&xsd=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>'
												target="_blank" 
												title="<apn:tooltip runat='server'/>" 
												class="btn <apn:cssclass runat='server'/>" 
												style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>" ><apn:value runat='server'/></a>
										<% } %>
									</td>
								</apn:WhenControl>
								<apn:Otherwise runat='server'>
									<%
										if(field1.Current.getType()==1014) {
											long staticvalue = 0;
											try {
												string dateFormat = field1.Current.getAttribute("format");
												dateFormat = dateFormat.Replace("mois","MM").Replace("jj","dd").Replace("aaaa","yyyy").Replace("aa","yy").Replace("mm","MM");
												staticvalue = DateTime.ParseExact(field1.Current.getValue(), dateFormat, System.Globalization.CultureInfo.InvariantCulture).Ticks;
											} catch(Exception e) {
											}                       
									%>
											<td data-order='<%=staticvalue%>'>
												<apn:ifcontrolattribute 
													runat='server' attr='prefix'><apn:controlattribute 
													runat='server' attr='prefix'/></apn:ifcontrolattribute><apn:value 
													runat='server' tohtml="true"/><apn:ifcontrolattribute 												runat='server' attr='suffix'><apn:controlattribute 
													runat='server' attr='suffix'/></apn:ifcontrolattribute>
											</td>
									<% } else { %>
											<td>
												<apn:ifcontrolattribute 
													runat='server' attr='prefix'><apn:controlattribute 
													runat='server' attr='prefix'/></apn:ifcontrolattribute><apn:value 
													runat='server' tohtml="true"/><apn:ifcontrolattribute 
													runat='server' attr='suffix'><apn:controlattribute 
													runat='server' attr='suffix'/></apn:ifcontrolattribute>
											</td>
									<%    } %>
								</apn:Otherwise>
							</apn:ChooseControl>
						<% } %>
					</apn:forEach>
				</apn:forEach>
			</apn:forEach>
			<td class="repeatbutton">
				<% if (!(bool)Context.Items["hideEditButton"]) { %>
				<apn:control runat='server' type="prepare_edit_instance">
					<span  
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						data-repeat-index-name='<%=Context.Items["hiddenName"]%>'
						data-instance-pos='<%= status.getCount()%>'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
                        data-level='<%=Context.Items["repeat-level"]%>'
						style="cursor:pointer"						
						class="glyphicon glyphicon-pencil repeat_prepare_edit_btn" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>"></span> 
				</apn:control>
				<% } %>
				<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
				<apn:control runat='server' type="delete">
					<span  
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						data-repeat-index-name='<%=Context.Items["hiddenName"]%>'
						data-instance-pos='<%= status.getCount()%>'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
						style="cursor:pointer"						
						class="glyphicon glyphicon-trash repeat_del_btn" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>"></span> 
				</apn:control>
				<% } %>
				<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
					<apn:control type="moveup" runat='server'>
						<span 
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						data-repeat-index-name='<%=Context.Items["hiddenName"]%>'
						data-instance-pos='<%= status.getCount()%>'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
						style="cursor:pointer"						
						class="glyphicon glyphicon-arrow-up repeat_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>"></span>
					</apn:control>
					<apn:control type="movedown" runat='server'>
						<span 
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						data-repeat-index-name='<%=Context.Items["hiddenName"]%>'
						data-instance-pos='<%= status.getCount()%>'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>' 
						style="cursor:pointer"						
						class="glyphicon glyphicon-arrow-down repeat_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>"></span>
					</apn:control>
				<% } %>				
			</td>
		</tr>
	</apn:forEach>
		</tbody>
	</table>
	<% if ((bool)Context.Items["hasPagination"]) { %>
	<div class="pull-left">
		&nbsp;&nbsp;&nbsp;&nbsp;<b>Page <span class="paginationInfo"><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%> /
		<%=control.Current.getAttribute("totalPages")%></b></span>
	</div>
	<% } %>
	</div>
	<!-- modal -->
	<apn:forEach runat='server' id="group1">
		<%if ("true".Equals(group1.Current.getAttribute("new-instance"))) {%>
			<% Server.Execute(Page.TemplateSourceDirectory + "/repeat_crud_add_modal.aspx"); %>
		<%}	else if ("true".Equals(group1.Current.getAttribute("edit-instance"))){%>
			<% Server.Execute(Page.TemplateSourceDirectory + "/repeat_crud_edit_modal.aspx"); %>
		<%} %>
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