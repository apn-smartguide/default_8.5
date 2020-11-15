<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<% } else { %>
<%
	Context.Items["layout"] = control.Current.getChoiceLayout();
	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : ""; 
	Context.Items["bareControl"] = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
%>
  	<apn:choosecontrol runat="server" >
		<apn:whencontrol runat="server" type="radio">
			<apn:ifnotcontrolvalid runat="server">
				<% Context.Items["errorIndex"] = (int) Context.Items["errorIndex"] + 1; %>
				<a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
			</apn:ifnotcontrolvalid>
			<fieldset  id='div_<apn:name runat="server" />' class='sg-radio chkbxrdio-grp form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server" >has-error</apn:ifnotcontrolvalid>' <apn:metadata runat="server"/> <%=Context.Items["readonly"]%> <!-- #include file="aria-live.inc" --> >
				<% if (!((bool)Context.Items["bareControl"])){ Server.Execute(resolvePath("/controls/legend.aspx")); }	%>
				<% if(!((string)Context.Items["layout"]).Equals("vertically")) { %><br/><% } %>
				<% Context.Items["counter"] = 1; %>
				<apn:forEach runat="server" id="control5" >
					<apn:choosecontrol runat="server">
					<apn:whencontrol runat="server" type="optgroup">
						<label class='optgroup'>
							<% Server.Execute(resolvePath("/controls/tooltip.aspx")); %>
						</label>
						<apn:forEach runat="server" id="control6">
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
								<div class='radio vertical' <%= Context.Items["readonly"] %>>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' title='<apn:controlattribute runat="server" attr="title" tohtml="true" />'>
							<% } else { %>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' class='radio-inline' title='<apn:controlattribute runat="server" attr="title" tohtml="true" />'>
							<% } %>
									<input type='radio' name='<%= control6.Current.getName() %>' id='<%=control6.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>' class='<%=control.Current.getCSSClass()%> deselect-off' value='<%= control6.Current.getHTMLValue() %>' <apn:metadata runat="server"/> <%= control.Current.containsValue(control6.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'/>
									<span><% Server.Execute(resolvePath("/controls/tooltip.aspx")); %></span>
									</label>
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
								</div>
							<% } %>
						</apn:forEach>
					</apn:whencontrol>
					<apn:otherwise runat="server">
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							<div class='radio vertical' <%= Context.Items["readonly"] %>>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' title='<apn:controlattribute runat="server" attr="title" tohtml="true" />'>
						<% } else { %>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' class='radio-inline' title='<apn:controlattribute runat="server" attr="title" tohtml="true" />'>
						<% } %>
								<input type='radio' name='<%= control5.Current.getName() %>' id='<%=control5.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>' class='<%=control.Current.getCSSClass()%> deselect-off' value='<%= control5.Current.getHTMLValue() %>' <apn:metadata runat="server"/> <%= control.Current.containsValue(control5.Current.getValue()) ? "checked='checked'" : "" %> <%= Context.Items["readonly"] %> <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'/>
								<% Server.Execute(resolvePath("/controls/tooltip.aspx")); %>
								</label>
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							</div>
						<% } %>
					</apn:otherwise>
					</apn:choosecontrol>
					<% Context.Items["counter"] = (int)Context.Items["counter"] + 1; %>
				</apn:forEach>
			</fieldset>
  		</apn:whencontrol>
  		<apn:whencontrol runat="server" type="drop" >
            <apn:ifnotcontrolvalid runat="server">
                 <% Context.Items["errorIndex"] = (int)Context.Items["errorIndex"] + 1; %>
				<a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
            </apn:ifnotcontrolvalid>
			<div id='div_<apn:name runat="server"/>' class='<apn:cssclass runat="server"/> form-group <apn:ifnotcontrolvalid runat="server" >has-error</apn:ifnotcontrolvalid>' isSelect1 <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %> <%=Context.Items["readonly"]%><!-- #include file="aria-live.inc" --> >
				<% Server.Execute(resolvePath("/controls/label.aspx")); %>
				<% if (control.Current.getCSSClass().IndexOf("autocomplete") > -1) { %>
				<input <%=Context.Items["readonly"]%> value='<%=control.Current.getSelectedLabel()%>' <apn:metadata runat="server"/> id='<%= control.Current.getName() %>' class='<apn:cssclass runat="server"/> form-control' />
					<%--<input name='<apn:name runat="server"/>' type='hidden' value='<%=control.Current.getValue()%>'/>--%>
					<%--<input value='<%=control.Current.getSelectedLabel()%>' id='<%= control.Current.getName() %>' class='<apn:cssclass runat="server"/> form-control' />--%>
					<input value='<%= control.Current.getLabel()%>' id='<%= control.Current.getName() %>' class='<apn:cssclass runat="server"/> form-control' />
					<datalist id='<%= control.Current.getName() %>_list'>
						<apn:forEach runat="server" id="control7" >
							<apn:choosecontrol runat="server">
								<apn:whencontrol type="optgroup" runat="server">
								</apn:whencontrol>
								<apn:otherwise runat="server">
									<option value='<%= control7.Current.getHTMLValue() %>' ><apn:label runat="server"/></option>
								</apn:otherwise>
							</apn:choosecontrol>
						</apn:forEach>
					</datalist>
				<% } else { %>
                <select name='<%= control.Current.getName() %>' id='<%= control.Current.getName() %>' class='<apn:cssclass runat="server"/> form-control input-sm' aria-labelledby='lbl_<apn:name runat="server"/>' style='<%= (control.Current.getAttribute("style") + " " + control.Current.getCSSStyle()) %>' size='1' <apn:metadata runat="server"/><%=Context.Items["readonly"]%> >
                    <apn:forEach runat="server" id="control4" >
						<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="optgroup" >
							<optgroup label='<apn:label runat="server"/>' title='<apn:controlattribute runat="server" attr="title" tohtml="true"/>'>
								<apn:forEach runat="server" id="control2" >
									<option value='<%= control2.Current.getHTMLValue() %>' title='<%= control2.Current.getAttribute("title") %>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %><%= control.Current.containsValue(control2.Current.getValue()) ? " selected='selected'" : "" %> > 
										<apn:label runat="server"/>
									</option>
								</apn:forEach>
							</optgroup>
						</apn:whencontrol>
						<apn:otherwise >
							<option value='<%= control4.Current.getHTMLValue() %>' title='<%= control4.Current.getAttribute("title") %>' <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'<% } %><%= control.Current.containsValue(control4.Current.getValue()) ? " selected='selected'" : "" %> >
								<apn:label runat="server"/>
							</option>
						</apn:otherwise>
						</apn:choosecontrol>
					</apn:forEach>
                </select>
				<% } %>
			</div>
  		</apn:whencontrol>
  	</apn:choosecontrol>
<% } %>
</apn:control>