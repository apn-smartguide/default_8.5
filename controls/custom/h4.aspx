<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SGPage" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else { %>
<h4 id='<apn:name runat="server"/>' class='<apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' <apn:metadata runat="server" match="role"/>><apn:ChooseControl runat="server"><apn:WhenControl runat="server" type="GROUP"><% Server.Execute(resolvePath("/controls/custom/no-col-render.aspx")); %></apn:WhenControl><apn:otherwise runat="server"><apn:label runat="server"/><apn:value runat="server"/></apn:otherwise></apn:ChooseControl></h4>
<% } %>  						
</apn:control>	

