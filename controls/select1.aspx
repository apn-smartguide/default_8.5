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
		<div id='div_<apn:name runat="server" />' class="chkbxrdio-grp form-group">
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<% if (!BareRender){ ExecutePath("/controls/legend.aspx"); } %>
			<% Context.Items["label"] = control.Current.getLabel(); %>
			<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong><br/></apn:ifnotcontrolvalid><% } %>
			<ul <%=Context.Items["readonly"]%> <apn:metadata runat="server" /> class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server" >has-error</apn:ifnotcontrolvalid>' style='<apn:cssstyle runat="server"/>' <!-- #include file="aria-live.inc" --> >
				<% Context.Items["index"] = 1; %>
				<apn:forEach runat="server" id="control5" >
					<li>
						<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup">
							<label class='optgroup'><% ExecutePath("/controls/custom/control-label.aspx"); %></label>
							<apn:forEach runat="server" id="control6">
								<% if (control.Current.getCSSClass().Contains("inline")) { %><div class="radio-inline"><% } %>
								<% Context.Items["id"] = control6.Current.getAttribute("id") + "_" + Context.Items["optionIndex"] + "_" + Context.Items["index"]; %>
								<% if (!control6.Current.getLabel().Equals("")) { Context.Items["aria-labelledby"] = "lbl_" + Context.Items["id"]; } %>
								<% string c6label = control6.Current.getLabel(); %>
								<% if (c6label.Equals("")) c6label = (string)Context.Items["label"]; %>
								<input type='radio' name='<%= control6.Current.getName() %>' id='<%=Context.Items["id"]%>' title='<%=c6label%>' class='deselect-off <%=control.Current.getCSSClass()%> form-check-input' value='<%= control6.Current.getHTMLValue() %>' <% if (control.Current.isRequired()) {%> required <%}%> <apn:metadata runat="server"/> <%= control.Current.containsValue(control6.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> 
								<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> aria-labelledby='<%=Context.Items["aria-labelledby"]%>'/>
								<% if(!control6.Current.getLabel().Equals("")) { %><label class="form-check-label" id='<%=Context.Items["aria-labelledby"]%>' for='<%=Context.Items["id"]%>' title='<%=GetAttribute(control6.Current, "title", true)%>'><% ExecutePath("/controls/custom/control-label.aspx"); %></label><% } %>
								<% if (control.Current.getLabel().Equals("") && control.Current.isRequired()) { %><span class="required" data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span><% } %>
								<% if (control.Current.getCSSClass().Contains("inline")) { %></div><% } %>
							</apn:forEach>
						</apn:whencontrol>
						<apn:otherwise runat="server">
							<% if (control.Current.getCSSClass().Contains("inline")) { %><div class="radio-inline"><% } %>
							<% Context.Items["id"] = control5.Current.getAttribute("id") + "_" + Context.Items["optionIndex"] + "_" + Context.Items["index"]; %>
							<% if (!control5.Current.getLabel().Equals("")) { Context.Items["aria-labelledby"] = "lbl_" + Context.Items["id"]; } %>
							<% string c5label = control5.Current.getLabel(); %>
							<% if (c5label.Equals("")) c5label = (string)Context.Items["label"]; %>
							<input type='radio' name='<%= control5.Current.getName() %>' id='<%=Context.Items["id"]%>' title='<%=c5label%>' class='deselect-off <%=control.Current.getCSSClass()%> form-check-input' value='<%= control5.Current.getHTMLValue() %>' <% if (control.Current.isRequired()) {%> required <%}%> <apn:metadata runat="server"/> <%= control.Current.containsValue(control5.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> aria-labelledby='<%=Context.Items["aria-labelledby"]%>'/>
							<% if(!control5.Current.getLabel().Equals("")) { %><label class="form-check-label" id='<%=Context.Items["aria-labelledby"]%>' for='<%=Context.Items["id"]%>' <% if(((string)Context.Items["layout"]).Equals("vertically")) { %>class='radio-inline'<% } %> title='<%=GetAttribute(control5.Current, "title", true)%>'><% ExecutePath("/controls/custom/control-label.aspx"); %></label><% } %>
							<% if (control.Current.getLabel().Equals("") && control.Current.isRequired()) { %><span class="required" data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span><% } %>
							<% if (control.Current.getCSSClass().Contains("inline")) { %></div><% } %>
						</apn:otherwise>
						</apn:choosecontrol>
						<% Context.Items["index"] = (int)Context.Items["index"] + 1; %>
					</li>
				</apn:forEach>
			</ul>
			<% Context.Items["label"] = ""; %>
			<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		</div>
		</apn:whencontrol>
		<apn:whencontrol runat="server" type="drop" >
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> form-group has-feedback has-search <apn:ifnotcontrolvalid runat="server" > has-error</apn:ifnotcontrolvalid>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> <%=Context.Items["readonly"]%><!-- #include file="aria-live.inc" --> >
				<% ExecutePath("/controls/label.aspx"); %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
				<% if (IsPdf || IsSummary) { %><p><%=control.Current.getSelectedLabel()%></p>
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
				<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</div>
		</apn:whencontrol>
	</apn:choosecontrol>
<% } %>
</apn:control>