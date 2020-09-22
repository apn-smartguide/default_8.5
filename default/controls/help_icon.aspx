<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">
	<%-- Uncomment to use the contextualhelp/default.aspx template to display the help contents instead of a modal
	<% if (!control.Current.getHelp().Equals("")) { %>
	<apn:ifhelplink runat='server'>
		<a href="<apn:help runat='server'/>" target="_blank" class="link-help" title="<apn:localize runat='server' key='theme.text.helptitle'/>">
			<span class="glyphicon glyphicon-play" aria-hidden="true"></span> <apn:localize runat='server' key='theme.text.helplink'/>
		</a>
	</apn:ifhelplink>
	<apn:ifnothelplink runat='server'>
		<button type="submit" name="<apn:helpid runat='server'/>" value="<apn:helpid runat='server'/>" class="btn btn-link" title="<apn:localize runat='server' key='theme.text.helptitle'/>">
		  <span class="glyphicon glyphicon-play" aria-hidden="true"></span> <apn:localize runat='server' key='theme.text.helplink'/>
		</button>
	</apn:ifnothelplink>
	<% } %>
	--%>
	
	<% if (!control.Current.getHelp().Equals("")) { %>
		<% if (Context.Items["context-modal"] != null) { %>
			<details>
			<apn:ifhelplink runat='server'>	
				<a href="<apn:help runat='server'/>" target="_blank" class="link-help" title="<apn:localize runat='server' key='theme.text.helptitle'/>">
					<span class="glyphicon glyphicon-play" aria-hidden="true"></span> <apn:localize runat='server' key='theme.text.helplink'/>
				</a>
			</apn:ifhelplink>
			<apn:ifnothelplink runat='server'>
				<apn:help runat='server'/>
			</apn:ifnothelplink>
			</details>
		<% } else { %>
			<a href="#" class="link-help" title="<apn:localize runat='server' key='theme.text.helptitle'/>" data-toggle="modal" data-target='#div_<%=control.Current.getHelpId().Replace("[","_").Replace("]","")%>' onclick="return false;">
				<span class="glyphicon glyphicon-play" aria-hidden="true"></span> <apn:localize runat='server' key='theme.text.helplink'/>
			</a>
			<!-- Modal -->
			<div class="modal fade" id='div_<%=control.Current.getHelpId().Replace("[","_").Replace("]","")%>' tabindex="-1" role="dialog" aria-labelledby="helpModalLabel_<apn:helpid runat='server'/>" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<a href="#" class="close" data-dismiss="modal" onclick="return false;"><span aria-hidden="true">×</span><span class="sr-only">Close</span></a>
							<h4 class="modal-title" id="helpModalLabel_<apn:helpid runat='server'/>"><apn:localize runat='server' key='theme.text.helplink'/></h4>
						</div>
						<div class="modal-body">
							<apn:ifhelplink runat='server'>
								<iframe id="smartlet" src="<apn:help runat='server'/>" width="100%" height="400px;" frameborder="0" framespacing="0" scrolling="auto"></iframe>
							</apn:ifhelplink>
							<apn:ifnothelplink runat='server'>
								<apn:help runat='server'/>
							</apn:ifnothelplink>
						</div>
						<div class="modal-footer">
							<a href="#" class="btn btn-default" data-dismiss="modal" onclick="return false;">Close</a>
							<!--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>-->
						</div>
					</div>
				</div>
			</div>
		<% } %>	
	<% } %>

</apn:control>
	
