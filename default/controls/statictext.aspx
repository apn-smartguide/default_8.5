<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div id as it is referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<div id="div_<apn:name runat='server'/>" style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	</div>
<%
	} else { 

	bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
%>
<div id="div_<apn:name runat='server'/>" class="form-group <apn:cssclass runat='server'/>" style="<apn:controlattribute runat='server' attr='style'/><apn:cssstyle runat='server'/>" 
 <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> 
 <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' <% } %>
 <apn:metadata runat="server"/>
 >
<%
	if (control.Current.getLabel().Trim().Length == 0) bareControl = true;
	if (!bareControl){
%>
	<label>
		<apn:label runat="server"/>
		<!-- tooltip comes here -->
		<apn:ifcontrolattribute runat="server" attr='title'>
			<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat="server" tohtml='true' attr='title'/>"></span>
		</apn:ifcontrolattribute>
	</label>
<%	}	%>
    <apn:value runat='server'/>
    <% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
	</div>
<%	}
%>

</apn:control>