<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SG.Page" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:forEach runat="server">
		<% Server.Execute(resolvePath("/controls/summary/controls.aspx")); %>
	</apn:forEach>
</apn:control>