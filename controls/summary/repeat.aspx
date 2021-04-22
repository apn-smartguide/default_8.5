<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:forEach id="control2" runat="server">
	<% if (control2.Current.getType() == com.alphinat.xmlengine.interview.tag.ControlInfo.GROUP) { %>
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a id='error_index_<%=ErrorIndex %>' /></apn:ifnotcontrolvalid>
	<div class='<apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'><% if(!control2.Current.getLabel().Equals("")) { %><h4><apn:label runat="server" /><% if (!(control2.getCount() == 1 && control2.Last)) { %><%= control2.getCount() %><% } %></h4><% } %></div>
	<% ExecutePath("/controls/summary/controls.aspx"); %>
	<% } %>
</apn:forEach>