<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifnotcontrolvalid runat="server">
		<%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
		<a id='error_index_<%=Context.Items["errorIndex"]%>'></a>
	</apn:ifnotcontrolvalid>
	<div class='row <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
		<div class='col-xs-6'><span><strong><apn:label runat="server" /></strong></span></div>
		<div class='col-xs-6'><apn:forEach id="control2" runat="server"><% if(control.Current.containsValue(control2.Current.getValue())) { %><%= control2.Current.getLabel() %><% } %></apn:forEach></div>
	</div>
</apn:control>