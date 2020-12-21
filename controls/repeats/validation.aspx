<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<!-- Check to see if there are required fields and if any validation errors occurred -->
<% Context.Items["required"] = false; %>
<% Context.Items["alert"] = false; %>
<% Context.Items["loopOnErrorControls"] = 0; %>
<% Context.Items["counter"] = 1; %>
<apn:IfRequiredControlExists runat="server">																		
	<% Context.Items["required"] = true; %>
</apn:IfRequiredControlExists>
<apn:forEach id="index" items="alert-controls" runat="server">
	<% Context.Items["alert"] = true; %>
</apn:forEach>
    <% if((bool)Context.Items["required"]) { %>									
    	<div class='alert alert-info' role='alert'>	
		<span>*</span> 
		<apn:localize runat="server" key="theme.text.required"/>
	</div>
	<% } %>
    <% if ((bool)Context.Items["alert"]) { %>
	<div id='repeat-errors-validation' class='alert alert-danger modal-messages' role='alert' style='padding:3px 10px 3px 10px;'>
     <h3>Errors while submiting form </h3>
    <ol>
	<apn:forEach items="alert-controls" id="control" runat="server">
        <li id='error_<%=Context.Items["counter"] %>_<%= control.Current.getName() %>' >
		<% if(control.Current.getAlert().Trim().Equals("error.goto.summary")) { %>
			<apn:localize runat="server" key="theme.text.flowchange"/>
		<% } else if (control.Current.getAlert().Trim().Equals("error.language.change")) { %>
			<apn:localize runat="server" key="theme.text.languagechange"/>
		<% } else { %>
		<%
            string id =control.Current.getName().Remove(0,2);
            string label = sg.getSmartlet().getSessionSmartlet().findFieldById(id).getLabel();
			int index = (int)Context.Items["loopOnErrorControls"];
			Context.Items["loopOnErrorControls"] = ++index;
        %>
			<a 
				href='' 
				onclick='$(/'#modal/').animate({scrollTop: $(/'#error_index_<%=Context.Items["loopOnErrorControls"]%>/').offset().top}, 1000); $(/'#error_index_<%=Context.Items["loopOnErrorControls"]%>/').siblings().find(/':focusable/')[0].focus(); return false;' 
				title='Link to Error <%=control.getCount()%>'> <%=label%> - <%= control.Current.getAlert() %></a><br/>
		<% } %>
		<%
            int counter = (int)Context.Items["counter"];
            Context.Items["counter"] = ++counter;
        %>
        </li>
	</apn:forEach>
    </ol>
	</div>
<% } else { %>
	<div class='alert' style='display:none;'></div>
<% } %>