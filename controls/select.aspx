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
		<div id='div_<apn:name runat="server"/>' class="chkbxrdio-grp form-group">
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<% if (!BareRender){ ExecutePath("/controls/label.aspx"); } %>
			<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex .ToString()) %></span><%= control.Current.getAlert() %></span></strong><br/></apn:ifnotcontrolvalid><% } %>
			<ul <%=Context.Items["readonly"]%> <apn:metadata runat="server" /> class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server" /><apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' style='<apn:cssstyle runat="server"/>' <!-- #include file="aria-live.inc" -->>
			<% Context.Items["index"] = 1; %>
			<% if(((string)Context.Items["readonly"]).Length == 0) { %><input type='hidden' name='<apn:name runat="server"/>' value='' /><% } %>
			<apn:forEach id="control2" runat="server">
				<li>
					<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup">
							<label class='optgroup'><% ExecutePath("/controls/custom/control-label.aspx"); %></label>
							<apn:forEach id="control3" runat="server">
								<% if (control.Current.getCSSClass().Contains("inline")) { %>
								<div class="checkbox-inline">
								<% } %>
								<input type='checkbox' name='<%= control3.Current.getName() %>' id='<%= control3.Current.getAttribute("id")%>_<%= Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>' class='<%=control.Current.getCSSClass()%> form-check-input' value='<%= control3.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> <% if(!control3.Current.getLabel().Equals("")) { %>aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id" />_<%=Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>'<% } %> <%= control.Current.containsValue(control3.Current.getValue()) ? " checked='checked'" : "" %> />
								<% if(!control3.Current.getLabel().Equals("")) { %>
								<label class="form-check-label" id='lbl_<apn:controlattribute runat="server" attr="id"/>_<%=Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>' for='<apn:controlattribute runat="server" attr="id" />_<%=Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>' title='<%=GetAttribute(control3.Current, "title", true)%>'>
								<% ExecutePath("/controls/custom/control-label.aspx"); %>
								</label>
								<% } %>
								<% if (control.Current.getCSSClass().Contains("inline")) { %>
								</div>
								<% } %>
							</apn:forEach>
						</apn:whencontrol>
						<apn:otherwise runat="server">
							<% if (control.Current.getCSSClass().Contains("inline")) { %>
							<div class="checkbox-inline">
							<% } %>
							<input type='checkbox' name='<%= control2.Current.getName() %>' id='<%= control2.Current.getAttribute("id")%>_<%=Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>' class='<%=control.Current.getCSSClass()%> form-check-input' <% if(!control2.Current.getLabel().Equals("")) { %> aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/>_<%= Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>'<% } %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%= control.Current.getAttribute("eventtarget")%>]' aria-controls='<%= control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %>  value='<%= control2.Current.getHTMLValue() %>' <apn:metadata runat="server" /> <%= control.Current.containsValue(control2.Current.getValue()) ? " checked='checked'" : "" %> />
							<% if(!control2.Current.getLabel().Equals("")) { %>
							<label class="form-check-label" id='lbl_<apn:controlattribute runat="server" attr="id"/>_<%=Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>' for='<apn:controlattribute runat="server" attr="id" />_<%=Context.Items["optionIndex"]%>_<%=Context.Items["index"]%>' title='<%=GetAttribute(control2.Current, "title", true)%>'>
							<% ExecutePath("/controls/custom/control-label.aspx"); %>
							</label>
							<% } %>
							<% if (control.Current.getCSSClass().Contains("inline")) { %>
							</div>
							<% } %>
						</apn:otherwise>
					</apn:choosecontrol>
					<% Context.Items["counter"] = (int)Context.Items["counter"] + 1; %>
				</li>
			</apn:forEach>
			</ul>
			<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex .ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
		</div>
		</apn:whencontrol>
		<apn:whencontrol runat="server" type="lbox">
			<apn:ifnotcontrolvalid runat="server"><% ErrorIndex++; %><a class='sr-only <apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=ErrorIndex %>'>Anchor to error <%=ErrorIndex %></a></apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' <%=Context.Items["layout"]%> class='<%=Context.Items["no-col-layout"]%> <apn:cssclass runat="server"/> form-group <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" -->>
				<% if (!BareRender){ %><% ExecutePath("/controls/label.aspx"); %><% } %>
				<% if(ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex .ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
				<% if (IsPdf || IsSummary) { %><p><%=control.Current.getSelectedLabel()%></p>
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
				<% if(!ShowErrorsAbove) { %><apn:ifnotcontrolvalid runat="server"><strong id='<apn:name runat="server"/>-error' class='error'><span class="label label-danger"><span class="prefix"><%=Smartlet.getLocalizedResource("theme.text.error-prefix").Replace("{1}", ErrorIndex .ToString()) %></span><%= control.Current.getAlert() %></span></strong></apn:ifnotcontrolvalid><% } %>
			</div>
		</apn:whencontrol>
	</apn:choosecontrol>
	<% } %>
</apn:control>