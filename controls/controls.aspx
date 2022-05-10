<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:ForEach runat="server" id="control"><% Execute("/controls/control.aspx"); %></apn:forEach>
