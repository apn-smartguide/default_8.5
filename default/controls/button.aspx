<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div id as it is referenced in smartguide.js --%>
<apn:control runat="server" id="control">
    <%  
        Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? "disabled" : "";
	%>
	<%
	if (control.Current.getAttribute("visible").Equals("false")) {
	%>
		<div id="div_<apn:name runat='server'/>" style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
		</div>
	<%
	} else {
	%>
	
	<div id="div_<apn:name runat='server' />" class="form-group" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
      
  	<% if (control.Current.getAttribute("class").Equals("button")) {%>
		<button class='btn <apn:cssclass runat="server"/> <%=Context.Items["readonly"]%>' name="<apn:name runat='server'/>" style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>" <% if(!control.Current.getAttribute("eventtarget").Equals("")) { 
			%>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
			<apn:metadata runat="server"/>
			aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %>	><apn:value runat='server'/></button>
	<% } %>
  
  	<% if (control.Current.getAttribute("class").Equals("pdf-button")) {
  		//Generate PDF using form submit, for this to be functional, need to add the pdf form
  		%> 
	 
	 <%--
  	 <button type="submit" name="<apn:name runat='server'/>" value="<apn:value runat='server'/>" class="btn <apn:cssclass runat='server'/>" style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>" onclick="document.forms['pdf'].elements['pdf'].value='<apn:name runat='server'/>'; document.forms['pdf'].submit(); return false;" />
	 --%>	 
  	    <a href='genpdf/do.aspx?t_<%=control.Current.getFieldId()%>=t_<%=control.Current.getFieldId()%>&cache=<%= System.Guid.NewGuid().ToString() %>&pdf=<apn:name runat="server"/>&id=<apn:code runat="server"/>' target="_blank"  title="<apn:tooltip runat='server'/>" class="btn <apn:cssclass runat='server'/>" style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>"><apn:value runat='server'/></a>
  	<% } %>
  	<% if (control.Current.getAttribute("class").Equals("view-xml-button")) {
	 //GenerateXML using form submit, for this to be functional, need to add the xml form 
	 %>  
	 <%--
		<button type="submit" name="<apn:name runat='server'/>" class="btn <apn:cssclass runat='server'/>" style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>" onclick="document.forms['genXML'].elements['xsd'].value='<apn:name runat='server'/>'; document.forms['genXML'].submit(); return false;"><apn:value runat='server'/></button>
	 --%>	 
		<a href='genxml/do.aspx?t_<%=control.Current.getFieldId()%>=t_<%=control.Current.getFieldId()%>&cache=<%= System.Guid.NewGuid().ToString() %>&xsd=<apn:name runat="server"/>&id=<apn:code runat="server"/>'
           target="_blank" title="<apn:tooltip runat='server'/>" class="btn <apn:cssclass runat='server'/>" style="<apn:controlattribute runat='server' attr='style'/> <apn:cssstyle runat='server'/>" ><apn:value runat='server'/></a>
  	<% } %>
  		<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
	</div>
<%
}
%>	
</apn:control>	