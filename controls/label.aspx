<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<% bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
<% if (!bareControl){ %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
	<%-- should be contained within a <div class="form-group"> --%>
	<label for='<apn:name runat="server"/>' class='<apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired>'>
		<span class="field-name"><apn:label runat="server" /></span>
		<apn:ifcontrolattribute attr="title" runat="server"><%-- tooltip --%>
		<span data-toggle='tooltip' data-placement='right' class='<apn:localize runat="server" key="theme.icon.question"/>' title='<apn:controlattribute runat="server" tohtml="true" attr="title"/>'></span>
		</apn:ifcontrolattribute>
		<% Server.Execute(resolvePath("/controls/tts.aspx")); %>
		<apn:ifnotcontrolvalid runat="server">
			<apn:ifcontrolrequired runat="server"><strong class='required'><%=sg5.Context.getSmartlet().getLocalizedResource("theme.text.required")%></strong></apn:ifcontrolrequired>
			<strong id='<apn:name runat="server"/>-error' class='error'>
				<span class="label label-danger">
					<span class="prefix"><%=sg5.Context.getSmartlet().getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %>
				</span>
			</strong>
		</apn:ifnotcontrolvalid>
	</label>
</apn:control>
<% } %>
