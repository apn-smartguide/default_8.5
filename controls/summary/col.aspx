<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control"><% if(!control.Current.getAttribute("style").Equals("visibility:hidden;")) { %><div class='<apn:controllayoutattribute runat="server" attr="all"/>'><% Execute("/controls/summary/controls.aspx"); %></div><% } else { %><% Execute("/controls/summary/controls.aspx"); %><% } %></apn:control>