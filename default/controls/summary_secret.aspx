<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">

  <div class="row <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" id="div_<apn:name runat='server'/>">
    <div class="col-sm-6">
      <span><apn:label runat='server'/></span>
    </div>
    <div class="col-sm-6">
      <% if ((!control.Current.getValue().Equals(""))  && (control.Current.getValue() != null)) { %>	*******		<% } %> &nbsp;
    </div>
	</div>

</apn:control>

