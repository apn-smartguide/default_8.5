<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">
<div class="modal crud-modal<%=Context.Items["repeat-level"]%>" tabindex="-1" role="dialog">
<div class="modal-dialog">
<div class="modal-content">
	<div class="modal-header">
		<apn:control runat="server" type="cancel_edit_instance">
			<button type="button" 
					class="close repeat_cancel_edit_btn" 
					name="<apn:name runat='server'/>" id="<apn:name runat='server'/>" 
					data-eventtarget='["<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>"]' 
					data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		</apn:control>
		
		<h5 class="modal-title">
			<apn:label runat='server'/>
			<apn:ifcontrolattribute runat='server' attr='title'>
				<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
			</apn:ifcontrolattribute>
		</h5>
	</div>
	<div class="modal-body" id="div_<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>_edit_modal_body">
		<% Server.Execute(Page.TemplateSourceDirectory + "/repeat-validation.aspx"); %>
		<% Context.Items["context-modal"] = true; %>
		<% Server.Execute(Page.TemplateSourceDirectory + "/controls.aspx"); %>
		<% Context.Items["context-modal"] = null; %>
    </div>			
	<div class="modal-footer">
		<apn:control runat="server" type="save_edit_instance">
			<button type="button" 
					class="btn btn-primary repeat_save_edit_btn"
                    data-level='<%=Context.Items["repeat-level"]%>'
					data-eventtarget='[<%=Context.Items["repeat-event-targets-edit-" + Context.Items["repeat-level"]]%>]' 
					name="<apn:name runat='server'/>" id="<apn:name runat='server'/>"	><apn:localize runat="server" key="theme.modal.save"/></button>
		</apn:control>
		<apn:control runat="server" type="cancel_edit_instance">
			<button type="button" 
					class="btn btn-default repeat_cancel_edit_btn" 
                    data-level='<%=Context.Items["repeat-level"]%>'
					data-dismiss="modal" 
					data-eventtarget='[<%=Context.Items["repeat-event-targets-cancel-" + Context.Items["repeat-level"]]%>]'
					name="<apn:name runat='server'/>" id="<apn:name runat='server'/>" ><apn:localize runat="server" key="theme.modal.cancel"/></button>
		</apn:control>
    </div>
</div>
</div>
</div>
</apn:control>
