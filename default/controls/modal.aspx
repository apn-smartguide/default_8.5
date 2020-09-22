<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server" id="control">

<%if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="render_hidden_div.inc" -->
<%} else {%>

<% bool noLabel = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
	if (!noLabel){
%>

<div class="modal" tabindex="-1" role="dialog" id="modal_<apn:name runat='server'/>">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">  
	
        <button type="button" class="close modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title"><apn:label runat='server'/></h4>
      </div>
      <div class="modal-body">
<div id="div_<apn:name runat='server'/>" class="<apn:cssclass runat='server'/>" style="<apn:cssstyle runat='server'/>" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	<div id="modalAlerts_<apn:name runat='server'/>">
		<% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/repeat-validation.aspx"); %>
	</div>
		<% Context.Items["context-modal"] = true; %>
        <% Server.Execute(Page.TemplateSourceDirectory + "/" + "../controls/controls.aspx"); %>
		<% Context.Items["context-modal"] = null; %>
</div>
      </div>

    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%	}	
}	
%>  						
</apn:control>	

