<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:forEach runat="server"><% Execute("/controls/summary/control.aspx"); %></apn:forEach>