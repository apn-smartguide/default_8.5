<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<% 
  Context.Items["hiddenName"] = ""; 
  Context.Items["isOnlyStatic"] = true ; 
  Context.Items["optionIndex"] = 0;
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
	class="panel panel-default repeat repeatblock <%=control.Current.getCSSClass()%> <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" 
	style="<%=control.Current.getCSSStyle()%>" <!-- #include file="aria-live.inc" --> >
	
	<apn:control runat='server' type="default-instance" id="defaultGroup">
		<apn:control runat='server' type="repeat-index" id="repeatIndex">
			<input name="<apn:name runat='server'/>" type="hidden" value="" />
			<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
		</apn:control>
		<div class="panel-heading">
			<div><apn:label runat='server'/></div>
			<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
			<% if (!(bool)Context.Items["hideAddButton"]) { %>
			<div class="pull-right">
				<apn:control runat='server' type="insert" id="button">
				<button type="button" 
							class="btn btn-sm btn-primary repeat_block_append_btn" 
							data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
							title='<apn:localize runat="server" key="theme.modal.add"/>'
							name='<apn:name runat="server"/>' 
							id='<apn:name runat="server"/>'> <apn:localize runat="server" key="theme.modal.add"/> </button>
				</apn:control>	
			</div>
			<% } %>
		</div>
    <% if (!control.Current.getAttribute("title").Equals("")) { %>		
		<div class="groupHelp">
			<apn:controlattribute attr='title' tohtml='true' runat='server'/>
		</div>
  	<% } %>
	</apn:control>
	<div class="bootpag">
	<% if ((bool)Context.Items["hasPagination"]) { %>
		<div class="container form-inline" style="padding:10px">
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
	<tbody>
	<tr><td>	
	<apn:forEach id="status" runat="server">
	<div class="panel panel-default repeatinstance"  id="div_<apn:name runat='server' />_<%= status.getCount()%>">
        <%Context.Items["optionIndex"] = status.getCount(); %>
		<div class="panel-heading">
			<div>
			<% if ((bool)Context.Items["isSelectable"]) { %>
				<apn:control runat="server" type="select_instance" id="sel">
					<input type="hidden" name='<apn:name runat="server"/>' value="" />
					<input type='<%=Context.Items["selectionType"]%>' data-group='<%=control.Current.getName()%>' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value="true" <%= "true".Equals(sel.Current.getValue()) ? "checked=\"checked\"" : "" %> />
				</apn:control>
			<% } %>
			<%= status.getCount()%>.
			</div>
			<div class="pull-right">
			<% if (!(bool)Context.Items["hideAddButton"]) { %>
				<apn:control runat='server' type="insert">
				<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
					aria-controls="div_<apn:name runat='server'/>_<%= status.getCount()%>" 
									title='<apn:localize runat="server" key="theme.modal.add"/>'
					class="glyphicon glyphicon-plus repeat_block_add_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" id="<apn:name runat='server'/>_<%= status.getCount()%>" ></span>
				</apn:control>
			<% } %>
			<% if (!(bool)Context.Items["hideDeleteButton"]) { %>
				<apn:control runat='server' type="delete">
				<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
					aria-controls="div_<apn:name runat='server'/>_<%= status.getCount()%>" 
									title='<apn:localize runat="server" key="theme.text.deleteinstance"/>'
					class="glyphicon glyphicon-trash repeat_table_del_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" id="<apn:name runat='server'/>_<%= status.getCount()%>" ></span>
				</apn:control>
			<% } %>
			<% if ((bool)Context.Items["showMoveUpDownButton"]) { %>
				<apn:control type="moveup" runat='server'>
					<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
					aria-controls="div_<apn:name runat='server'/>_<%= status.getCount()%>" 
									title='<apn:localize runat="server" key="theme.text.moveinstanceup"/>'
					class="glyphicon glyphicon-arrow-up repeat_block_moveup_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>" 
					></span>
				</apn:control>
				<apn:control type="movedown" runat='server'>
					<span data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]'
					aria-controls="div_<apn:name runat='server'/>_<%= status.getCount()%>" 
									title='<apn:localize runat="server" key="theme.text.moveinstancedown"/>'
					class="glyphicon glyphicon-arrow-down repeat_block_movedown_btn <%=Context.Items["hiddenName"]%>_<%= status.getCount()%>" 
						id="<apn:name runat='server'/>_<%= status.getCount()%>" 
					></span>
				</apn:control>
			<% } %>
			</div>
		</div>
		<div class="panel-body">
			<% Server.Execute(Page.TemplateSourceDirectory + "/controls.aspx"); %>
		</div>
	</div>
	</apn:forEach>
	</td></tr></tbody></table>
	<% if ((bool)Context.Items["hasPagination"]) { %>
	<div class="pull-left">
		&nbsp;&nbsp;&nbsp;&nbsp;<b>Page <span class="paginationInfo"><%=Convert.ToInt32(control.Current.getAttribute("currentPage")) +1%> /
		<%=control.Current.getAttribute("totalPages")%></b></span>
	</div>
	<% } %>
	</div>
	<%Context.Items["optionIndex"] = ""; %>
</div>

</apn:control>	