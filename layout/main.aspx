<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<%
	string pullCSS;
	if (LayoutEngine == "BS4") {
		pullCSS = "float-right";
	} else {
		pullCSS = "pull-right";
	}
%>
<div class="row smartlet-title">
	<div class="col-12">
		<div class="<%= pullCSS%>"><img class="float-sm-right" src='<%=ResolvePath("/resources/img/logo.jpg")%>' /></div>
		<h2><apn:control runat="server" type="smartlet-name"><apn:value runat="server" /></apn:control></h2>
	</div>
</div>
