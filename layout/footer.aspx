<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<footer class="footer">
	<div class="container">
		<p class="text-muted"><apn:localize runat="server" key="theme.text.copyright"/></p>
	</div>
</footer>
<% Server.Execute(resolvePath("/layout/footer-scripts.aspx")); %>