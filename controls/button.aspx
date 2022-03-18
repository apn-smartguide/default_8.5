<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["render-proxy"] = (Context.Items["render-proxy"] != null) ? (bool)Context.Items["render-proxy"] : false; %>
	<% Context.Items["btn-wizard"] = (Context.Items["btn-wizard"] != null) ? (bool)Context.Items["btn-wizard"] : false; %>
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? "disabled" : ""; %>
	<% Context.Items["aria-label"] = ""; %>
	<% Context.Items["label"] = control.Current.getLabel(); %>
	<%
		string label = control.Current.getLabel();
		if(!label.Equals("")) {
			Context.Items["aria-label"] = "aria-label='" + label + "'";
		}
		if(control.Current.getCSSClass().Contains("btn-link") && !control.Current.getValue().Equals("")) {
			Context.Items["label"] = control.Current.getValue();
		}
	%>
	<% Context.Items["tooltip-attribute"] = ""; %>
	<%
		string tooltip = GetTooltip(control.Current);
		if (!tooltip.Equals("")) { 
			Context.Items["tooltip-attribute"] = "title='" + tooltip + "'";
		}
	%>
	<% if ((control.Current.getCSSClass().Contains("proxy") && !(bool)Context.Items["render-proxy"]) || (control.Current.getCSSClass().Contains("btn-wizard") && !(bool)Context.Items["btn-wizard"])) { %>
	<% } else if (control.Current.getAttribute("visible").Equals("false") || IsPdf || IsSummary) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else if (control.Current.getAttribute("class").Equals("view-xml-button") || control.Current.getAttribute("class").Equals("pdf-button")) { %>
		<span class="ml-1 mr-1" id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
			<% if (control.Current.getAttribute("class").Equals("pdf-button")) { %>
			<%-- Generate PDF using form submit, for this to be functional, need to uncomment the pdf form in default.aspx --%>
			<%-- <button type='submit' name='<apn:name runat="server"/>' value='<apn:value runat="server"/>' class='sg <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> onclick='document.forms[/'pdf/'].elements[/'pdf/'].value=/'<apn:name runat="server"/>/'; document.forms[/'pdf/'].submit(); return false;' <%=Context.Items["aria-label"]%> /> --%>
				<% if(control.Current.getCSSClass().Contains("safe-pdf")) { %> <%-- must use this if CSRF enabled --%>
					<a href='genpdf/do.aspx/view.pdf?cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' target='_blank' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> class='btn <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <%=Context.Items["aria-label"]%> ><%= Context.Items["label"] %></a>
				<% } else { %>
					<a href='genpdf/do.aspx?t_<%=control.Current.getFieldId()%>=t_<%=control.Current.getFieldId()%>&cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&id=<apn:code runat="server"/>' target='_blank' data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' ><%= Context.Items["label"] %></a>
				<% } %>
			<% } %>
			<% if (control.Current.getAttribute("class").Equals("view-xml-button")) { %>
			<%-- GenerateXML using form submit, for this to be functional, need to uncomment the xml form in default.aspx --%>
			<%-- <button type='submit' name='<apn:name runat="server"/>' class='sg <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> onclick='document.forms[/'genXML/'].elements[/'xsd/'].value=/'<apn:name runat="server"/>/'; document.forms[/'genXML/'].submit(); return false;' <%=Context.Items["aria-label"]%>><%= Context.Items["label"] %></button> --%>
			<a href='genxml/do.aspx?t_<%=control.Current.getFieldId()%>=t_<%=control.Current.getFieldId()%>&cache=<%= System.Guid.NewGuid().ToString() %>&xsd=<apn:name runat="server"/>&id=<apn:code runat="server"/>' target='_blank' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> class='<apn:cssclass runat="server"/>" style="<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <%=Context.Items["aria-label"]%>><%= Context.Items["label"] %></a>
			<% } %>
		</span>
	<% } else if ((Context.Items["btn-group"] != null && Convert.ToBoolean(Context.Items["btn-group"])) || (Context.Items["btn-toolbar"] != null && Convert.ToBoolean(Context.Items["btn-toolbar"]))) { %>
		<button type="button" id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' class='sg <apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> <% if (control.Current.getCSSClass().IndexOf("disable-event-targets") == -1) { %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <% } %> <apn:metadata runat="server" /> <%=Context.Items["aria-label"]%>><%= Context.Items["label"] %></button>
	<% } else if (Context.Items["no-col"] != null && Convert.ToBoolean(Context.Items["no-col"])) { %>
		<span class="ml-1 mr-1" id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
			<button type="button" class='sg <apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> <% if (control.Current.getCSSClass().IndexOf("disable-event-targets") == -1) { %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <% } %> <apn:metadata runat="server" /> <%=Context.Items["aria-label"]%>><%= Context.Items["label"] %></button>
		</span>	
	<% } else { %>
		<span class="ml-1 mr-1" id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
			<button type="button" class='sg <apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' <%=Context.Items["readonly"]%> name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if (!GetTooltip(control.Current).Equals("")){ %> data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> <% } %> <% if (control.Current.getCSSClass().IndexOf("disable-event-targets") == -1) { %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <% } %> <apn:metadata runat="server" /> <%=Context.Items["aria-label"]%>><%= Context.Items["label"] %></button>
		</span>
	<% } %>
	<% Context.Items["tooltip-attribute"] = ""; %>
</apn:control>