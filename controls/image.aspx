<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>>
	</div>
	<% } else { %>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/>'
		<% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>
		<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %>>
		<img src='<apn:controlattribute attr="src" runat="server"/>' id='<apn:code runat="server"/>' class='<apn:cssclass runat="server"/>' style='width:<apn:controlattribute attr="width" runat="server"/>;height:<apn:controlattribute attr="height" runat="server"/>;<apn:cssstyle runat="server"/>' alt='<apn:controlattribute attr="alt" runat="server"/>' <apn:metadata runat="server" /> title='<apn:controlattribute attr="title" tohtml="true" runat="server" />'/>
		<div class='caption'>
			<% Server.Execute(resolvePath("/controls/label.aspx")); %>
		</div>
	</div>
	<% } %>
</apn:control>