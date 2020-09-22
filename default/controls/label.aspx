<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<% 	bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
	if (!bareControl){
%>
    
    <apn:control runat="server" id="control">
  	<label id="lbl_<apn:name runat='server'/>" for="<apn:name runat='server'/>" title="<apn:controlattribute attr='title' tohtml='true' runat='server'/>" class="control-label">

		<span>
			<apn:label runat='server'/>
		</span>
	<apn:ifcontrolrequired runat='server'>
		<span class="required">*</span>
	</apn:ifcontrolrequired>
	<!-- tooltip comes here -->
	<apn:ifcontrolattribute attr='title' runat='server'>
		<span data-toggle="tooltip" data-placement="right" class="glyphicon glyphicon-question-sign" title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
	</apn:ifcontrolattribute>
	</label>
</apn:control>
<%}%>
