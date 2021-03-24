<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<h3 id='<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><div class="row"><% ExecutePath("/controls/custom/no-col-render.aspx"); %></div></apn:WhenControl><apn:otherwise runat="server"><%=GetAttribute(control.Current, "label")%><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></h3>
<% } %>
</apn:control>