<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<!-- Check to see if there are required fields and if any validation errors occurred -->
<% Context.Items["alert"] = false; %>
<% Context.Items["required"] = false; %>
<apn:IfRequiredControlExists runat="server">																		
	<% Context.Items["required"] = true; %>
</apn:IfRequiredControlExists>
<apn:forEach id="index" items="alert-controls" runat="server">
	<% Context.Items["alert"] = true; %>
</apn:forEach>
<% if ((bool)Context.Items["alert"] || (bool)Context.Items["required"]) {%>
	<% if ((bool)Context.Items["required"]) {%>
        <div class="well well-sm modal-messages"><span class="required">*</span> <apn:localize runat="server" key="theme.text.required"/></div>
	<% } %>
	<% if ((bool)Context.Items["alert"]) {%>
	<div id="repeat-errors-validation" class="alert alert-danger modal-messages" role="alert">
	<apn:forEach items="alert-controls" id="control" runat="server">
		<% if(control.Current.getAlert().Trim().Equals("error.goto.summary")) {%>
			<apn:localize runat="server" key="theme.text.flowchange"/>
		<% }else if (control.Current.getAlert().Trim().Equals("error.language.change")) { %>
			<apn:localize runat="server" key="theme.text.languagechange"/>
		<% } else{ %>
		   <a href="" onclick="$('body').animate({scrollTop: $('#div_<%= control.Current.getName() %>').offset().top}, 1000);return false;"/><%= control.Current.getAlert() %></a><br/>
		<% } %>
	</apn:forEach>
	</div>
	<% } %>
<%} else {%>
	<div class="alert" style="display:none;"></div>
<%}%>

