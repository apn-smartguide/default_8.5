<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
<% Context.Items["readonly"] = (control.Current.getAttribute("readonly").Equals("readonly")) ? " disabled='disabled'" : ""; %>	
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
	<!-- #include file="hidden.inc" -->
<% } else { %>
<% Context.Items["bareControl"] = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
    <apn:ifnotcontrolvalid runat="server">
        <%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
        <a class='<apn:localize runat="server" key="theme.class.error-link"/>' id='error_index_<%=Context.Items["errorIndex"]%>'>Anchor to error <%=Context.Items["errorIndex"]%></a>
    </apn:ifnotcontrolvalid>
	<div id='div_<apn:name runat="server"/>' class='form-group <apn:cssclass runat="server"/> <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>' <!-- #include file="aria-live.inc" --> >
<% if(!((bool)Context.Items["bareControl"])) { %> 
	<% ExecutePath("/controls/label.aspx"); %>
<% } %>
<% if(control.Current.getAttribute("value").Trim().Length==0) { %>
  		<input type='file' class='form-control' name='<apn:name runat="server"/>' id='<apn:name runat="server"/>' <%=(string)Context.Items["readonly"]%> style='<apn:cssstyle runat="server"/>' title='<%=GetAttribute(control.Current, "title", true)%>' <apn:metadata runat="server"/> <apn:ifcontrolrequired runat="server">required</apn:ifcontrolrequired> <!-- #include file="aria-attributes.inc" -->/>
	<% } else { %>
  		<div class='form-control'>
			<a target= '_blank' href='upload/do.aspx/<apn:value runat="server"/>?id=<apn:name runat="server"/>&interviewID=<apn:control runat="server" type="interview-code"><apn:value runat="server"/></apn:control>'> <apn:value runat="server"/></a> 
			&nbsp;
			<!-- use button to clear, all the data on the page will be submitted -->
			<% if (((string)Context.Items["readonly"]).Length == 0) { %>
				<button type='submit' name='<apn:name runat="server"/>' class='btn btn-danger btn-xs' aria-labelledby='lbl_<apn:name runat="server"/>' onclick='this.value=""; return true;'><span class='<apn:localize runat="server" key="theme.icon.delete"/>'></span></button>
			<% } %>
			<!-- use link to clear, the data on the page will not be submitted -->
			<!-- <a href="?<apn:name runat="server"/>=">Clear</a>	-->
		</div>
	<% } %>
	</div>
<% } %>
</apn:control>