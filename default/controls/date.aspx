<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<!-- #include file="render_hidden_div.inc" -->
<%
} else { 
Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? "
 readonly='readonly' disabled='disabled'" : "";
%>
	<div id="div_<apn:name runat='server'/>" class="form-group <apn:cssclass runat='server'/> <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" <!-- #include file="aria-live.inc" --> >
	<!-- #include file="control_label.inc" -->
		<div>
  	<apn:forEach runat='server'><apn:choosecontrol runat='server'>											
		<apn:whencontrol type="INPUT" runat='server'>												
			<input 
				type="text" 
				name="<apn:name runat='server'/>" 
				id="<apn:name runat='server'/>" 
				value="<apn:value runat='server' tohtml='true'/>"
				size="<apn:controlattribute attr='size' runat='server'/>" 
                                <apn:metadata runat="server"/>
				maxlength="<apn:controlattribute attr='size' runat='server'/>"
				<%= Context.Items["readonly"] %>
				<!-- #include file="aria_attributes.inc" -->
			/>
		</apn:whencontrol>
		<apn:whencontrol type="SELECT1" runat='server'>
			<apn:control id="control1" runat='server'>					
				<select <apn:metadata runat="server"/> name="<apn:name runat='server'/>" 
					<apn:ifnotcontrolvalid runat='server'>
						aria-describedby='error_<apn:name runat="server"/>'
					</apn:ifnotcontrolvalid> 
					aria-invalid='<%= (control.Current.isValid()? "true" : "false")%>' 
					aria-required="<%=control.Current.isRequired()%>"
					aria-labelledby="lbl_<apn:name runat='server'/>" 
					<%= Context.Items["readonly"] %>
				>
					<apn:forEach id="control2" runat='server'>
						<option 
							<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
								data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
								aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
							<% } %>
							id="<apn:name runat='server'/>" 
							name="<apn:name runat='server'/>" 
							value="<apn:value runat='server' tohtml='true'/>" 
							<%= control1.Current.containsValue(control2.Current.getValue()) ? "selected" : "" %>>
								<apn:label runat='server'/> 
						</option>
					</apn:forEach>
				</select>
			</apn:control>	
		</apn:whencontrol>
		<apn:whencontrol type="LABEL" runat='server'>	
			<apn:label runat='server'/>
		</apn:whencontrol>
  	</apn:choosecontrol></apn:forEach>
	</div>
	</div>
<%
} 
%>		
</apn:control>	

