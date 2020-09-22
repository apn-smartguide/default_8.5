<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<% 
  Context.Items["hiddenName"] = ""; 
%>
<apn:control runat="server" id="control">
<%
Context.Items["hideAddButton"] = control.Current.getCSSClass().Contains("hide-add-btn");
Context.Items["showMoveUpDownButton"] = control.Current.getCSSClass().Contains("show-moveupdown-btn");
Context.Items["hideDeleteButton"] = control.Current.getCSSClass().Contains("hide-delete-btn");
Context.Items["hidePagination"] = control.Current.getCSSClass().Contains("hide-pagination");
Context.Items["hideSearch"] = control.Current.getCSSClass().Contains("hide-search");
Context.Items["labelIdPrefix"] = "lbl_" + control.Current.getCode();
Context.Items["isSelectable"] = control.Current.getAttribute("isselectable").Equals("true");
Context.Items["hasPagination"] = "true".Equals(control.Current.getAttribute("hasPagination")) && !((bool)Context.Items["hideSearch"]);
Context.Items["selectionType"] = control.Current.getAttribute("selectiontype");
%>
<div id="div_<apn:name runat='server'/>" 
		<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'<% } %>
		class="panel panel-default repeat <%=control.Current.getCSSClass()%> <% if ((bool)Context.Items["isSelectable"]) {%>selectable<%}%> <apn:ifnotcontrolvalid runat='server' >has-error</apn:ifnotcontrolvalid>" 
		style="<%=control.Current.getCSSStyle()%>" <!-- #include file="aria-live.inc" --> >
    
    <% if(((string)Context.Items["hiddenName"]).Length == 0) { %>
        <apn:control runat='server' type="repeat-index" id="repeatIndex">
            <input name="<apn:name runat='server'/>" type="hidden" value="" />
            <% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
        </apn:control>
    <% } %>
        
	<div class="panel-heading">
		<h2 class="panel-title">
			<div class="pull-right"><% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %></div>
			<apn:label runat='server'/>
			<apn:ifcontrolattribute runat='server' attr='title'>
				<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
			</apn:ifcontrolattribute>
		</h2>
	</div>
    
	<div class="panel-body bootpag">
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
        <apn:control runat='server' type="default-instance" id="defaultGroup">
		<thead>
		<tr id="tr_<apn:name runat='server'/>">
			<% if ((bool)Context.Items["isSelectable"]) { %>
				<th></th>
			<% } %>
		<apn:forEach runat='server' id="row">
			<apn:forEach runat='server' id="col">
				<apn:forEach runat='server' id="field">
		<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") && !field.Current.getCSSClass().Contains("hide-from-list-view")) { // Don't show if it's a hidden field %> 
			<th 
				class='<%=col.Current.getLayoutAttribute("all")%>' 
				id='<%=Context.Items["labelIdPrefix"].ToString()+"col"+col.getCount()%>' 
			>
				<apn:ifcontrolvalid runat='server'><span></apn:ifcontrolvalid><apn:ifnotcontrolvalid runat='server'><span class="error"></apn:ifnotcontrolvalid><apn:label runat='server'/>
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
					></span>
				<% } %>
				</span>
				<apn:ifcontrolrequired runat='server'><span class="required">*</span></apn:ifcontrolrequired>
				<apn:ifcontrolattribute attr='title' runat='server'>
					<span data-toggle="tooltip" data-placement="right" class="glyphicon glyphicon-question-sign" title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
				</apn:ifcontrolattribute>
			</th>
		<% } %>
				</apn:forEach>
			</apn:forEach>
		</apn:forEach>
			  
		<% if (!(bool)Context.Items["hideAddButton"]) { %>
			<th class="repeatbutton" data-priority="1" style="text-align:center">
				<apn:control type="insert" id="button" runat='server'>
				<button type="button" 
							class="btn btn-sm btn-primary repeat_table_append_btn" 
							data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
							title='<apn:localize runat="server" key="theme.modal.add"/>'
							name='<apn:name runat="server"/>' 
							id='<apn:name runat="server"/>'> <apn:localize runat="server" key="theme.modal.add"/> </button>
				</apn:control>
			</th>
		<% } %>
		</tr>
		</thead>
	</apn:control>
		<tbody>
	<apn:forEach id="status" runat="server">
		<tr id="tr_<apn:name runat='server'/>_<%= status.getCount()%>">
			<% if ((bool)Context.Items["isSelectable"]) { %>
			<td>
				<apn:control runat="server" type="select_instance" id="sel">
					<input type="hidden" name='<apn:name runat="server"/>' value="" />
					<input type='<%=Context.Items["selectionType"]%>' data-group='<%=control.Current.getName()%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked=\"checked\"" : "" %> />
				</apn:control>
			</td>
			<% } %>		
			<apn:forEach id="field2" runat='server'>
			<%Context.Items["aria-labelledby"] = Context.Items["labelIdPrefix"].ToString()+"col"+field2.getCount(); //override aria-labelledby by table header %>
			<%Context.Items["optionIndex"] = status.getCount(); %>
			<apn:choosecontrol runat='server'>
				<apn:whencontrol type="RECAP" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/summary.aspx"); %>
					</td>												
				</apn:whencontrol>
				<apn:whencontrol runat='server' type="ROW">
					<apn:control runat='server' id="controlrow">
						<apn:forEach runat='server' id="col3">											
							<apn:choosecontrol runat='server'>
								<apn:whencontrol runat='server' type="COL">
									<% 
										Context.Items["aria-labelledby"] = Context.Items["labelIdPrefix"].ToString()+"col"+col3.getCount();
										Server.Execute(Page.TemplateSourceDirectory + "/repeat_col.aspx"); 
										Context.Items.Remove("aria-labelledby"); 
									%>
								</apn:whencontrol>
							</apn:choosecontrol>
						</apn:forEach>
					</apn:control>
				</apn:whencontrol>
				<apn:whencontrol runat='server' type="COL">
					<% Server.Execute(Page.TemplateSourceDirectory + "/col.aspx"); %>
				</apn:whencontrol>
				<apn:whencontrol type="GROUP" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/group.aspx?bare_control=true"); %>
					</td>												
				</apn:whencontrol>
				<apn:whencontrol type="REPEAT" runat='server'>												
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/repeat.aspx"); %>
					</td>
				</apn:whencontrol>
				<apn:whencontrol type="INPUT" runat='server'>
					<% if(!field2.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
						<td>
					<% } %>
					<% Server.Execute(Page.TemplateSourceDirectory + "/input.aspx?bare_control=true"); %>
					<% if(!field2.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
						</td>
					<% } %>
				</apn:whencontrol>
				<apn:whencontrol type="TEXTAREA" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/textarea.aspx?bare_control=true"); %>
					</td>
				</apn:whencontrol>
				<apn:whencontrol type="SECRET" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/secret.aspx?bare_control=true"); %>
					</td>
				</apn:whencontrol>
				<apn:whencontrol type="DATE" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/date.aspx?bare_control=true"); %>
					</td>												
				</apn:whencontrol>
				<apn:whencontrol type="SELECT" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/select.aspx?bare_control=true"); %>
					</td>
				</apn:whencontrol>
				<apn:whencontrol type="SELECT1" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/select1.aspx?bare_control=true"); %>
					</td>
				</apn:whencontrol>
				<apn:whencontrol type="STATICTEXT" runat='server'>
				<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/statictext.aspx?bare_control=true"); %>
					</td>
				</apn:whencontrol>
				<apn:whencontrol type="IMAGE" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/image.aspx?bare_control=true"); %>
					</td>
				</apn:whencontrol>
				<Apn:WhenControl runat="server" type="UPLOAD">
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/upload.aspx"); %>
					</td>
				</Apn:WhenControl>
				<Apn:WhenControl runat="server" type="TRIGGER">
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/button.aspx"); %>
					</td>
				</Apn:WhenControl>				
				<apn:whencontrol type="SUB-SMARTLET" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/subsmartlet.aspx?bare_control=true"); %>
					</td>							
				</apn:whencontrol>												
				<apn:whencontrol type="RESULT" runat='server'>
					<td>
						<% Server.Execute(Page.TemplateSourceDirectory + "/result.aspx"); %>
					</td>
				</apn:whencontrol>	
			</apn:choosecontrol></apn:forEach>

			<td class="repeatbutton">
			<% if (!(bool)Context.Items["hideAddButton"]) { %>
				<apn:control type="insert" id="addbutton" runat='server'>
					<span 
						class="glyphicon glyphicon-plus repeat_table_add_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>" 
                                                title='<apn:localize runat="server" key="theme.modal.add"/>'
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'
					></span>
				</apn:control>
			<% } %>
			<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
				<apn:control type="delete" id="deletebutton" runat='server'>
					<span 
						class="glyphicon glyphicon-trash repeat_table_del_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>" 
                                                title='<apn:localize runat="server" key="theme.text.deleteinstance"/>'
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'
					></span>
				</apn:control>
			<% } %>
			<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
				<apn:control type="moveup" id="moveupbutton" runat='server'>
					<span 
						class="glyphicon glyphicon-arrow-up repeat_table_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>" 
                                                title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>'
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'
					></span>
				</apn:control>
				<apn:control type="movedown" id="movedownbutton" runat='server'>
					<span 
						class="glyphicon glyphicon-arrow-down repeat_table_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>" 
                                                title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>'
						data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
						aria-controls='tr_<%=control.Current.getName()%>_<%= status.getCount()%>'
					></span>
				</apn:control>
			<% } %>
			</td>
		</tr>
		<%Context.Items.Remove("aria-labelledby"); %>
	</apn:forEach>
	<%Context.Items["optionIndex"] = ""; %>
		</tbody>
	</table>
	<% if ((bool)Context.Items["hasPagination"]) { %>
	<div class="pull-left">
		&nbsp;&nbsp;&nbsp;&nbsp;<b>Page <span class="paginationInfo"><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%> /
		<%=control.Current.getAttribute("totalPages")%></b></span>
	</div>
	<% } %>
	</div>
</div>

</apn:control>	