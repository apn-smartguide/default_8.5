<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SGPage" Trace="false"%>
<apn:control runat="server" id="control">
<div class="row">
  	<apn:forEach runat="server">											
  		<apn:choosecontrol runat="server">
			<apn:whencontrol type="COL" runat="server">
  				<% Server.Execute(resolvePath("/controls/col.aspx")); %>
  			</apn:whencontrol>
  		</apn:choosecontrol>
  	</apn:forEach>
</div>
</apn:control>	