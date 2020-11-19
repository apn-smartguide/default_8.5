<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<footer class="footer">
	<div class="container">
		<p class="text-muted"><apn:localize runat="server" key="theme.text.copyright"/></p>
	</div>
</footer>
<% Server.Execute(resolvePath("/layout/footer-scripts.aspx")); %>
<div id="loader" style="display: none;"> </div>
<script>
  <%=Context.Items["javascript"]%>
</script>