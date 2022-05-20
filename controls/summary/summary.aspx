<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% 
	IsSummary = true;
	if (!IsAvailable(control.Current)) {
		Execute("/controls/hidden.aspx");
	} else {
	%>
	<div class='<apn:cssclass runat="server"/> recap' style='<apn:controlattribute attr="style" runat="server"/><apn:cssstyle runat="server"/>'>
		<apn:forEach runat="server" id="pageControl">
			<div class='<%=Class("group-container")%>'>
				<div class='<%=Class("group-header")%>'>
					<h2 class='<%=Class("group-title")%>'>
						<apn:label runat="server" />
					</h2>
					<%-- if (!IsPdf && !pageControl.Current.getCSSClass().Contains("hide-modify-btn")) { --%>
					<div class='<%=Class("right")%> summaryBtn'>
						<apn:control runat="server" type="modify" id="button"><input type='submit' class='btn btn-xs <%=Class("btn-secondary")%>' name='<apn:name runat="server"/>' value='<%=GetAttribute(button.Current, "label")%>' /></apn:control>
					</div>
					<%-- } --%>
				</div>
				<div class='<%=Class("group-body")%>'><% Execute("/controls/summary/controls.aspx"); %></div>
			</div>
		</apn:forEach>
	</div>
	<%
	}
	IsSummary = false;
	%>
</apn:control>