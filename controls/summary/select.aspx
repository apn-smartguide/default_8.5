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
		<div class='col-xs-6'>
			<span>
				<apn:label runat="server" /></span>
		</div>
		<div class='col-xs-6'>
			<apn:forEach id="control2" runat="server">
				<% if (control2.Current.getAttribute("selected").Equals("selected")) { %>
				<apn:label runat="server" /> &nbsp;
				<% } %>
			</apn:forEach> &nbsp;
		</div>
	</div>
</apn:control>