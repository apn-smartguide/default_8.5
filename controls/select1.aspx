<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<%
if (!IsAvailable(control)) {
	Execute("/controls/hidden.aspx");
} else {
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
		<div id='div_<apn:name runat="server" />' data-name='<%=control.Current.getCode()%>' class='<% if (Options.Contains("WET")) { %>chkbxrdio-grp <% } %>form-group'>
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<% Context.Items["hide-label"] = control.Current.getCSSClass().Contains("hide-label"); %>
			<% if (!BareRender && !(bool)Context.Items["hide-label"]){ Execute("/controls/label.aspx"); } %>
			<% Context.Items["label"] = control.Current.getLabel(); %>
			<% Context.Items["hide-option-label"] = control.Current.getCSSClass().Contains("hide-option-label"); %>
			<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong><br/></apn:ifnotcontrolvalid><% } %>
			<ul <%=Context.Items["readonly"]%> <apn:metadata runat="server" /> class='<% if(((string)Context.Items["layout"]).Equals("horizontally")) { %>radio-inline<% } %> <%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server" >has-error</apn:ifnotcontrolvalid>' style='<apn:cssstyle runat="server"/>' <!-- #include file="aria-live.inc" --> >
				<% Context.Items["index"] = 1; %>
				<apn:forEach runat="server" id="control5">
					<li class="radio">
						<apn:choosecontrol runat="server">
							<apn:whencontrol runat="server" type="optgroup">
								<label class='optgroup'><% Execute("/controls/custom/control-label.aspx"); %></label>
								<apn:forEach runat="server" id="control6">
									<% if (control.Current.getCSSClass().Contains("inline")) { %><div class="radio-inline"><% } %>
										<% 
											Context.Items["id"] = control6.Current.getAttribute("id");
											if(SmartguideMajorVersion < 10) {
													Context.Items["id"] += "_" + Context.Items["optionIndex"] + "_" + Context.Items["index"];
											}
											Context.Items["aria-labelledby"] = "lbl_" + Context.Items["id"];
											if (!control6.Current.getLabel().Equals("")) { Context.Items["label"] = control6.Current.getLabel(); }
										%>
										<input type='radio' name='<%= control6.Current.getName() %>' id='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>' class='deselect-off <%=control.Current.getCSSClass()%> form-check-input' value='<%= control6.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <%= control.Current.containsValue(control6.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %>
										<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> aria-labelledby='<%=Context.Items["aria-labelledby"]%>'/>
										<label class="form-check-label" id='<%=Context.Items["aria-labelledby"]%>' for='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>'><% Execute("/controls/custom/control-label.aspx"); %></label>
										<% if (control.Current.getLabel().Equals("") && control.Current.isRequired()) { %><span class="required" data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span><% } %>
										<% if (control.Current.getCSSClass().Contains("inline")) { %>
									</div><% } %>
									<% Context.Items["index"] = (int)Context.Items["index"] + 1; %>
								</apn:forEach>
							</apn:whencontrol>
							<apn:otherwise runat="server">
								<% if (control.Current.getCSSClass().Contains("inline")) { %><div class="radio-inline"><% } %>
									<% 
										Context.Items["id"] = control5.Current.getAttribute("id");
										if(SmartguideMajorVersion < 10) {
												Context.Items["id"] += "_" + Context.Items["optionIndex"] + "_" + Context.Items["index"];
										}
										Context.Items["aria-labelledby"] = "lbl_" + Context.Items["id"];
										if (!control5.Current.getLabel().Equals("")) { Context.Items["label"] = control5.Current.getLabel(); }
									%>
									<input type='radio' name='<%= control5.Current.getName() %>' id='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>' class='deselect-off <%=control.Current.getCSSClass()%> form-check-input' value='<%= control5.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <%= control.Current.containsValue(control5.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> aria-labelledby='<%=Context.Items["aria-labelledby"]%>'/>
									<label class="form-check-label" id='<%=Context.Items["aria-labelledby"]%>' for='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>'><% Execute("/controls/custom/control-label.aspx"); %></label>
									<% if (control.Current.getLabel().Equals("") && control.Current.isRequired()) { %><span class="required" data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span><% } %>
									<% if (control.Current.getCSSClass().Contains("inline")) { %>
								</div><% } %>
							</apn:otherwise>
						</apn:choosecontrol>
						<% Context.Items["index"] = (int)Context.Items["index"] + 1; %>
					</li>
				</apn:forEach>
			</ul>
			<% Context.Items["label"] = ""; %>
			<% Context.Items["hide-option-label"] = null; %>
			<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		</div>
		</apn:whencontrol>
		<apn:whencontrol runat="server" type="drop" >
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' data-name='<%=control.Current.getCode()%>' class='<%=Context.Items["no-col-layout"]%> <%=GetCleanCSSClass(control.Current)%> form-group has-feedback has-search <apn:ifnotcontrolvalid runat="server" > has-error</apn:ifnotcontrolvalid>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> <%=Context.Items["readonly"]%><!-- #include file="aria-live.inc" --> >
				<% Execute("/controls/label.aspx"); %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
				<% if (IsPdf || IsSummary) { %><p><%=control.Current.getSelectedLabel()%></p>
				<% } else if (control.Current.getCSSClass().IndexOf("autocomplete") > -1) { %>
				<input name='<apn:name runat="server"/>' data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' type="hidden" value="<%=control.Current.getValue()%>"/>
				<input type='text' id='<%= control.Current.getName() %>' name='<%= "autocomplete_"+control.Current.getName() %>' <%=Context.Items["readonly"]%> value='<%=control.Current.getSelectedLabel()%>' <apn:metadata runat="server"/> class='<apn:cssclass runat="server"/> form-control' aria-labelledby='lbl_<apn:name runat="server"/>'/>
				<datalist id='<%= control.Current.getName() %>_list'>
					<apn:forEach runat="server" id="control7" >
						<apn:choosecontrol runat="server">
							<apn:whencontrol type="optgroup" runat="server"></apn:whencontrol>
							<apn:otherwise runat="server">
								<option value='<%= control7.Current.getHTMLValue() %>' ><%=GetAttribute(control7.Current, "label")%></option>
							</apn:otherwise>
						</apn:choosecontrol>
					</apn:forEach>
				</datalist>
				<% } else { %>
				<select name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' class='<%=GetCleanCSSClass(control.Current).Replace("pull-right","")%> form-control input-sm' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> aria-labelledby='lbl_<apn:name runat="server"/>' style='<%= (control.Current.getAttribute("style") + " " + control.Current.getCSSStyle()) %>' size='1' <apn:metadata runat="server"/><%=Context.Items["readonly"]%> >
					<apn:forEach runat="server" id="control4" >
						<apn:choosecontrol runat="server">
							<apn:whencontrol runat="server" type="optgroup" >
								<optgroup label='<%=GetAttribute(control4.Current, "label")%>' title='<%=GetAttribute(control4.Current, "title", true)%>'>
									<apn:forEach runat="server" id="control2" >
										<option value='<%= control2.Current.getHTMLValue() %>' title='<%= control2.Current.getAttribute("title") %>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %><%= control.Current.containsValue(control2.Current.getValue()) ? " selected='selected'" : "" %> > <%=GetAttribute(control2.Current, "label")%></option>
									</apn:forEach>
								</optgroup>
							</apn:whencontrol>
							<apn:otherwise runat="server">
								<option value='<%= control4.Current.getHTMLValue() %>' title='<%= control4.Current.getAttribute("title") %>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %><%= control.Current.containsValue(control4.Current.getValue()) ? " selected='selected'" : "" %> ><%=GetAttribute(control4.Current, "label")%></option>
							</apn:otherwise>
						</apn:choosecontrol>
					</apn:forEach>
				</select>
				<% } %>
				<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</div>
		</apn:whencontrol>
	</apn:choosecontrol>
<% } %>
</apn:control>