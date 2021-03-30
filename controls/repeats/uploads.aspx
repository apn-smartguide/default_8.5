<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<% Context.Items["hiddenName"] = ""; Context.Items["isOnlyStatic"] = true ; %>
<apn:control runat="server" id="control">
	<div class='group <%=control.Current.getCSSClass()%>' style='<%=control.Current.getCSSStyle()%>' id='div_<apn:name runat="server"/>' >
		<h2><apn:label runat="server"/></h2>
		<apn:control runat="server" type="repeat-index" id="repeatIndex">
			<input name='<apn:name runat="server"/>' type='hidden' value='' />
			<% Context.Items["hiddenName"] = repeatIndex.Current.getName(); %>
		</apn:control>
		<% if (!control.Current.getAttribute("title").Equals("")) { %><div class="groupHelp"><apn:controlattribute runat="server" attr='title'/></div><% } %>
		<table class='<%=control.Current.getCSSClass()%>'>
		<apn:control runat="server" type="default-instance" id="defaultGroup">
			<thead>
				<th>Files</th>
				<td></td>
			</thead>
		</apn:control>
		<apn:forEach runat="server" id="status">
			<tbody>
				<tr bgcolor="#ffffff">
					<% BareRender = true; ExecutePath("/controls/repeats/table-col.aspx"); BareRender = false; %>
					<!-- <td align="center">
					<apn:control runat="server" type="delete" id="button">
						<button data-eventtarget='["<%=control.Current.getName()%>"]' class='repeat_delbtn <%= Context.Items["hiddenName"] %>_<%= status.getCount()%>' id='<apn:name/>_<%= status.getCount()%>'>Delete</button>
					</apn:control>
					</td> -->
				</tr>
			</tbody>
		</apn:forEach>
		</table>
	</div>
</apn:control>
