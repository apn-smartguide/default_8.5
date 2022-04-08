<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a id='error_index_<%=ErrorIndex %>'></a></apn:ifnotcontrolvalid>
	<div class='<apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
		<span><strong><apn:label runat="server" /></strong><br/>
			<apn:forEach runat="server">
				<apn:choosecontrol runat="server">
					<apn:whencontrol type="INPUT" runat="server"><apn:value runat="server" tohtml="true" /></apn:whencontrol>
					<apn:whencontrol type="SELECT1" runat="server"><apn:value runat="server" tohtml="true" /></apn:whencontrol>
					<apn:whencontrol type="LABEL" runat="server"><apn:label runat="server" /></apn:whencontrol>
				</apn:choosecontrol>
			</apn:forEach>
		&nbsp;</span>
	</div>
</apn:control>