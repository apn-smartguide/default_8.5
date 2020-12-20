<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SGPage" Trace="false"%>
<apn:control runat="server" id="control">
	<div class='modal crud-modal<%=Context.Items["repeat-level"]%>' tabindex='-1' role='dialog'>
		<section class='modal-dialog overlay-def'>
			<div class='modal-content'>
				<header class='modal-header'>
					<h5 class='modal-title'>
						<% Server.Execute(resolvePath("/controls/custom/control-label.aspx")); %>
					</h5>
				</header>
				<% string repeatName = "repeat-name-" + Context.Items["repeat-level"]; %>
				<% string modalBodyName = "div_" + Context.Items[repeatName] + "_" + Context.Items["modal-mode"] + "_modal_body"; %>
				<div class='modal-body' id='<%=modalBodyName%>'>
					<% Server.Execute(resolvePath("/controls/repeats/validation.aspx")); %>
					<% Context.Items["context-modal"] = true; %>
					<% Server.Execute(resolvePath("/controls/controls.aspx")); %>
					<% Context.Items["context-modal"] = null; %>
				</div>
				<div class='modal-footer'>
					<% if(Context.Items["modal-mode"].Equals("add")) { %>
					<apn:control runat="server" type="save_add_instance">
						<button type='button' class='btn btn-primary repeat_save_add_btn' data-level='<%=Context.Items["repeat-level"]%>' data-eventtarget='[<%=Context.Items["repeat-event-targets-" + Context.Items["modal-mode"] + "-" + Context.Items["repeat-level"]]%>]' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>'>
							<apn:localize runat="server" key="theme.modal.save"/>
						</button>
					</apn:control>
					<apn:control runat="server" type="cancel_add_instance">
						<button type='button' class='btn btn-default repeat_cancel_<%=Context.Items["modal-mode"]%>_btn' data-level='<%=Context.Items["repeat-level"]%>' data-dismiss='modal' data-eventtarget='[<%=Context.Items["repeat-event-targets-cancel-" + Context.Items["repeat-level"]]%>]' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>'>
							<apn:localize runat="server" key="theme.modal.cancel" /></button>
					</apn:control>
					<% } else { %>
					<apn:control runat="server" type="save_edit_instance">
						<button type='button' class='btn btn-primary repeat_save_edit_btn' data-level='<%=Context.Items["repeat-level"]%>' data-eventtarget='[<%=Context.Items["repeat-event-targets-" + Context.Items["modal-mode"] + "-" + Context.Items["repeat-level"]]%>]' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>'>
							<apn:localize runat="server" key="theme.modal.save"/>
						</button>
					</apn:control>
					<apn:control runat="server" type="cancel_edit_instance">
						<button type='button' class='btn btn-default repeat_cancel_<%=Context.Items["modal-mode"]%>_btn' data-level='<%=Context.Items["repeat-level"]%>' data-dismiss='modal' data-eventtarget='[<%=Context.Items["repeat-event-targets-cancel-" + Context.Items["repeat-level"]]%>]' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>'>
							<apn:localize runat="server" key="theme.modal.cancel" />
						</button>
					</apn:control>
					<% } %>
				</div>
			</div>
			<% if(Context.Items["modal-mode"].Equals("add")) { %>
			<apn:control runat="server" type="cancel_add_instance">
			<%-- issue with cancel close not aborting --%>
			<!-- <button type='button'class='close repeat_cancel_add_btn mfp-close ' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' data-eventtarget='["<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>"]' data-dismiss='modal' aria-label='Close' title="Close: Middle screen overlay (escape key)">×<span class="<apn:localize runat="server" key="theme.class.error-link"/>"> Close: Middle screen overlay (escape key)</span></button> -->
			</apn:control>
			<% } else { %>
			<apn:control runat="server" type="cancel_edit_instance">
			<%-- issue with cancel close not aborting --%>
			<!-- <button type='button'class='close repeat_cancel_add_btn mfp-close ' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' data-eventtarget='["<%=Context.Items["repeat-name-" + Context.Items["repeat-level"]]%>"]' data-dismiss='modal' aria-label='Close' title="Close: Middle screen overlay (escape key)">×<span class="<apn:localize runat="server" key="theme.class.error-link"/>"> Close: Middle screen overlay (escape key)</span></button> -->
			</apn:control>	
			<% } %>
		</section>
	</div>
</apn:control>
