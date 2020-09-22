<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%-- Do not change the ids as they are referenced in smartguide.js --%>
<apn:control runat="server" id="control">

<% 	
if (control.Current.getAttribute("visible").Equals("false")) {
%>
	<!-- #include file="render_hidden_div.inc" -->
<%
} else { 
	Context.Items["layout"] = control.Current.getChoiceLayout();
	Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : ""; 
	Context.Items["bareControl"] = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
%>
  	<apn:choosecontrol runat='server' >
		<apn:whencontrol runat='server' type="radio">
			<fieldset id="div_<apn:name runat='server' />" 
				class="form-group <apn:cssclass runat='server'/> 
				style="<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>"
				<apn:metadata runat="server"/>
				<apn:ifnotcontrolvalid runat='server' >has-error</apn:ifnotcontrolvalid>" 
				<%=Context.Items["readonly"]%> 
				<!-- #include file="aria-live.inc" --> >
				<!-- #include file="control_label.inc" -->
				<apn:forEach runat='server' id="control5" ><apn:choosecontrol runat='server'>
					<apn:whencontrol runat='server' type="optgroup">
						<label class="optgroup">
							<apn:label runat='server'/>
							<apn:ifcontrolattribute runat='server' attr='title'>
								<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
							</apn:ifcontrolattribute>
							<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
						</label>
						<apn:forEach runat='server' id="control6">
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
								<div class="radio" <%= Context.Items["readonly"] %>>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' 
										for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
										title="<apn:controlattribute runat='server' attr='title' tohtml='true' />"
									>
							<% } else { %>
						
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'
										for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
										class="radio-inline" 
										title="<apn:controlattribute runat='server' attr='title' tohtml='true' />"
									>
							<% } %>
										<input type="radio" 
											name="<%= control6.Current.getName() %>"
											id="<%=control6.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>"
											class="<apn:cssclass runat='server'/> deselect-off"
											value="<%= control6.Current.getHTMLValue() %>"
                                            <apn:metadata runat="server"/>
											<%= control.Current.containsValue(control6.Current.getValue()) ? "checked=\"checked\"" : "" %> <%= Context.Items["readonly"] %> 
											<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
												data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
												aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
											<% } %>
											aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'
										/>
										<%= control6.Current.getLabel() %>
										<apn:ifcontrolattribute runat='server' attr='title'>
											<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
										</apn:ifcontrolattribute>
										<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
									</label>
							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
								</div>
							<%	}	%>
						</apn:forEach>
					</apn:whencontrol>
					<apn:otherwise runat='server'>
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							<div class="radio" <%= Context.Items["readonly"] %>>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' 
									for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>'
                                    title="<apn:controlattribute runat='server' attr='title' tohtml='true' />">
						<% } else { %>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' 
									for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
									class="radio-inline" 
									title="<apn:controlattribute runat='server' attr='title' tohtml='true' />"
								>
						<% } %>
									<input type="radio" 
										name="<%= control5.Current.getName() %>"
										id="<%=control5.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>"
										class="<apn:cssclass runat='server'/> deselect-off"
										value="<%= control5.Current.getHTMLValue() %>"
                                        <apn:metadata runat="server"/>
										<%= control.Current.containsValue(control5.Current.getValue()) ? "checked=\"checked\"" : "" %> <%= Context.Items["readonly"] %> 
										<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
											data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
											aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
										<% } %>
										aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'
									/>
									<%= control5.Current.getLabel() %>
									<apn:ifcontrolattribute runat='server'  attr='title'>
										<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
									</apn:ifcontrolattribute>
									<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
								</label>
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							</div>
						<%	}	%>
					</apn:otherwise>
				</apn:choosecontrol></apn:forEach>
				<p><% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %></p>
			</fieldset>
  		</apn:whencontrol>
  					
  		<apn:whencontrol runat='server' type="drop" >
			<div id="div_<apn:name runat='server'/>" 
				class="<apn:cssclass runat='server'/> form-group <apn:ifnotcontrolvalid runat='server' >has-error</apn:ifnotcontrolvalid>" 
				isSelect1 
				<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
					data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
					aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
				<% } %> 
				<%=Context.Items["readonly"]%>
				<!-- #include file="aria-live.inc" --> 
			>
				<!-- #include file="control_label.inc" -->
				<%
					if (control.Current.getCSSClass().IndexOf("autocomplete") > -1) {
				%>
					<input name="<apn:name runat='server'/>" type="hidden" value="<%=control.Current.getValue()%>"/>
					<input <%=Context.Items["readonly"]%> value="<%=control.Current.getSelectedLabel()%>" <apn:metadata runat="server"/> id="<%= control.Current.getName() %>"  class="<apn:cssclass runat='server'/> form-control"  />
					<datalist id="<%= control.Current.getName() %>_list">
						<apn:forEach runat="server" id="control7" >
							<apn:choosecontrol runat="server">
								<apn:whencontrol type="optgroup" runat="server">
								</apn:whencontrol>
								<apn:otherwise runat="server">
									<option value="<%= control7.Current.getHTMLValue() %>" ><apn:label runat="server"/></option>
								</apn:otherwise>
							</apn:choosecontrol>
						</apn:forEach>
					</datalist>
				<%
					} else {
				%>
                <select 
					name="<%= control.Current.getName() %>" 
					id="<%= control.Current.getName() %>"
					class="form-control input-sm"  
					aria-labelledby="lbl_<apn:name runat='server'/>"
					style="<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>" 
                    size="1"
                    <apn:metadata runat="server"/>
                    <%=Context.Items["readonly"]%> 
				>
                    <apn:forEach runat='server' id="control4" ><apn:choosecontrol runat='server'  >
						<apn:whencontrol runat='server'  type="optgroup" >
							<optgroup label="<apn:label runat='server'/>" title="<apn:controlattribute runat='server' attr='title' tohtml='true'/>">
								<apn:forEach runat='server' id="control2" >
									<option 
										value="<%= control2.Current.getHTMLValue() %>"  
										title="<%= control2.Current.getAttribute("title") %>" 
										<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
											data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
											aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
										<% } %>
										<%= control.Current.getValue().Equals(control2.Current.getValue()) ? "selected=\"selected\"" : "" %> 
									><apn:label runat='server'/></option>
								</apn:forEach>
							</optgroup>
						</apn:whencontrol>
						<apn:otherwise runat='server'>
							<option 
								value="<%= control4.Current.getHTMLValue() %>"  
								title="<%= control4.Current.getAttribute("title") %>" 
								<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
									data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
									aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
								<% } %>
								<%= (control.Current.getValue() != null && control.Current.getValue().Equals(control4.Current.getValue())) ? "selected=\"selected\"" : "" %> 
							><apn:label runat='server'/></option>
						</apn:otherwise>
                    </apn:choosecontrol></apn:forEach>
                </select>
				<%
					}
				%>				
                <% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
			</div>
  		</apn:whencontrol>
  	</apn:choosecontrol>
<%
} 
%>
</apn:control>

