<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
		<!-- #include file="render_hidden_div.inc" -->
	<% } else { %> 
		<div class="<apn:cssclass runat='server'/> recap" style="<apn:controlattribute attr='style' runat='server'/><apn:cssstyle runat='server'/>">
			<apn:forEach runat='server'>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">
							<apn:label runat='server'/> 
							<div class="pull-right">
								<apn:control runat='server' type="modify" id="button" >
									<input type="submit" class="btn btn-xs btn-default" name="<apn:name runat='server'/>" value="<apn:label runat='server'/>" />
								</apn:control>
							</div>
						</h2>
					</div>

					<div class="panel-body">			
						<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
					</div>
				</div>				
			</apn:forEach>
		</div>
	<% } %>
</apn:control>	

