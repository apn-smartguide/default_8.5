<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? "disabled" : ""; %>
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
	</div>
	<% } else if (Context.Items["btn-group"] != null && Context.Items["btn-group"].Equals("true")) { %>
	<span id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<button class='<apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <apn:metadata runat="server" /> aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> >
			<apn:value runat="server" />
		</button>
	</span>
	<% } else { %>
	<div id='div_<apn:name runat="server" />' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<% if (control.Current.getAttribute("class").Equals("button")) {%>
		<button class='<apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' name='<apn:name runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <apn:metadata runat="server" /> aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> >
			<apn:value runat="server" />
		</button>
		<% } %>
		<% if (control.Current.getAttribute("class").Equals("pdf-button")) { %>
		<%-- Generate PDF using form submit, for this to be functional, need to uncomment the pdf form in default.aspx --%>
		<%-- 
		<button type='submit' name='<apn:name runat="server"/>' value='<apn:value runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' onclick='document.forms[/'pdf/'].elements[/'pdf/'].value=/'<apn:name runat="server"/>/'; document.forms[/'pdf/'].submit(); return false;' /> 
		--%>
		<a href='genpdf/do.aspx/view.pdf?cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' target='_blank' title='<apn:tooltip runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>'>
			<apn:value runat="server" />
		</a>
		<% } %>
		<% if (control.Current.getAttribute("class").Equals("view-xml-button")) { %>
		<%-- GenerateXML using form submit, for this to be functional, need to uncomment the xml form in default.aspx --%>
		<%-- 
		<button type='submit' name='<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>' onclick='document.forms[/'genXML/'].elements[/'xsd/'].value=/'<apn:name runat="server"/>/'; document.forms[/'genXML/'].submit(); return false;'>
			<apn:value runat="server"/>
		</button> 
		--%>
		<a href='genxml/do.aspx/view.xml?cache=<%= System.Guid.NewGuid().ToString() %>&xsd=<apn:name runat="server"/>&interviewID=<apn:control type="interview-code" runat="server"><apn:value runat="server"/></apn:control>' target='_blank' title='<apn:tooltip runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/> <apn:cssstyle runat="server"/>'>
			<apn:value runat="server" />
		</a>
		<% } %>
		<%-- Server.Execute(resolvePath("/controls/help.aspx")); --%>
	</div>
	<% } %>
</apn:control>