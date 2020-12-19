<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server">
	<apn:forEach runat="server">
		<apn:forEach runat="server">
			<% Server.Execute(resolvePath("/pdf/controls.aspx")); %>
		</apn:forEach>
	</apn:forEach>
</apn:control>	

