<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:ForEach runat="server" id="control">
<% Server.Execute(resolvePath("/controls/control.aspx")); %>
</apn:forEach>
