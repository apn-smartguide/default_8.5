<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% string cssClass = control.Current.getCSSClass(); %>
	<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : ""; %>
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else { %>
	<div id='div_<apn:name runat="server"/>' class='form-group' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
		<% if (!BareRender){ %><% ExecutePath("/controls/label.aspx"); %><% } %>
		<apn:control type="edit-sub-interview" runat="server"><input <%=Context.Items["readonly"]%> value='<%=GetAttribute(control.Current, "label")%>' class='btn <apn:CSSClass runat="server"/> subSmartletBtn' name='<apn:name runat="server"/>' type='submit' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %> /></apn:control>
		<apn:forEach runat="server"><div class='recap'><h2><apn:label runat="server" /></h2><% ExecutePath("/controls/summary/controls.aspx"); %></div></apn:forEach>
	</div>
	<% } %>
</apn:control>