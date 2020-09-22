<%@ Page Language="C#" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<%@ Import Namespace="System.Globalization" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<apn:control runat="server" id="control">
<%
	Context.Items["html5type"] = "text";
	// check if html5 type specified explicitly
	if (control.Current.getAttribute("html5type").Length > 0) {
		Context.Items["html5type"] = control.Current.getAttribute("html5type");
	}	
%>
<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " readonly='readonly'" : ""; %>
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<% } else { %>
	<apn:ifnotcontrolvalid runat="server">
		<% Context.Items["errorIndex"] = (int)Context.Items["errorIndex"] + 1; %>
		<a id='error_index_<%=Context.Items["errorIndex"]%>'></a>
	</apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> > 
	<% Server.Execute(resolvePath("/controls/label.aspx")); %>
			<apn:choosecontrol runat="server">
				<apn:whencontrol type="INPUT" runat="server">
					<%-- for html date type, format must be "yyyy-mm-dd" for value, min and max attributes. --%>
					<%-- for min or max attribute set via data attribute; Ex.: HTML -> Min -> setting --%>
					<%-- For the setting place a hidden field named like the date-input + "-max" or "-min", note format is yyyy-mm-dd --%>
					<% 
						Context.Items["data-value"] = "";
                        if (control.Current.getValue() != null && !control.Current.getValue().Equals("")) {
 
                            DateTime dt = new DateTime();
                            try{
                                dt = DateTime.Parse(control.Current.getValue());
                            } catch(Exception e) {
                                dt = DateTime.ParseExact(control.Current.getValue(), "dd/MM/yyyy", new CultureInfo("en-US"));
                            }
                            Context.Items["data-value"] = dt.ToString("yyyy-MM-dd");
                        }
						
					%>
					<input type='<%=Context.Items["html5type"]%>' class='form-control' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' value='<%=Context.Items["data-value"]%>' size='<apn:controlattribute attr="size" runat="server"/>' <apn:metadata runat="server" /> maxlength='<apn:controlattribute attr="size" runat="server" />' <%= Context.Items["readonly"] %> #include file="aria-attributes.inc" />
				</apn:whencontrol>
				<apn:whencontrol type="SELECT1" runat="server">
					<apn:control id="control1" runat="server">
						<select <apn:metadata runat="server" /> class='form-control' name='<apn:name runat="server" />' <apn:ifnotcontrolvalid runat="server"> aria-describedby='error_<apn:name runat="server" />' </apn:ifnotcontrolvalid> aria-invalid='<%= (control.Current.isValid()? "true" : "false")%>' aria-required='<%=control.Current.isRequired()%>' aria-labelledby='lbl_<apn:name runat="server" />'>
						<apn:forEach id="control2" runat="server">
							<option <% if(!control.Current.getAttribute("eventtarget").Equals("")) { %> data-eventtarget='[<%=control.Current.getAttribute("eventtarget")%>]' aria-controls='<%=control.Current.getAttribute("eventtarget").Replace("\"","")%>' <% } %> id='<apn:name runat="server"/>' name='<apn:name runat="server"/>' value='<apn:value runat="server" tohtml="true"/>' <%= control.Current.containsValue(control2.Current.getValue()) ? "selected" : "" %>><apn:label runat="server" /></option>
						</apn:forEach>
						</select>
					</apn:control>
				</apn:whencontrol>
				<apn:whencontrol type="LABEL" runat="server">
					<apn:label runat="server" />
				</apn:whencontrol>
			</apn:choosecontrol>
			<% Server.Execute(resolvePath("/controls/help.aspx")); %>
	</div>
	<% } %>
</apn:control>