<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:forEach runat="server">
		<apn:choosecontrol runat="server">
			<apn:whencontrol type="COL" runat="server"><% ExecutePath("/controls/repeats/col.aspx"); %></apn:whencontrol>
		</apn:choosecontrol>
	</apn:forEach>
</apn:control>	