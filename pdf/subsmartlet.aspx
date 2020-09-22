<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server">
	<apn:forEach runat="server">
		<apn:forEach runat="server">
			<% Server.Execute(resolvePath("/pdf/controls.aspx")); %>
		</apn:forEach>
	</apn:forEach>
</apn:control>	

