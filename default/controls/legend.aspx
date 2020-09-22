<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<% 	bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
	if (!bareControl){
%>
        
<apn:control runat="server" id="control">
    <legend <%=("".Equals(control.Current.getLabel())? "class=\"emptyLegend\"" : "")%> >
            <label>
                <apn:label runat="server"/> &nbsp;
            </label>
        <apn:ifcontrolrequired runat="server">
            <span class="required">*</span>
        </apn:ifcontrolrequired>
		<apn:ifcontrolattribute runat="server" attr='title'>
			<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat="server" tohtml='true' attr='title'/>"></span>
		</apn:ifcontrolattribute>
    </legend>
</apn:control>
<% } %>
