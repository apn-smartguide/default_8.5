<%@ Page Language="C#" autoeventwireup="false" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
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
		<div id='div_<apn:name runat="server"/>' class='<% if (Options.Contains("WET")) { %>chkbxrdio-grp <% } %> form-group <% if (Options.Contains("TTS")) { %>tts tts-play<% } %>'>
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<% if (!BareRender){ Execute("/controls/label.aspx"); } %>
			<% Context.Items["label"] = control.Current.getLabel(); %>
			<% Context.Items["hide-option-label"] = control.Current.getCSSClass().Contains("hide-option-label"); %>
			<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%><%= control.Current.getAlert() %></span></strong><br/></apn:ifnotcontrolvalid><% } %>
			<ul <%=Context.Items["readonly"]%> <apn:metadata runat="server" /> class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server" /> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' style='<apn:cssstyle runat="server"/>' <!-- #include file="aria-live.inc" -->>
			<% if(((string)Context.Items["readonly"]).Length == 0) { %><input type='hidden' name='<apn:name runat="server"/>' value='' /><% } %>
			<% Context.Items["index"] = 1; %>
			<apn:forEach id="control2" runat="server">
				<li>
					<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup">
							<% if(!control2.Current.getLabel().Equals("")) { %><label class='optgroup'><% Execute("/controls/custom/control-label.aspx"); %></label><% } %>
							<apn:forEach id="control3" runat="server">
								<% if (control.Current.getCSSClass().Contains("inline")) { %><div class="checkbox-inline"><% } %>
								<%
									Context.Items["id"] = control3.Current.getAttribute("id");
									if(SmartguideMajorVersion < 10) {
											Context.Items["id"] += "_" + Context.Items["optionIndex"] + "_" + Context.Items["index"];
									}
									string[] arrId = ((string)Context.Items["id"]).Split('o');
									Context.Items["optionIndex"] = arrId[arrId.Length-1];
								    Context.Items["tts-id"] = control.Current.getFieldId() + "." + Context.Items["optionIndex"] + "_option";
									Context.Items["aria-labelledby"] = "lbl_" + Context.Items["id"];
									if (!control3.Current.getLabel().Equals("")) { Context.Items["label"] = control3.Current.getLabel(); }
								%>
								<input type='checkbox' name='<%=control3.Current.getName() %>' id='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>' class='<%=control.Current.getCSSClass()%> form-check-input' value='<%= control3.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <%= control.Current.containsValue(control3.Current.getValue()) ? " checked='checked'" : "" %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> aria-labelledby='<%= Context.Items["aria-labelledby"]%>' />
								<label class='form-check-label' id='<%=Context.Items["aria-labelledby"]%>' for='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>'><% Execute("/controls/custom/control-label.aspx"); %></label>
								<% if (control.Current.getLabel().Equals("") && control.Current.isRequired()) { %><span class="required" data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span><% } %>
								<% if (control.Current.getCSSClass().Contains("inline")) { %></div><% } %>
								<% Context.Items["index"] = (int)Context.Items["index"] + 1; %>
							</apn:forEach>
						</apn:whencontrol>
						<apn:otherwise runat="server">
							<% if (control.Current.getCSSClass().Contains("inline")) { %><div class="checkbox-inline"><% } %>
							<% 
								Context.Items["id"] = control2.Current.getAttribute("id");
								if(SmartguideMajorVersion < 10) {
										Context.Items["id"] += "_" + Context.Items["optionIndex"] + "_" + Context.Items["index"];
								}
								string[] arrId = ((string)Context.Items["id"]).Split('o');
								Context.Items["optionIndex"] = arrId[arrId.Length-1];
								Context.Items["tts-id"] = control.Current.getFieldId() + "." + Context.Items["optionIndex"] + "_option"; 
								Context.Items["aria-labelledby"] = "lbl_" + Context.Items["id"];
								if (!control2.Current.getLabel().Equals("")) { Context.Items["label"] = control2.Current.getLabel(); }
							%>
							<input type='checkbox' name='<%=control2.Current.getName() %>' id='<%=Context.Items["id"]%>' title='<%=Context.Items["label"]%>' class='<%=control.Current.getCSSClass()%> form-check-input' value='<%= control2.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <%= control.Current.containsValue(control2.Current.getValue()) ? " checked='checked'" : "" %> <%=Context.Items["readonly"]%><% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> aria-labelledby='<%= Context.Items["aria-labelledby"]%>' />
							<label class="<% if(LayoutEngine == "BS4") { Response.Output.Write("form-check"); } else { Response.Output.Write("form-check-label"); } %>" id='<%=Context.Items["aria-labelledby"]%>' for='<%=Context.Items["id"]%>' title='<%=(!GetTooltip(control.Current).Equals("")) ? GetTooltip(control.Current) : Context.Items["label"]%>'><% Execute("/controls/custom/control-label.aspx"); %></label>
							<% if (control.Current.getLabel().Equals("") && control.Current.isRequired()) { %><span class="required" data-toggle='tooltip' data-html='true' title='<apn:localize runat="server" key="theme.text.required"/>'>*</span><% } %>
							<% if (control.Current.getCSSClass().Contains("inline")) { %></div><% } %>
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
		<apn:whencontrol runat="server" type="lbox">
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' <%=Context.Items["layout"]%> class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> form-group <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
				<% if (!BareRender){ %><% Execute("/controls/label.aspx"); %><% } %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
				<% if (IsPdf || IsSummary) { %><p><%=control.Current.getSelectedLabel()%></p>
				<% } else { %>
				<select name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' <apn:metadata runat="server" /> class='<apn:cssclass runat="server" /> form-control' <%=Context.Items["readonly"]%> style='<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>' multiple size='<%= control.Current.getAttribute("size") %>' <!-- #include file="aria-attributes.inc" -->>
				<apn:forEach runat="server" id="control6">
					<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup">
							<optgroup label='<apn:label runat="server" />' title='<%=GetAttribute(control3.Current, "title", true)%>'>
								<apn:forEach runat="server" id="control7">
									<option <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> value='<%= control7.Current.getHTMLValue() %>' title='<%= control7.Current.getAttribute("title") %>' <%= control.Current.containsValue(control7.Current.getValue()) ? "selected='selected'" : "" %>><apn:label runat="server" /></option>
								</apn:forEach>
							</optgroup>
						</apn:whencontrol>
						<apn:otherwise runat="server">
							<option <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> value='<%= control6.Current.getHTMLValue() %>' title='<%= control6.Current.getAttribute("title") %>' <%= control.Current.containsValue(control6.Current.getValue()) ? "selected='selected'" : "" %>><apn:label runat="server" /></option>
						</apn:otherwise>
					</apn:choosecontrol>
				</apn:forEach>
				</select>
				<% } %>
				<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class='<%=Class("label-danger")%>'><% if (ShowEnumerationErrors){%><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex.ToString()) %></span><%}%></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</div>
		</apn:whencontrol>
	</apn:choosecontrol>
	<% } %>
</apn:control>