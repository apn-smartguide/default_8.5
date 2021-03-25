<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<%} else {%>
	<% if (!BareRender){ %>
	<div class='modal' role='dialog' id='modal_<apn:name runat="server"/>'>
		<div class='modal-dialog <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' role='document'>
			<div class='modal-content'>
				<div class='modal-header'>
					<button type='button' class='close modal-close' data-dismiss='modal' aria-label='<apn:localize runat="server" key="theme.text.close"/>' title='<apn:localize runat="server" key="theme.text.close"/>' ><span aria-hidden='true' >&times;</span></button>
					<h4 class='modal-title'><apn:label runat="server" /></h4>
				</div>
				<div class='modal-body'>
					<div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite" <% } %>>
						<div id='modalAlerts_<apn:name runat="server"/>'><% ExecutePath("/controls/repeats/validation.aspx"); %></div>
						<% Context.Items["context-modal"] = true; %>
						<% ExecutePath("/controls/controls.aspx"); %>
						<% Context.Items["context-modal"] = null; %>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<% } %>
<% } %>
</apn:control>