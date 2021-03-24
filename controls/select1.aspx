<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<% } else { %>
<%
	Context.Items["layout"] = control.Current.getChoiceLayout();
	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : "";
	if(Context.Items["no-col"] != null && (bool)Context.Items["no-col"] == true ) {
		Context.Items["no-col-layout"] = (string)Context.Items["no-col-layout"] + " ";
	} else {
		Context.Items["no-col-layout"] = "";
	}
%>
	<apn:choosecontrol runat="server" >
		<apn:whencontrol runat="server" type="radio">
			<apn:ifnotcontrolvalid runat="server"><% Context.Items["errorIndex"] = (int) Context.Items["errorIndex"] + 1; %><a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a></apn:ifnotcontrolvalid>
			<fieldset  id='div_<apn:name runat="server" />' <%=Context.Items["layout"] %> style='<apn:cssstyle runat="server"/>' class='<%=Context.Items["no-col-layout"]%> chkbxrdio-grp form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server" >has-error</apn:ifnotcontrolvalid>' <apn:metadata runat="server"/> <%=Context.Items["readonly"]%> <!-- #include file="aria-live.inc" --> >
				<% if (!BareRender){ ExecutePath("/controls/legend.aspx"); } %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong><br/></apn:ifnotcontrolvalid><% } %>
				<% if(!((string)Context.Items["layout"]).Equals("vertically") && !control.Current.getLabel().Equals("")) { %><br/><% } %>
				<% Context.Items["counter"] = 1; %>
				<apn:forEach runat="server" id="control5" >
					<apn:choosecontrol runat="server">
					<apn:whencontrol runat="server" type="optgroup">
						<label class='optgroup'><% ExecutePath("/controls/custom/control-label.aspx"); %></label>
						<apn:forEach runat="server" id="control6">
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
								<div <%= Context.Items["readonly"] %>>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' title='<%=GetAttribute(control6.Current, "title", true)%>'>
							<% } else { %>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' class='radio-inline' title='<%=GetAttribute(control6.Current, "title", true)%>'>
							<% } %>
									<input type='radio' name='<%= control6.Current.getName() %>' id='<%=control6.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>' class='deselect-off' value='<%= control6.Current.getHTMLValue() %>' <apn:metadata runat="server"/> <%= control.Current.containsValue(control6.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'/><span><% ExecutePath("/controls/custom/control-label.aspx"); %></span>
									</label>
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %></div><% } %>
						</apn:forEach>
					</apn:whencontrol>
					<apn:otherwise runat="server">
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							<div <%= Context.Items["readonly"] %>>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' title='<%=GetAttribute(control5.Current, "title", true)%>'>
						<% } else { %>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' class='radio-inline' title='<%=GetAttribute(control5.Current, "title", true)%>'>
						<% } %>
								<input type='radio' name='<%= control5.Current.getName() %>' id='<%=control5.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>' class='deselect-off' value='<%= control5.Current.getHTMLValue() %>' <apn:metadata runat="server"/> <%= control.Current.containsValue(control5.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'/><% ExecutePath("/controls/custom/control-label.aspx"); %>
								</label>
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %></div><% } %>
					</apn:otherwise>
					</apn:choosecontrol>
					<% Context.Items["counter"] = (int)Context.Items["counter"] + 1; %>
				</apn:forEach>
				<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><br/><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</fieldset>
		</apn:whencontrol>
		<apn:whencontrol runat="server" type="drop" >
			<apn:ifnotcontrolvalid runat="server"><% Context.Items["errorIndex"] = (int)Context.Items["errorIndex"] + 1; %><a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a></apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> form-group has-feedback has-search <apn:ifnotcontrolvalid runat="server" > has-error</apn:ifnotcontrolvalid>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> <%=Context.Items["readonly"]%><!-- #include file="aria-live.inc" --> >
				<% ExecutePath("/controls/label.aspx"); %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", Context.Items["errorIndex"].ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
				<% if (IsPdf) { %><p><%=control.Current.getSelectedLabel()%></p>
				<% } else if (control.Current.getCSSClass().IndexOf("autocomplete") > -1) { %>
				<input name='<apn:name runat="server"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' type="hidden" value="<%=control.Current.getValue()%>"/>
				<input type='text' id='<%= control.Current.getName() %>' name='<%= "autocomplete_"+control.Current.getName() %>' <%=Context.Items["readonly"]%> value='<%=control.Current.getSelectedLabel()%>' <apn:metadata runat="server"/> class='<apn:cssclass runat="server"/> form-control' aria-labelledby='lbl_<apn:name runat="server"/>'/>
				<datalist id='<%= control.Current.getName() %>_list'>
					<apn:forEach runat="server" id="control7" >
						<apn:choosecontrol runat="server">
							<apn:whencontrol type="optgroup" runat="server"></apn:whencontrol>
							<apn:otherwise runat="server"><option value='<%= control7.Current.getHTMLValue() %>' ><%=GetAttribute(control7.Current, "label")%></option></apn:otherwise>
						</apn:choosecontrol>
					</apn:forEach>
				</datalist>
				<%--<span class="combo-dropdown glyphicon glyphicon-chevron-down form-control-feedback"></span>--%>
				<% } else { %>
				<select name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' class='<apn:cssclass runat="server"/> form-control input-sm' aria-labelledby='lbl_<apn:name runat="server"/>' style='<%= (control.Current.getAttribute("style") + " " + control.Current.getCSSStyle()) %>' size='1' <apn:metadata runat="server"/><%=Context.Items["readonly"]%> >
					<apn:forEach runat="server" id="control4" >
						<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup" ><optgroup label='<%=GetAttribute(control4.Current, "label")%>' title='<%=GetAttribute(control4.Current, "title", true)%>'><apn:forEach runat="server" id="control2" ><option value='<%= control2.Current.getHTMLValue() %>' title='<%= control2.Current.getAttribute("title") %>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %><%= control.Current.containsValue(control2.Current.getValue()) ? " selected='selected'" : "" %> > <%=GetAttribute(control2.Current, "label")%></option></apn:forEach></optgroup></apn:whencontrol>
						<apn:otherwise ><option value='<%= control4.Current.getHTMLValue() %>' title='<%= control4.Current.getAttribute("title") %>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %><%= control.Current.containsValue(control4.Current.getValue()) ? " selected='selected'" : "" %> ><%=GetAttribute(control4.Current, "label")%></option></apn:otherwise>
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