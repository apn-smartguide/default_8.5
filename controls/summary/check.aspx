<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a id='error_index_<%=ErrorIndex%>'></a></apn:ifnotcontrolvalid>
	<div class='<apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
	<span><strong><apn:label runat="server" /></strong><br/>
		<apn:forEach id="control2" runat="server"><% if(control.Current.containsValue(control2.Current.getValue())) { %><%= control2.Current.getLabel() %><% } %></apn:forEach>
	&nbsp;</span>
	</div>
</apn:control>