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
		<apn:whencontrol runat='server'  type="check">
			<fieldset id="div_<apn:name runat='server'/>" 
				<%=Context.Items["readonly"]%> <apn:metadata runat="server"/>
				class="form-group <apn:cssclass runat='server'/> <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" 
				style="<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>"
				<apn:metadata runat="server"/>
				<!-- #include file="aria-live.inc" --> 
			>
			<%
			if (!((bool)Context.Items["bareControl"])){
				Server.Execute(Page.TemplateSourceDirectory + "/legend.aspx");
			}	
			%> 
			
  			<apn:forEach id="control2" runat='server'>
  				<%
  				if(((string)Context.Items["readonly"]).Length == 0) {
  				%>
					<input type="hidden" name="<apn:name runat='server'/>" value="" />
				<%
				}
				%>
  				<apn:choosecontrol runat='server' >
  					<apn:whencontrol runat='server'  type="optgroup">
  						<label class="optgroup">
  							<apn:label runat='server'  />
							<apn:ifcontrolattribute runat='server' attr='title'>
								<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
							</apn:ifcontrolattribute>
							<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
						</label>
  						<apn:forEach id="control3" runat='server'>
  							<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
								<div class="checkbox" <%= Context.Items["layout"] %>>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' 
										for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
										title="<apn:controlattribute runat='server'  attr='title' tohtml='true'/>"
									>
							<% } else { %>
									<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' 
										for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
										class="checkbox-inline" 
										title="<apn:controlattribute runat='server' attr='title' tohtml='true' />"
									>
							<% } %>
									<input type="checkbox" 
										name="<%= control3.Current.getName() %>"
										id="<%=control3.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>"
										class="<apn:cssclass runat='server'/>"
										value="<%= control3.Current.getHTMLValue() %>"
                                        <apn:metadata runat="server"/>
										<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
											data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
											aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
										<% } %>
										aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'
										<%= control.Current.containsValue(control3.Current.getValue()) ? "checked=\"checked\"" : "" %> <%= Context.Items["layout"] %> 
									/>
										<%= control3.Current.getLabel() %>
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
  					<apn:otherwise runat="server">
  						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							<div class="checkbox" <%= Context.Items["layout"] %>>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>' 
									for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
									title="<apn:controlattribute runat='server'  attr='title' tohtml='true' />"
								>
						<% } else { %>
								<label id='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'
									for='<apn:controlattribute runat="server" attr="id" /><%=Context.Items["optionIndex"]%>' 
									class="checkbox-inline" 
									title="<apn:controlattribute runat='server' attr='title' tohtml='true' />"
								>
						<% } %>
								<input type="checkbox" 
									name="<%= control2.Current.getName() %>"
									id="<%=control2.Current.getAttribute("id")%><%=Context.Items["optionIndex"]%>"
									class="<apn:cssclass runat='server'/>"
									aria-labelledby='lbl_<apn:controlattribute runat="server" attr="id"/><%=Context.Items["optionIndex"]%>'
									<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
										data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
										aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
									<% } %>
									value="<%= control2.Current.getHTMLValue() %>"
                                    <apn:metadata runat="server"/>
									<%= control.Current.containsValue(control2.Current.getValue()) ? "checked=\"checked\"" : "" %> <%= Context.Items["layout"] %> 
								/>
									<%= control2.Current.getLabel() %>
									<apn:ifcontrolattribute runat='server' attr='title'>
										<span title="" data-toggle="tooltip" class="glyphicon glyphicon-question-sign" data-original-title="<apn:controlattribute runat='server' tohtml='true' attr='title'/>"></span>
									</apn:ifcontrolattribute>
									<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
								</label>
						<% if(((string)Context.Items["layout"]).Equals("vertically")) { %>
							</div>
						<%	}	%>
  					</apn:otherwise>
  				</apn:choosecontrol>
  			</apn:forEach>
				<% if (!control.Current.getHelp().Equals("")) { %><p><% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %></p><% } %>
			</fieldset>
  		</apn:whencontrol>
  					
  		<apn:whencontrol runat='server'  type="lbox">
			<div id="div_<apn:name runat='server'/>" 
				<%=Context.Items["layout"]%> 
				class="<apn:cssclass runat='server'/> form-group <apn:ifnotcontrolvalid runat='server'>has-error</apn:ifnotcontrolvalid>" 
				<!-- #include file="aria-live.inc" --> 
			>
			<%
			if (!((bool)Context.Items["bareControl"])){
				Server.Execute(Page.TemplateSourceDirectory + "/label.aspx");
			}	
			%>			
				<select
					name="<%= control.Current.getName() %>"
					id="<%= control.Current.getName() %>"
                                        <apn:metadata runat="server"/>
					class="<apn:cssclass runat='server'/> form-control"
					aria-labelledby="lbl_<apn:name runat='server'/>"
					<%=Context.Items["readonly"]%>
					style="<%= (control.Current.getAttribute("style")+" "+control.Current.getCSSStyle()) %>"
					multiple size="<%= control.Current.getAttribute("size") %>"
				>
					<apn:forEach runat='server' id="control6">
						<apn:choosecontrol runat='server' >
							<apn:whencontrol runat='server' type="optgroup">
							<optgroup 
								label="<apn:label runat='server' />" 
								title="<apn:controlattribute runat='server' attr='title' tohtml='true'/>"
							>
								<apn:forEach runat='server' id="control7">
									<option 
										<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> 
											data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
											aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
										<% } %>
										value="<%= control7.Current.getHTMLValue() %>"
										title="<%= control7.Current.getAttribute("title") %>"
										<%= control.Current.containsValue(control7.Current.getValue()) ? "selected=\"selected\"" : "" %> 
									>
										<apn:label runat='server' />
									</option>
							  </apn:forEach>
							</optgroup>
							</apn:whencontrol>
							<apn:otherwise runat="server">
								<option 
									<% if(!control.Current.getAttribute("eventtarget").Equals("")) { %>
										data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' 
										aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>'
									<% } %>
									value="<%= control6.Current.getHTMLValue() %>"
									title="<%= control6.Current.getAttribute("title") %>"
									<%= control.Current.containsValue(control6.Current.getValue()) ? "selected=\"selected\"" : "" %> 
								>
									<apn:label runat='server' />
								</option>
							</apn:otherwise>
						</apn:choosecontrol>
					</apn:forEach>
				</select>
				<% Server.Execute(Page.TemplateSourceDirectory + "/help_icon.aspx"); %>
			</div>
  		</apn:whencontrol>
  	</apn:choosecontrol>
<%
}
%>  
</apn:control>

