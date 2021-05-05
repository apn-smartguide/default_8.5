<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? "disabled" : ""; %>
	<% Context.Items["tooltip-attribute"] = ""; %>
	<%
		string tooltip = GetTooltip(control.Current);
		if (!tooltip.Equals("")) { 
			Context.Items["tooltip-attribute"] = "title='" + tooltip + "' aria-label='" + tooltip + "'";
		}
	%>
	<% if (control.Current.getAttribute("visible").Equals("false") || IsPdf || IsSummary) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else if (control.Current.getAttribute("class").Equals("view-xml-button") || control.Current.getAttribute("class").Equals("pdf-button")) { %>
		<span id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
			<% if (control.Current.getAttribute("class").Equals("pdf-button")) { %>
			<%-- Generate PDF using form submit, for this to be functional, need to uncomment the pdf form in default.aspx --%>
			<%-- <button type='submit' name='<apn:name runat="server"/>' value='<apn:value runat="server"/>' <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' onclick='document.forms[/'pdf/'].elements[/'pdf/'].value=/'<apn:name runat="server"/>/'; document.forms[/'pdf/'].submit(); return false;' /> --%>
				<% if(control.Current.getCSSClass().Contains("safe-pdf")) { %> <%-- must use this if CSRF enabled --%>
					<a href='genpdf/do.aspx/view.pdf?cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' target='_blank' data-toggle='tooltip' data-html='true' <% if (!GetTooltip(control.Current).Equals("")){ %>title='<%=GetTooltip(control.Current)%>' aria-label='<%=GetTooltip(control.Current)%>'<% } %> class='btn <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>'><apn:value runat="server"/></a>
				<% } else { %>
					<a href='genpdf/do.aspx?t_<%=control.Current.getFieldId()%>=t_<%=control.Current.getFieldId()%>&cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&id=<apn:code runat="server"/>' target='_blank' data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>'><apn:value runat="server"/></a>
				<% } %>
			<% } %>
			<% if (control.Current.getAttribute("class").Equals("view-xml-button")) { %>
			<%-- GenerateXML using form submit, for this to be functional, need to uncomment the xml form in default.aspx --%>
			<%-- <button type='submit' name='<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' onclick='document.forms[/'genXML/'].elements[/'xsd/'].value=/'<apn:name runat="server"/>/'; document.forms[/'genXML/'].submit(); return false;'><apn:value runat="server"/></button> --%>
			<a href='genxml/do.aspx?t_<%=control.Current.getFieldId()%>=t_<%=control.Current.getFieldId()%>&cache=<%= System.Guid.NewGuid().ToString() %>&xsd=<apn:name runat="server"/>&id=<apn:code runat="server"/>' target='_blank' data-toggle='tooltip' data-html='true' <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/>" style="<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' ><apn:value runat="server"/></a>
			<% } %>
		</span>
	<% } else if (Context.Items["btn-group"] != null && Convert.ToBoolean(Context.Items["btn-group"])) { %>
		<span id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>><button <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <apn:metadata runat="server" /> ><apn:value runat="server" /></button></span>
	<% } else if (Context.Items["no-col"] != null && Convert.ToBoolean(Context.Items["no-col"])) { %>
		<span id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>><button <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <apn:metadata runat="server" /> ><apn:value runat="server" /></button></span>	
	<% } else { %>
		<span id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
			<button <%=Context.Items["tooltip-attribute"]%> class='<apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' <%=Context.Items["readonly"]%> name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <apn:metadata runat="server" /> ><apn:value runat="server" /></button>
		</span>
	<% } %>
	<% Context.Items["tooltip-attribute"] = ""; %>
</apn:control>