<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">
<div class="row <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" id="div_<apn:name runat='server'/>">
    <div class="col-sm-6">
      <span><apn:label runat='server'/></span>
    </div>
    <div class="col-sm-6">
		<apn:ifcontrolattribute 
			runat='server' attr='prefix'><apn:controlattribute 
			runat='server' attr='prefix'/></apn:ifcontrolattribute><apn:value 
			runat='server' tohtml="true"/><apn:ifcontrolattribute 
			runat='server' attr='suffix'><apn:controlattribute 
			runat='server' attr='suffix'/></apn:ifcontrolattribute>&nbsp;
    </div>
</div>
</apn:control>