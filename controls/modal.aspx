<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
if (!IsAvailable(control.Current)) {
	Execute("/controls/hidden.aspx");
} else {
	if (!BareRender){
%>
	<div class='modal' role='dialog' id='modal_<apn:name runat="server"/>'>
		<div class='modal-dialog <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' role='document'>
			<div class='modal-content'>
				<div class='modal-header'>
					<% string eventTargets = ""; %>
					<% SessionField button = GetProxyButton(control.Current.getCode()+"_cancel", ref eventTargets); %>
					<div class='modal-title'><apn:label runat="server" /></div>
					<% if(button != null) { %>
						<button type='button' name='d_<%=button.getId()%>' data-eventtarget='[<%=eventTargets%>]' class='sg btn-modal close modal-close' data-dismiss='modal' aria-label='<apn:localize runat="server" key="theme.text.close"/>' title='<apn:localize runat="server" key="theme.text.close"/>' ><span aria-hidden='true' >&times;</span></button>
						<% } else { %>
						<button type='button' class='sg close modal-close' data-dismiss='modal' aria-label='<apn:localize runat="server" key="theme.text.close"/>' title='<apn:localize runat="server" key="theme.text.close"/>' ><span aria-hidden='true' >&times;</span></button>
					<% } %>
				</div>
				<div class='modal-body'>
					<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite" <% } %>>
						<% Context.Items["context-modal"] = true; %>
						<div id='modal-alerts_<apn:name runat="server"/>'><% Execute("/controls/validation.aspx"); %></div>
						<% Execute("/controls/controls.aspx"); %>
						<% Context.Items["context-modal"] = null; %>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<% } %>
<% } %>
</apn:control>