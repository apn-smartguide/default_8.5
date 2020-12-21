<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat="server">
<tr>
	<td colspan="2" style="<%=Context.Items["groupTitle"]%>">
		<apn:forEach begin="0" end="0" runat="server">
			<apn:value runat="server"/>
		</apn:forEach>
	</td>
</tr>
<apn:forEach begin="1" runat="server">
<apn:choosecontrol runat="server">
	<apn:whencontrol type="RESULT_REPEAT" runat="server">
		<apn:forEach runat="server">
			<apn:control runat="server">
<tr>
	<td style="<%=Context.Items["fieldLabel"]%>">
				<apn:forEach begin="0" end="0" runat="server"><apn:value runat="server"/></apn:forEach>
	</td>
	<td style="<%=Context.Items["fieldValue"]%>">
		<ul>
				<apn:forEach begin="1" runat="server">
					<apn:control runat="server">
			<li><apn:label runat="server"/> : <apn:value runat="server"/></li>
					</apn:control>	
				</apn:forEach>
		</ul>  
	</td>
</tr>	
			</apn:control>	
		</apn:forEach>	
	</apn:whencontrol>
	<apn:otherwise runat="server">
<tr>
	<td style="<%=Context.Items["fieldLabel"]%>">
		<apn:label runat="server"/>
	</td>
	<td style="<%=Context.Items["fieldValue"]%>">
		<apn:value runat="server"/>
	</td>
</tr>
	</apn:otherwise> 
</apn:choosecontrol>
</apn:forEach>
</apn:control>