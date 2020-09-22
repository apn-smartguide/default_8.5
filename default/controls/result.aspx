<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div id as it is referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<div id="div_<apn:name runat='server'/>" style="display:none;" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
	</div>
<%
} else {
%>
  <div id="div_<apn:name runat='server'/>" class="knowledge" <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite"<% } %> >
		<h2><apn:forEach begin="0" end="0" runat='server'><apn:value runat='server'/></apn:forEach></h2>
		
  	<apn:forEach begin="1" runat='server'>
  		<apn:choosecontrol runat='server'>											
  			<apn:whencontrol type="RESULT_REPEAT" runat='server'>																							
                               <div class="row">
					<div class="col-sm-3">
						<apn:forEach runat="server" begin="0" end="0"><apn:label runat="server"/></apn:forEach>
					</div>
					<div class="col-sm-9">
						<apn:forEach runat="server"><apn:control runat="server">
							<apn:forEach runat="server">
								<apn:control runat="server">
									<li><apn:label runat="server"/>: <apn:value runat="server"/></li>







								</apn:control>	
							</apn:forEach>
						</apn:control></apn:forEach>
					</div>
				</div>	
  			</apn:whencontrol>
  			<apn:otherwise runat='server'>
  				<div class="row">
					<div class="col-sm-3">
						<apn:label runat="server"/>
					</div>
					<div class="col-sm-9">
						<apn:value runat="server"/>


					</div>
				</div>
  			</apn:otherwise> 
  		</apn:choosecontrol>
  	</apn:forEach>
	</div>
<%
}
%>
</apn:control>

