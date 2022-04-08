<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
	<% IsSummary = true; %>
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="../hidden.inc" -->
	<% } else { %>
	<div class='<apn:cssclass runat="server"/> recap' style='<apn:controlattribute attr="style" runat="server"/><apn:cssstyle runat="server"/>'>
		<apn:forEach runat="server" id="pageControl">
			<div class='card'>
				<div class='card-header'>
					<h2 class='card-title'>
						<apn:label runat="server" />
						<div class='float-right summaryBtn'><% if (!IsPdf && !pageControl.Current.getCSSClass().Contains("hide-modify-btn")) { %><apn:control runat="server" type="modify" id="button"><input type='submit' class='btn btn-xs btn-secondary' name='<apn:name runat="server"/>' value='<%=GetAttribute(button.Current, "label")%>' /></apn:control><% } %></div>
					</h2>
				</div>
				<div class='card-body'><% ExecutePath("/controls/summary/controls.aspx"); %></div>
			</div>
		</apn:forEach>
	</div>
	<% } %>
	<% IsSummary = false; %>
</apn:control>