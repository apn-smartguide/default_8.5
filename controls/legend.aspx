<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<% bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
<% if (!bareControl){ %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<% if (!control.Current.getCSSClass().Contains("hide-label")) { %>
	<%-- should be contained within a <div class="form-group"> --%>
	<legend class='<apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <%= ( "".Equals(control.Current.getLabel()) ? "emptyLegend":"") %>'>
		<span class="field-name" <apn:ifcontrolattribute attr="title" runat="server">data-toggle='tooltip' data-placement='right' title='<apn:controlattribute runat="server" tohtml="true" attr="title"/>'</apn:ifcontrolattribute>><apn:label runat="server" />
		<apn:ifcontrolattribute attr="title" runat="server">
		<span  class='glyphicon glyphicon-question-sign'></span>
		</apn:ifcontrolattribute>
		</span>
        <% Server.Execute(resolvePath("/controls/tts.aspx")); %>
		<apn:ifnotcontrolvalid runat="server">
			<apn:ifcontrolrequired runat="server"><strong class='required'><%=sg5.Context.getSmartlet().getLocalizedResource("theme.text.required")%></strong></apn:ifcontrolrequired>
			<strong id='<apn:name runat="server"/>-error' class='error'>
				<span class="label label-danger">
					<span class="prefix"><%=sg5.Context.getSmartlet().getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %>
				</span>
			</strong>
		</apn:ifnotcontrolvalid>
	</legend>
	<% } %>	
</apn:control>
<% } %>
