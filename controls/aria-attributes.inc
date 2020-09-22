<% if (Context.Items["aria-labelledby"] !=null ){ %>
	aria-labelledby='<%=Context.Items["aria-labelledby"].ToString()%>'
<% } else { %>
	aria-labelledby='lbl_<apn:name runat="server"/>'
<% } %>
<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
	data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
	aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
<% } %>
aria-invalid='<%= (control.Current.isValid()? "true" : "false")%>' 
aria-required='<%= (control.Current.isRequired()? "true" : "false")%>'
