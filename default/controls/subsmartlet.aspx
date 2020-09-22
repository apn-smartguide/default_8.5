<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div id as it is referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
string cssClass = control.Current.getCSSClass();
Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : ""; 
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<div id="div_<apn:name runat='server'/>" style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	</div>
<%
} else {
%>
<% 	
	bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
%>
	<div id="div_<apn:name runat='server'/>" class="form-group" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
<%
	if (!bareControl){
%>
  	    <% Server.Execute(Page.TemplateSourceDirectory + "/label.aspx"); %>
<%	}	%>	
	<apn:control type="edit-sub-interview" runat='server'>
		<input <%=Context.Items["readonly"]%> value="<apn:label runat='server'/>" class="btn <apn:CSSClass runat='server'/> subSmartletBtn" name="<apn:name runat='server'/>" type="submit" 
			<apn:metadata runat="server"/>
			<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %>/>
	</apn:control>
	<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
	<apn:forEach runat='server'>
		<div class="recap">
			<h2><apn:label runat='server'/></h2>
			<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
		</div>			
	</apn:forEach>
	</div>


<% } %>
</apn:control>	

