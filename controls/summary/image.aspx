<%@ Page Language="C#" autoeventwireup="true" CodeFile="../..1SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> form-group <apn:cssclass runat="server"/>'
		<img src='<apn:controlattribute attr="src" runat="server"/>' id='<apn:code runat="server"/>' class='<apn:cssclass runat="server"/>' style='width:<apn:controlattribute attr="width" runat="server"/>;height:<apn:controlattribute attr="height" runat="server"/>;<apn:cssstyle runat="server"/>' alt='<apn:controlattribute attr="alt" runat="server"/>' <apn:metadata runat="server" /> title='<apn:controlattribute attr="title" tohtml="true" runat="server" />'/>
		<div class='caption'>
			<% Server.Execute(resolvePath("/controls/label.aspx")); %>
		</div>
	</div>
</apn:control>