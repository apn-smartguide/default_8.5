<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<label for="date">Choose a date</label>
<duet-date-picker id='<apn:name runat="server"/>' identifier="date"></duet-date-picker>
<% } %>
</apn:control>