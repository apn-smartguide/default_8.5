<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../../helpers.aspx" -->
<apn:control runat="server" id="control">
	<apn:ifnotcontrolvalid runat="server">
		<%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
		<a id='error_index_<%=Context.Items["errorIndex"]%>'></a>
	</apn:ifnotcontrolvalid>
	<div class='row sgSummary <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
		<div class='col-sm-6 sgLabel'>
			<span>
				<apn:label runat="server" /></span>
		</div>
		<div class='col-sm-6 sgValue'>
			<apn:forEach runat="server">
				<apn:choosecontrol runat="server">
					<apn:whencontrol type="INPUT" runat="server">
						<apn:value runat="server" tohtml="true" />
					</apn:whencontrol>
					<apn:whencontrol type="SELECT1" runat="server">
						<apn:value runat="server" tohtml="true" />
					</apn:whencontrol>
					<apn:whencontrol type="LABEL" runat="server">
						<apn:label runat="server" />
					</apn:whencontrol>
				</apn:choosecontrol>
			</apn:forEach>
		</div>
	</div>
</apn:control>