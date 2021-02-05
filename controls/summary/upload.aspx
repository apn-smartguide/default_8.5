<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifnotcontrolvalid runat="server">
		<%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
		<a id='error_index_<%=Context.Items["errorIndex"]%>'></a>
	</apn:ifnotcontrolvalid>
	<div class='row sgSummary <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
		<div class='col-xs-6 sgLabel'>
			<span>
				<apn:label runat="server" /></span>
		</div>
		<div class='col-xs-6 sgValue'>
			<% if(control.Current.getAttribute("value").Trim().Length > 0) { %>
				<a target= '_blank' href='upload/do.aspx/<apn:value runat="server"/>?id=<apn:name runat="server"/>&interviewID=<apn:control runat="server" type="interview-code"><apn:value runat="server"/></apn:control>'> <apn:value runat="server"/></a> 
			<% } %>
		</div>
	</div>
</apn:control>