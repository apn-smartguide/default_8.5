<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<%-- Uncomment to use the contextualhelp/default.aspx template to display the help contents
	<% if (!control.Current.getHelp().Equals("")) { %>
	<apn:ifhelplink runat="server"><a href='<apn:help runat="server"/>' target='_blank' class='link-help' data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.helptitle"/>'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></a></apn:ifhelplink>
	<apn:ifnothelplink runat="server"><button type='submit' name='<apn:helpid runat="server"/>' value='<apn:helpid runat="server"/>' class='sg btn btn-link' data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.helptitle"/>' aria-label='<apn:localize runat="server" key="theme.text.helptitle"/>'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></button></apn:ifnothelplink>
	<% } %>
	--%>
	<% if (!control.Current.getHelp().Equals("")) { %>
		<% if (Context.Items["context-modal"] != null) { %>
			<details>
			<apn:ifhelplink runat="server">	<a href='<apn:help runat="server"/>' target='_blank' class='link-help' data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.helptitle"/>' aria-label='<apn:localize runat="server" key="theme.text.helptitle"/>'><span class='<apn:localize runat="server" key="theme.icon.help"/>' aria-hidden='true'></span> <apn:localize runat="server" key="theme.text.helplink"/></a></apn:ifhelplink>
			<apn:ifnothelplink runat="server"><apn:help runat="server"/></apn:ifnothelplink>
			</details>
		<% } else { %>
			<span  data-toggle='modal' data-target='#div_<apn:helpid runat="server"/>' onclick='return false;'>
			<a href='#' alt="question mark icon" class='link-help' data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.helptitle"/>' arial-label='<apn:localize runat="server" key="theme.text.helptitle"/>'>
				<apn:ifnotcontrolvalid runat="server">
					<span class='has-error <% if(LayoutEngine == "BS4") {Response.Output.Write("fa fa-question-circle");} else { Response.Output.Write("glyphicon glyphicon-question-sign"); }%>'/>
				</apn:ifnotcontrolvalid>
				<apn:ifcontrolvalid runat="server">
					<span class="sr-only">Question mark</span>
					<span aria-hidden="true" class='<% if (LayoutEngine == "BS4") {Response.Output.Write("fa fa-question-circle");} else { Response.Output.Write("glyphicon glyphicon-question-sign"); }%>'/>
				</apn:ifcontrolvalid>
			</a>
			</span>
			<!-- Modal -->
			<div class='modal fade' id='div_<apn:helpid runat="server"/>' tabindex='-1' role='dialog' aria-labelledby='helpModalLabel_<apn:helpid runat="server"/>' aria-hidden='true'>
				<div class='modal-dialog modal-lg'>
					<div class='modal-content'>
						<div class='modal-header'>
							<span class='modal-title' id='helpModalLabel_<apn:helpid runat="server"/>'><apn:label runat="server"/></span>
							<a href='#' class='close' data-dismiss='modal' onclick='return false;' title='<apn:localize runat="server" key="theme.text.close"/>' aria-label='<apn:localize runat="server" key="theme.text.close"/>'><span aria-hidden='true'>x</span><span class='sr-only'><apn:localize runat="server" key="theme.text.close"/></span></a>
							<%-- todo: lookup for data-help-label in future version --%>
						</div>
						<div class='modal-body'>
							<apn:ifhelplink runat="server"><iframe id='smartlet' src='<apn:help runat="server"/>' width='100%' height='400px;' frameborder='0' framespacing='0' scrolling='auto'></iframe></apn:ifhelplink>
							<apn:ifnothelplink runat="server"><apn:help runat="server"/></apn:ifnothelplink>
						</div>
						<div class='modal-footer'><button class='sg btn <% if(LayoutEngine == "BS4") { Response.Output.Write("btn-secondary"); } else { Response.Output.Write("btn-default"); } %>' data-dismiss='modal' onclick='return false;' aria-label='<apn:localize runat="server" key="theme.text.close"/>'><apn:localize runat="server" key="theme.text.close"/></button></div>
					</div>
				</div>
			</div>
		<% } %>
	<% } %>
</apn:control>