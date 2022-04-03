<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% Context.Items["no-col"] = true; %>
<% Context.Items["no-col-layout"] = ""; %>
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else if(IsSummary) { %>
<% ExecutePath("/controls/summary/controls.aspx"); %>
<% } else { %>
<apn:forEach runat="server" id="row">
	<apn:chooseControl runat="server">
		<apn:whenControl runat="server" type="ROW">
			<apn:forEach runat="server" id="col">
				<apn:chooseControl runat="server">
					<apn:whenControl runat="server" type="COL">
						<% if((bool)Context.Items["no-col"]) { Context.Items["no-col-layout"] = col.Current.getLayoutAttribute("all");}  %>
						<apn:forEach runat="server" id="field"><% ExecutePath("/controls/control.aspx"); %></apn:forEach>
						<% Context.Items["no-col-layout"] = ""; %>
					</apn:whenControl>
				</apn:chooseControl>
			</apn:ForEach>
		</apn:whenControl>
	</apn:chooseControl>
</apn:ForEach>
<% } %>  
<% Context.Items["no-col"] = false; %>
</apn:control>