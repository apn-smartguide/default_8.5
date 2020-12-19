<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SGPage" Trace="false"%>
<apn:control runat="server" id="control">
<% Context.Items["javascript"] += control.Current.getValue() + ";"; %>
</apn:control>