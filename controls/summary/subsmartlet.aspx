<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:forEach runat="server"><% ExecutePath("/controls/summary/controls.aspx"); %></apn:forEach>
</apn:control>