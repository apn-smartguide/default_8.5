<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<apn:control runat="server" id="control">
<% Context.Items["required"] = false; %>
<% Context.Items["alert"] = false; %>
<% Context.Items["underCrudRepeat"] = false; %>
<% Context.Items["counter"] = 0; %>
<% Context.Items["target"] = "body,html"; %>
<% Context.Items["idsuffix"] = ""; %>
<% if (Context.Items["context-modal"] != null) {
	Context.Items["target"] = "#modal"; 
	Context.Items["idsuffix"] = "_" + control.Current.getName();
}
%>
<% if (!IsPdf || !IsSummary) { %>
	<% 
	if(Errors.Length > 0) {
	%>
	<div class="alert alert-danger">
		<p><strong><%=Smartlet.getLocalizedResource("theme.text.unexpected-error")%></strong></p>
	<%
		for (int i = 0; i < Errors.Length; i ++) {
			string errorMessage = Errors[i].ToString();
			if(errorMessage.Contains("<html")) {
				Response.Output.Write("<iframe width='100%' frameborder='0' marginheight='5' marginwidth='5' srcdoc='" + errorMessage + "'></iframe>");
			} else {
				Response.Output.Write(errorMessage);
			}
		}
	%>
	</div>
	<%
	}
	%>
	<apn:IfRequiredControlExists runat="server"><% Context.Items["required"] = true; %></apn:IfRequiredControlExists>
	<% ErrorIndex = 0; %>
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
	<apn:forEach id='alerts' items="alert-controls" runat="server">
		<% 
			// alerts might come from a control inside a modal, so we must check
			// the origin of the field first
			bool isInsideModal = false;
			
			string fieldId = alerts.Current.getName();
			
			//Logger.info("fieldId: " + fieldId);
			
			if (fieldId.StartsWith("d_")) fieldId = fieldId.Substring(2);
			ISmartletField fieldInError = CurrentPage.findFieldById(fieldId);
			if (fieldInError != null) {
				// check if this field is under a smartmodal
				ISmartletField parent = fieldInError;
				do {
					parent = parent.getParent();
					if (parent != null && parent.getCSSClass() != null && parent.getCSSClass().Contains("smartmodal")) {
						isInsideModal = true;
						break;
					}
				} while(parent != null);
			}
			// if in modal
			//Logger.info("context modal: " + Context.Items["context-modal"]);
			//Logger.info("is inside?: " + isInsideModal);
			
			if (Context.Items["context-modal"] != null && isInsideModal) {
				// increment the counter
				int alertCounter = (int)Context.Items["alerts-count"];
				Context.Items["alerts-count"] = ++alertCounter;
			}
			// if at main page
			if (Context.Items["context-modal"] == null && !isInsideModal) {
				// increment the counter
				int alertCounter = (int)Context.Items["alerts-count"];
				Context.Items["alerts-count"] = ++alertCounter;
			}
			
			//Logger.info("alerts count: " + Context.Items["alerts-count"]);
		%>
	</apn:forEach>
	<% if (( (int)Context.Items["alerts-count"] > 0) || ((bool)Context.Items["required"] == true)) { %>
	<div id='alerts<%=Context.Items["idsuffix"]%>'><%-- do not change the div id as it is referenced in smartguide.js --%>
		<% if (!CurrentPageCSS.Contains("hide-required-notification")) { %>
		<apn:IfRequiredControlExists runat="server"><section class='alert alert-info' role='alert'><span class='required'>*</span><apn:localize runat="server" key="theme.text.required"/></section></apn:IfRequiredControlExists>
		<% } %>
		<% if ((int)Context.Items["alerts-count"] > 0) { %>
		<section id="errors-fdbck-frm" class='alert alert-danger' role='alert'>
			<h2><%=Smartlet.getLocalizedResource("theme.text.errors-found").Replace("{1}", Context.Items["alerts-count"].ToString()) %></h2>
			<ul>
			<apn:forEach items="alert-controls" id="alert" runat="server">
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
					<a href='' onclick="$('<%=Context.Items["target"]%>').animate({scrollTop: $('#div_<%= alert.Current.getName() %>'.replace('[','\\[').replace(']','\\]')).offset().top}, 1000);return false;"><% if (ShowEnumerationErrors){%><span class="prefix">Error <%= Context.Items["counter"] %>:</span><%} if (!string.IsNullOrEmpty(fieldLabel)){%> <%= fieldLabel %> - <%}%><%= alert.Current.getAlert() %></a>
					<% } else { %><span class="required">Page Error: <%= alert.Current.getAlert() %></span><% } %>
				</li>
			</apn:forEach>
			</ul>
		</section>
		<% } %>
	</div>
	<% } %>
<% } %>
</apn:control>