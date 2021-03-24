<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<% Context.Items["required"] = false; %>
<% Context.Items["alert"] = false; %>
<% Context.Items["underCrudRepeat"] = false; %>
<% Context.Items["counter"] = 0; %>
<% if (!IsPdf) { %>
	<apn:IfRequiredControlExists runat="server"><% Context.Items["required"] = true; %></apn:IfRequiredControlExists>
	<% Context.Items["errorIndex"] = 0; %>
	<%
	ISmartletField f = null;
	ISmartletField[] fields = CurrentPage.findAllFields();
	for(int i = 0; i < fields.Length; i++) {
		if((fields[i].getTypeConst() == DotnetConstants.ElementType.REPEAT) && fields[i].getCSSClass().Contains("grid-view")) {
			Context.Items["underCrudRepeat"] = true;
		}
		else if (IsUnderRepeat(fields[i]) && ((bool)Context.Items["underCrudRepeat"])){
			continue;
		} else {
			Context.Items["underCrudRepeat"] = false;
			if(fields[i].isRequired()) {
				f = fields[i];
				Context.Items["required"] = true;
				break;
			}
		}
	}
	Context.Items["alerts-count"] = 0;
	%>
	<apn:forEach id="alerts" items="alert-controls" runat="server"><% Context.Items["alerts-count"] = alerts.getCount(); %></apn:forEach>
	<% if (( (int)Context.Items["alerts-count"] > 0) || ((bool)Context.Items["required"] == true)) {%>
	<div id='alerts'><%-- do not change the div id as it is referenced in smartguide.js --%>
		<apn:IfRequiredControlExists runat="server"><div class='alert alert-info' role='alert'><span class='required'>*</span><apn:localize runat="server" key="theme.text.required"/></div></apn:IfRequiredControlExists>
		<% if ((int)Context.Items["alerts-count"] > 0) { %>
		<section id="errors-fdbck-frm" class='alert alert-danger' role='alert'>
			<h2><%=Smartlet.getLocalizedResource("theme.text.errors-found").Replace("{1}", Context.Items["alerts-count"].ToString()) %></h2>
			<ul><apn:forEach items="alert-controls" id="alert" runat="server">
				<li id='error_<%=Context.Items["counter"] %>_<%= alert.Current.getName() %>'>
					<% if(alert.Current.getAlert().Trim().Equals("error.goto.summary")) { %>
						<apn:localize runat="server" key="theme.text.flowchange"/>
					<% } else if (alert.Current.getAlert().Trim().Equals("error.language.change")) { %>
						<apn:localize runat="server" key="theme.text.languagechange"/>
					<% } else if (!alert.Current.getName().Equals("")) { %>
					<%
						string fieldLabel = "";
						if(!string.IsNullOrEmpty(alert.Current.getName())) {
							string id =alert.Current.getName().Remove(0,2);
							if(id.Contains("[")) { id = id.Remove(id.IndexOf("[")); }
							fieldLabel = sg.getSmartlet().getSessionSmartlet().findFieldById(id).getLabel();
						}
						Context.Items["counter"] = (int)Context.Items["counter"] + 1;
					%>
					<a href='' onclick="$('body,html').animate({scrollTop: $('#div_<%= alert.Current.getName() %>'.replace('[','\\[').replace(']','\\]')).offset().top}, 1000);return false;"/><span class="prefix">Error <%= Context.Items["counter"] %>:</span> <%= fieldLabel %> - <%= alert.Current.getAlert() %></a>
					<% } else { %><span class="required">Page Error: <%= alert.Current.getAlert() %></span><% } %>
				</li>
			</apn:forEach><ul>
		</section>
		<% } %>
	</div>
	<% } %>
<% } %>