<% if(GetMetaDataValue(control.Current, "unsafe").Equals("true")) { %>
	<div id='div_<apn:name runat="server"/>' <!-- #include file="aria-live.inc" --> ><input type='hidden' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='<apn:value runat="server"/>' <apn:metadata runat="server" /> /></div>
<% } else { %>
	<div id='div_<apn:name runat="server"/>' style='display:none;' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live='polite'<% } %> ></div>
<% } %>
