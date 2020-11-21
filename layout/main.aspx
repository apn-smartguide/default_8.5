<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<div class="row">
	<div class="col-md-12">
		<div class="pull-right"><img class="logo" src='<%=resolvePath("/resources/img/logo.jpg")%>' /></div>
		<h1><apn:control runat="server" type="smartlet-name"><apn:value runat="server" /></apn:control></h1>
	</div>
</div>