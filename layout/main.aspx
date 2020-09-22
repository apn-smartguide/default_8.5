<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<% Context.Items["errorIndex"] = 0; %>
	<div class="page-header">
	<div class="row">
		<div class="col-sm-6">
			<img class="logo" src='<%=resolvePath("/resources/img/logo.jpg")%>' />
		</div>
		<div class="col-sm-6 hidden-xs">
			<div class="pull-right">
				<span class="glyphicon glyphicon-duplicate" aria-hidden="true"></span> <apn:localize runat="server" key="theme.text.services"/>
			</div>
		</div>
	</div>
	<!-- Smartlet title -->
	<h1>
		<apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control>
	</h1>
	<% Server.Execute(resolvePath("/layout/sections.aspx")); %>
	<!-- Validation messages -->
	<% Server.Execute(resolvePath("/controls/validation.aspx")); %>
	<div class="row page-title">
		<!-- Page title -->
		<%-- Display a progress bar only if a breadcrumb trail doesn't exist --%>
		<% if ((int)Context.Items["totalSection"] >0) { %>
		<div class="col-md-12">
			<h2><apn:control runat="server" type="step"><apn:label runat="server"/></apn:control></h2>
		</div>
		<% } else { %>
			<div class="col-md-6 col-md-push-6">
				<!-- Progress bar -->
				<apn:control runat="server" type="progress" id="progressBar">
					<div class="progress">
						<div class="progress-bar" role="progressbar" aria-valuenow="<%= int.Parse(progressBar.Current.getValue()) %>" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;width: <%= int.Parse(progressBar.Current.getValue()) %>%">
							<%= int.Parse(progressBar.Current.getValue()) %> %
						</div>
					</div>
				</apn:control>
			</div>
			<div class="col-md-6 col-md-pull-6">
				<h2><apn:control runat="server" type="step"><apn:label runat="server"/></apn:control></h2>
			</div>
		<% } %>
		</div>
	</div>