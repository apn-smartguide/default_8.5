<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if((bool)Context.Items["pdf"] && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<% Context.Items["no-col"] = true; %>
<apn:forEach runat="server" id="row">
	<apn:chooseControl runat="server">
		<apn:whenControl runat="server" type="ROW">
			<apn:forEach runat="server" id="col">
				<apn:chooseControl runat="server">
					<apn:whenControl runat="server" type="COL">
						<apn:forEach runat="server" id="field"><% Server.Execute(resolvePath("/controls/control.aspx")); %></apn:forEach>
					</apn:whenControl>
				</apn:chooseControl>
			</apn:ForEach>
		</apn:whenControl>
	</apn:chooseControl>
</apn:ForEach>
<% Context.Items["no-col"]  = false; %>
<% } %>  						
</apn:control>	

