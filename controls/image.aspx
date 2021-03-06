<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>></div>
	<% } else { %>
	<% if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) {Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " "; } else { Context.Items["no-col-layout"] = ""; } %>
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> form-group <apn:cssclass runat="server"/> <% if (TTSEnabled) { %>tts tts-play<% } %>'
		<% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite' <% } %>
		<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %>>
		<img src='<apn:controlattribute attr="src" runat="server"/>' id='<apn:code runat="server"/>' class='<apn:cssclass runat="server"/>' style='width:<apn:controlattribute attr="width" runat="server"/>;height:<apn:controlattribute attr="height" runat="server"/>;<apn:cssstyle runat="server"/>' alt='<%=GetAttribute(control.Current, "alt")%>' <apn:metadata runat="server" /> title='<%=GetAttribute(control.Current, "title", true)%>'/>
		<% if(!control.Current.getLabel().Equals("")) { %><div class='caption'><% ExecutePath("/controls/label.aspx"); %></div><% } %>
	</div>
	<% } %>
</apn:control>