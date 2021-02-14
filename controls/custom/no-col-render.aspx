<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<% Context.Items["no-col"] = true; %>
<div class="row">
<apn:forEach runat="server" id="row">
	<apn:chooseControl runat="server">
		<apn:whenControl runat="server" type="ROW">
			<apn:forEach runat="server" id="col">
				<apn:chooseControl runat="server">
					<apn:whenControl runat="server" type="COL">
						<% Context.Items["no-col-layout"] = col.Current.getLayoutAttribute("all"); %>
						<apn:forEach runat="server" id="field"><% ExecutePath("/controls/control.aspx"); %></apn:forEach>
						<% Context.Items["no-col-layout"] = ""; %>
					</apn:whenControl>
				</apn:chooseControl>
			</apn:ForEach>
		</apn:whenControl>
	</apn:chooseControl>
</apn:ForEach>
</div>
<% Context.Items["no-col"]  = false; %>
<% } %>  						
</apn:control>	

