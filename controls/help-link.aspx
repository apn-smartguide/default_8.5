<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<%-- Uncomment to use the contextualhelp/default.aspx template to display the help contents
	<% if (!control.Current.getHelp().Equals("")) { %>
	<apn:ifhelplink runat="server"><a href='<apn:help runat="server"/>' target='_blank' class='link-help' title='<apn:localize runat="server" key="theme.text.helptitle"/>'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></a></apn:ifhelplink>
	<apn:ifnothelplink runat="server"><button type='submit' name='<apn:helpid runat="server"/>' value='<apn:helpid runat="server"/>' class='btn btn-link' title='<apn:localize runat="server" key="theme.text.helptitle"/>' aria-label='<apn:localize runat="server" key="theme.text.helptitle"/>'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></button></apn:ifnothelplink>
	<% } %>
	--%>
	<% if (!control.Current.getHelp().Equals("")) { %>
		<% if (Context.Items["context-modal"] != null) { %>
			<details>
			<apn:ifhelplink runat="server">	<a href='<apn:help runat="server"/>' target='_blank' class='link-help' title='<apn:localize runat="server" key="theme.text.helptitle"/>' aria-label='<apn:localize runat="server" key="theme.text.helptitle"/>'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></a></apn:ifhelplink>
			<apn:ifnothelplink runat="server"><apn:help runat="server"/></apn:ifnothelplink>
			</details>
		<% } else { %>
			<a href='#' class='link-help' title='<apn:localize runat="server" key="theme.text.helptitle"/>' aria-label='<apn:localize runat="server" key="theme.text.helptitle"/>' data-toggle='modal' data-target='#div_<apn:helpid runat="server"/>' onclick='return false;'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></a>
			<!-- Modal -->
			<div class='modal fade' id='div_<apn:helpid runat="server"/>' tabindex='-1' role='dialog' aria-labelledby='helpModalLabel_<apn:helpid runat="server"/>' aria-hidden='true'>
				<div class='modal-dialog'>
					<div class='modal-content'>
						<div class='modal-header'>
							<a href='#' class='close' data-dismiss='modal' onclick='return false;' title='<apn:localize runat="server" key="theme.text.close"/>' aria-label='<apn:localize runat="server" key="theme.text.close"/>'><span aria-hidden='true'>x</span><span class='sr-only'><apn:localize runat="server" key="theme.text.close"/></span></a>
							<h2 class='modal-title' id='helpModalLabel_<apn:helpid runat="server"/>'><apn:localize runat="server" key="theme.text.helplink"/></h2>
						</div>
						<div class='modal-body'>
							<apn:ifhelplink runat="server"><iframe id='smartlet' src='<apn:help runat="server"/>' width='100%' height='400px;' frameborder='0' framespacing='0' scrolling='auto'></iframe></apn:ifhelplink>
							<apn:ifnothelplink runat="server"><apn:help runat="server"/></apn:ifnothelplink>
						</div>
						<div class='modal-footer'><a href='#' class='btn btn-default' data-dismiss='modal' onclick='return false;' title='<apn:localize runat="server" key="theme.text.helptitle"/>' aria-label='<apn:localize runat="server" key="theme.text.close"/>'><apn:localize runat="server" key="theme.text.close"/></a></div>
					</div>
				</div>
			</div>
		<% } %>
	<% } %>
</apn:control>