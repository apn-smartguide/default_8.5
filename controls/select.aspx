<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
	<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
	<% } else { %>
	<%
	Context.Items["layout"] = control.Current.getChoiceLayout();
	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : "";
	if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) { Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " "; } else { Context.Items["no-col-layout"] = ""; } %>
	<apn:choosecontrol runat="server">
		<apn:whencontrol runat="server" type="check">
			<apn:ifnotcontrolvalid runat="server"><% Context.Items["errorIndex"] = (int)Context.Items["errorIndex"] + 1; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a></apn:ifnotcontrolvalid>
			<fieldset id='div_<apn:name runat="server"/>' <%=Context.Items["layout"] %> <%=Context.Items["readonly"]%> <apn:metadata runat="server" /> class='<%=Context.Items["no-col-layout"]%> sg-checkbox chkbxrdio-grp form-group <apn:cssclass runat="server" /><apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
			<% if (!BareRender){ ExecutePath("/controls/legend.aspx"); } %>
			<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong><br/></apn:ifnotcontrolvalid><% } %>
			<% if(!((string)Context.Items["layout"]).Equals("vertically") && !control.Current.getLabel().Equals("")) { %><br/><% } %>
			<apn:forEach id="control2" runat="server">
				<% if(((string)Context.Items["readonly"]).Length == 0) { %><input type='hidden' name='<apn:name runat="server"/>' value='' /><% } %>
				<apn:choosecontrol runat="server">
					<apn:whencontrol runat="server" type="optgroup">
						<label class='optgroup'><% ExecutePath("/controls/custom/control-label.aspx"); %></label>
						<apn:forEach id="control3" runat="server">
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							<div <%= Context.Items["layout"] %>>
								<% if(!control3.Current.getLabel().Equals("")) { %><label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' title='<%=GetAttribute(control3.Current, "title", true)%>'><% } %>
							<% } else { %>
								<% if(!control3.Current.getLabel().Equals("")) { %><label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' class='checkbox-inline' title='<%=GetAttribute(control3.Current, "title", true)%>'><% } %>
							<% } %>
								<input type='checkbox' name='<%= control3.Current.getName() %>' id='<%= control3.Current.getAttribute("id")%><%= Context.Items["optionIndex"]%>' value='<%= control3.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <% if(!control3.Current.getLabel().Equals("")) { %>aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>'<% } %> <%= control.Current.containsValue(control3.Current.getValue()) ? " checked='checked'" : "" %> <%= Context.Items["layout"] %> /><% ExecutePath("/controls/custom/control-label.aspx"); %>
								<% if(!control3.Current.getLabel().Equals("")) { %></label><% } %>
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %></div><% } %>
						</apn:forEach>
					</apn:whencontrol>
					<apn:otherwise runat="server">
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
						<div <%= Context.Items["layout"] %>>
							<% if(!control2.Current.getLabel().Equals("")) { %><label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' title='<%=GetAttribute(control2.Current, "title", true)%>'><% } %>
						<% } else { %>
							<% if(!control2.Current.getLabel().Equals("")) { %><label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' class='checkbox-inline' title='<%=GetAttribute(control2.Current, "title", true)%>'><% } %>
						<% } %>
							<input type='checkbox' name='<%= control2.Current.getName() %>' id='<%= control2.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>' <% if(!control2.Current.getLabel().Equals("")) { %> aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%= Context.Items["optionIndex"]%>'<% } %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %>  value='<%= control2.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <%= control.Current.containsValue(control2.Current.getValue()) ? " checked='checked'" : "" %> <%= Context.Items["layout"] %> /><% ExecutePath("/controls/custom/control-label.aspx"); %>
							<% if(!control2.Current.getLabel().Equals("")) { %></label><% } %>
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %></div><% } %>
					</apn:otherwise>
				</apn:choosecontrol>
			</apn:forEach>
			<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><br/><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</fieldset>
		</apn:whencontrol>
		<apn:whencontrol runat="server" type="lbox">
			<apn:ifnotcontrolvalid runat="server"><% Context.Items["errorIndex"] = (int)Context.Items["errorIndex"] + 1;%><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a></apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' <%=Context.Items["layout"]%> class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> form-group <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
				<% if (!BareRender){ %><% ExecutePath("/controls/label.aspx"); %><% } %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
				<% if (IsPdf) { %><p><%=control.Current.getSelectedLabel()%></p>
				<% } else { %>
				<select name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' <apn:metadata runat="server" /> class='<apn:cssclass runat="server" /> form-control' <%=Context.Items["readonly"]%> style='<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>' multiple size='<%= control.Current.getAttribute("size") %>' <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" -->>
				<apn:forEach runat="server" id="control6">
					<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup"><optgroup label='<apn:label runat="server" />' title='<%=GetAttribute(control3.Current, "title", true)%>'><apn:forEach runat="server" id="control7"><option <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> value='<%= control7.Current.getHTMLValue() %>' title='<%= control7.Current.getAttribute("title") %>' <%= control.Current.containsValue(control7.Current.getValue()) ? "selected='selected'" : "" %>><apn:label runat="server" /></option></apn:forEach></optgroup></apn:whencontrol>
						<apn:otherwise runat="server"><option <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> value='<%= control6.Current.getHTMLValue() %>' title='<%= control6.Current.getAttribute("title") %>' <%= control.Current.containsValue(control6.Current.getValue()) ? "selected='selected'" : "" %>><apn:label runat="server" /></option></apn:otherwise>
					</apn:choosecontrol>
				</apn:forEach>
				</select>
				<% } %>
				<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</div>
		</apn:whencontrol>
	</apn:choosecontrol>
	<% } %>
</apn:control>