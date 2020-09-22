<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">

<%
// Check if modal specified for the group
if ((" " + control.Current.getCSSClass() + " ").IndexOf(" smartmodal ") > -1) {
%>
	<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/modal.aspx"); %>
<% } else { %>
<%
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<div id="div_<apn:name runat='server'/>" style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	</div>
<%
} else {
%>

<% 	bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
	if (!bareControl){
%>
<div id="div_<apn:name runat='server'/>" <apn:metadata runat="server"/> class="panel panel-default <apn:cssclass runat='server'/>" style="<apn:cssstyle runat='server'/>" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	<%
		if (control.Current.getLabel() != ""){
	%>
	<div class="panel-heading">
		<h2 class="panel-title">
			<div class="pull-right"><% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %></div>
			<apn:label runat='server'/> 
			<apn:ifcontrolattribute runat='server' attr='title'>
				<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
			</apn:ifcontrolattribute>
		</h2>
	</div>
	<%
		}
	%>
	
	<div class="panel-body">
<%	}	%>
		<% Server.Execute(Page.TemplateSourceDirectory + "/controls.aspx"); %>
<%	if (!bareControl){ %>	
	</div>
</div>
<%	}	%>

<%
	}
}
%>  						
</apn:control>	

