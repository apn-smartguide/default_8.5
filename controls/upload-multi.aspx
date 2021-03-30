<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (!BareRender) { %>
<div class='<apn:cssclass runat="server"/>' id='div_<apn:name runat="server"/>' >
	<% ExecutePath("/controls/label.aspx"); %>
	<input type='file' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' multiple title='A' style='color:transparent;' onchange='submit();' />
</div>
<% } else { %>
<div class='<apn:cssclass runat="server"/>' id='div_<apn:name runat="server"/>' >
	<a target='_blank' href='upload/do.aspx/<apn:value runat="server"/>?id=<apn:name runat="server"/>&interviewID=<apn:control runat="server" type="interview-code"><apn:value runat="server"/></apn:control>' title='<apn:localize runat="server" key="theme.text.upload"/>' aria-label='<apn:localize runat="server" key="theme.text.upload"/>'><apn:value runat="server"/></a>
</div>
<% } %>
</apn:control>

