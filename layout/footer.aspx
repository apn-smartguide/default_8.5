<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<footer>
	<div class="container footer">
		<p class="text-muted"><apn:localize runat="server" key="theme.text.copyright"/></p>
	</div>
</footer>