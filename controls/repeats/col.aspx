<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<apn:ForEach id="field" runat="server">
		<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;") && !field.Current.getAttribute("visible").Equals("false") && !field.Current.getCSSClass().Contains("hide-from-list-view") && !field.Current.getCSSClass().Contains("proxy")) { %>
		<apn:ChooseControl runat="server">
			<apn:whencontrol runat="server" type="SUMMARY-SECTION"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/summary/summary.aspx"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="ROW">
				<apn:control runat="server">
					<apn:forEach runat="server">
						<apn:choosecontrol runat="server">
							<apn:whencontrol runat="server" type="COL">
								<% ExecutePath("/controls/repeats/col.aspx?bare_control=true"); %>
							</apn:whencontrol>
						</apn:choosecontrol>
					</apn:forEach>
				</apn:control>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="GROUP"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/group.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="REPEAT"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/repeats/repeat.aspx"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="INPUT">
				<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
				<td class='<%=control.Current.getLayoutAttribute("all")%>'>
				<% } %>
					<% ExecutePath("/controls/input.aspx?bare_control=true"); %>
				<% if(!field.Current.getAttribute("style").Equals("visibility:hidden;")) {%>
				</td>
				<% } %>
			</apn:whencontrol>
			<apn:whencontrol runat="server" type="TEXTAREA"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/textarea.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="SECRET"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/secret.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="DATE"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/date.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/select.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="SELECT1"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/select1.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="STATICTEXT"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/statictext.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="IMAGE"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/image.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="UPLOAD"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/upload.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="TRIGGER"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/button.aspx"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="SUB-SMARTLET"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/subsmartlet.aspx?bare_control=true"); %></td></apn:whencontrol>
			<apn:whencontrol runat="server" type="RESULT"><td class='<%=control.Current.getLayoutAttribute("all")%>'><% ExecutePath("/controls/result.aspx"); %></td></apn:whencontrol>
		</apn:choosecontrol>
		<% } %>
	</apn:forEach>
</apn:control>