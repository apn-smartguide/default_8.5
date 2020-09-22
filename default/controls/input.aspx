<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the div ids as they are referenced in smartguide.js --%>
<apn:control runat="server" id="control">
<%
Context.Items["html5type"]="text";
// check if html5 type specified explicitly
if (control.Current.getAttribute("html5type").Length > 0) {
	Context.Items["html5type"] = control.Current.getAttribute("html5type");
}
%>
<%	
if(control.Current.getAttribute("style").Equals("visibility:hidden;")) {	
%>
	<div id="div_<apn:name runat='server'/>" <!-- #include file="aria-live.inc" --> >
		<input type="hidden" name="<apn:name runat='server'/>" id="<apn:name runat='server'/>" 
			value="<apn:value runat='server' tohtml='true'/>" <apn:metadata runat="server"/> />
	</div>
<% 	
} else { 
	if (control.Current.getAttribute("visible").Equals("false")) {
%>
		<!-- #include file="render_hidden_div.inc" -->
<%	} else { 
		Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly' disabled='disabled'" : "";
		Context.Items["maxlength"] = control.Current.getAttribute("maxlength");
		if (Context.Items["maxlength"] == null) Context.Items["maxlength"] = "";

%>
		<div id="div_<apn:name runat='server'/>" class="form-group <apn:cssclass runat='server'/> <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" <!-- #include file="aria-live.inc" --> >
			<!-- #include file="control_label.inc" -->
<%		if(control.Current.getType()==1014) { // date field, 'date' class definition below needed for datepicker %>
			<div class="input-group date" id="div_ctrl_<apn:name runat='server'/>" data-apnformat="<apn:controlattribute runat='server' attr='format'/>">
				<input 
					type="<%=Context.Items["html5type"]%>" 
					name="<apn:name runat='server'/>" 
					id="<apn:name runat='server'/>" 
					value="<apn:value runat='server' tohtml='true'/>" 
					style="<apn:controlattribute runat='server' attr='style'/><apn:cssstyle runat='server'/>" 
					placeholder="<apn:controlattribute runat='server' attr='placeholder'/>"
					class="form-control"
					size="<apn:controlattribute runat='server' attr='size'/>" 
					<apn:metadata runat="server"/>
					<%= Context.Items["readonly"] %>
					<!-- #include file="aria_attributes.inc" -->
					/>
				<span class="input-group-addon">
					<span class="glyphicon glyphicon-calendar"></span>
				</span>
				<apn:ifcontrolattribute runat='server' attr='suffix'><span class="input-group-addon"><apn:controlattribute runat='server' attr='suffix'/></span></apn:ifcontrolattribute>
			</div>
<%		} else {	%>
			<apn:ifcontrolattribute runat='server' attr='prefix or suffix'><div class="input-group"></apn:ifcontrolattribute>
			<apn:ifcontrolattribute runat='server' attr='prefix'><span class="input-group-addon"><apn:controlattribute runat='server' attr='prefix'/></span></apn:ifcontrolattribute>
			<input 
				type="<%=Context.Items["html5type"]%>" 
				name="<apn:name runat='server'/>" 
				id="<apn:name runat='server'/>" 
				value="<apn:value runat='server' tohtml='true'/>" 
				size="<apn:controlattribute runat='server' attr='size'/>" 
				<apn:metadata runat='server'/>
				style="<apn:controlattribute runat='server' attr='style'/><apn:cssstyle runat='server'/>" 
				placeholder="<apn:controlattribute runat='server' attr='placeholder'/>"
				class="form-control" 
				<%= Context.Items["readonly"] %>
				<%= (Context.Items["maxlength"].Equals("") ? "" : "maxlength=" + Context.Items["maxlength"]) %>
				<!-- #include file="aria_attributes.inc" -->
			/>
			<apn:ifcontrolattribute runat='server' attr='suffix'><span class="input-group-addon"><apn:controlattribute runat='server' attr='suffix'/></span></apn:ifcontrolattribute>
			
			<apn:ifcontrolattribute runat='server' attr='prefix or suffix'></div></apn:ifcontrolattribute>
<%		}	
		Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); 
%>
		</div>
<%		
	}
} 
%>
	
</apn:control>

