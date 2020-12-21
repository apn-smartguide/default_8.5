<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<footer class="footer">
	<div class="container">
		<p class="text-muted"><apn:localize runat="server" key="theme.text.copyright"/></p>
	</div>
</footer>
<% Server.Execute(resolvePath("/layout/footer-scripts.aspx")); %>