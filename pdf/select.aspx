<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<% 
	Context.Items["prefixSelected"] = "";
	Context.Items["prefixNotSelected"] = "";
%>
<apn:control runat="server" id="control">
<apn:choosecontrol runat="server">
	<apn:whencontrol type="radio" runat="server" >
		<% Context.Items["prefixSelected"] = "&#x25CF;"; Context.Items["prefixNotSelected"] ="&#x274D;"; %>
	</apn:whencontrol>
	<apn:whencontrol type="drop" runat="server">
		<% Context.Items["prefixSelected"] = "&#x25CF;"; Context.Items["prefixNotSelected"] ="&#x274D;"; %>
	</apn:whencontrol>
	<apn:whencontrol type="check" runat="server">
		<% Context.Items["prefixSelected"] = "&#2714;"; Context.Items["prefixNotSelected"] ="&#274F;"; %>
	</apn:whencontrol>
	<apn:whencontrol type="lbox" runat="server">
		<% Context.Items["prefixSelected"] = "&#2714;"; Context.Items["prefixNotSelected"] ="&#274F;"; %>
	</apn:whencontrol>
</apn:choosecontrol>
<tr><td colspan="12">
	<table width="100%">
		<tr><td style="<%=Context.Items["fieldLabel"]%>">
			<apn:label runat="server"/>
		</td></tr>
		<tr><td> 
			<apn:forEach id="control2" runat="server">
				<% if (control2.Current.getAttribute("selected").Equals("selected")) { %>
					<span style="font-family:ZapfDingbats"><%=Context.Items["prefixSelected"]%> </span> <apn:label runat="server"/> &nbsp;
				<% } else { %>
					<span style="font-family:ZapfDingbats"><%=Context.Items["prefixNotSelected"]%> </span> <apn:label runat="server"/> &nbsp;
				<% } %>
				<%if ("vertically".Equals(control.Current.getChoiceLayout())) { %><br/><%	}	%>
			</apn:forEach>
		&nbsp;
		</td></tr>
	</table>
</td></tr>
</apn:control>

