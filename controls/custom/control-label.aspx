<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
	Context.Items["hide-option-label"] = Context.Items["hide-option-label"] != null && (bool)Context.Items["hide-option-label"] == true;
	Context.Items["hide-label"] = control.Current.getCSSClass().Contains("hide-label") || (bool)Context.Items["hide-option-label"];
	Context.Items["label"] = control.Current.getLabel();
	Context.Items["label-suffix"] = GetMetaDataValue(control.Current, "label-suffix");
	hideSuffix = GetMetaDataValue(control.Current, "label-suffix").IndexOf("hide-summary") != -1 && (IsPdf || IsSummary);
	if (!hideSuffix) Context.Items["label"] += " " + Context.Items["label-suffix"];
	Context.Items["label"] = ((string)Context.Items["label"]).Trim();
	if (Context.Items["tts-id"] == null) Context.Items["tts-id"] = "";
	if (Context.Items["tts-id"].Equals("") && !control.Current.getFieldId().Equals("")) {
		Context.Items["tts-id"] = control.Current.getFieldId() + "_label";
	}
	if (!Context.Items["label"].Equals("")) {
%>
	<apn:ifnotcontrolattribute attr="tooltip" runat="server">
		<apn:ifnotcontrolvalid runat="server">
			<span <% if (Options.Contains("TTS") && !Context.Items["tts-id"].Equals("")) { Response.Output.Write("data-tts='{0}'",Context.Items["tts-id"]); } %> class="error"><span class='field-name <%if((bool)Context.Items["hide-label"]) { %>sr-only<% } %>'><%=Context.Items["label"]%></span></span>
		</apn:ifnotcontrolvalid>
		<apn:ifcontrolvalid runat="server">
			<span <% if (Options.Contains("TTS") && !Context.Items["tts-id"].Equals("")) { Response.Output.Write("data-tts='{0}'",Context.Items["tts-id"]); } %> class='field-name <%if((bool)Context.Items["hide-label"]) { %>sr-only<% } %>'><%=Context.Items["label"]%></span>
		</apn:ifcontrolvalid>
	</apn:ifnotcontrolattribute>
	<apn:ifcontrolattribute attr="tooltip" runat="server">
		<apn:ifnotcontrolvalid runat="server">
			<span <% if (Options.Contains("TTS") && !Context.Items["tts-id"].Equals("")) { Response.Output.Write("data-tts='{0}'",Context.Items["tts-id"]); } %> class="error"><span class='field-name <%if((bool)Context.Items["hide-label"]) { %>sr-only<% } %>' data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<%=GetTooltip(control.Current)%>'><%=Context.Items["label"]%></span></span>
		</apn:ifnotcontrolvalid>
		<apn:ifcontrolvalid runat="server">
			<span <% if (Options.Contains("TTS") && !Context.Items["tts-id"].Equals("")) { Response.Output.Write("data-tts='{0}'",Context.Items["tts-id"]); } %> class='field-name <%if((bool)Context.Items["hide-label"]) { %>sr-only<% } %>' data-toggle='tooltip' data-placement='auto' data-container='body' data-html='true' title='<%=GetTooltip(control.Current)%>'><%=Context.Items["label"]%></span>
		</apn:ifcontrolvalid>
	</apn:ifcontrolattribute>
	<% if (Options.Contains("TTS") && !Context.Items["tts-id"].Equals("")) { %><span id='<% Response.Output.Write("tts_{0}",Context.Items["tts-id"]); %>' style='display:none;' class='tts-icon <apn:localize runat="server" key="theme.icon.play"/>'></span><% } %>
	<%
	}
	Execute("/controls/help.aspx");
	Context.Items["tts-id"] = "";
	Context.Items["label"] = "";
	Context.Items["label-suffix"] = "";
%>
</apn:control>