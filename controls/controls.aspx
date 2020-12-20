<%@ Page Language="C#" autoeventwireup="true" CodeFile="../helpers.cs" Inherits="SG.Page" Trace="false"%>
<apn:ForEach runat="server" id="control">
<% Server.Execute(resolvePath("/controls/control.aspx")); %>
</apn:forEach>
