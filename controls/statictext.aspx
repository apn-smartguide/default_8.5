<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
	</div>
	<% } else { %>
	<% bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/>' style='<apn:controlattribute runat="server" attr="style"/><apn:cssstyle runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> <apn:metadata runat="server" /> >
	<% if (control.Current.getLabel().Trim().Length == 0) bareControl = true; %>
	<% if (!bareControl){ %>
	<label>
		<span><% Server.Execute(resolvePath("/controls/tooltip.aspx")); %></span>
	</label>
	<% } %>
	<% if (control.Current.getValue().Trim().Length > 0) { %>
	<span><% Server.Execute(resolvePath("/controls/tooltip.aspx")); %></span>
	<% } %>
	</div>
	<% } %>
	</apn:control>