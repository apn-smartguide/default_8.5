<!-- TODO : Fix missing WET static dependencies -->
<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<title><apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control> &gt; <apn:control runat="server" type="step"><apn:label runat="server"/></apn:control></title>

	<meta name="description" content='<apn:control runat="server" type="smartlet-description"><apn:value runat="server"/></apn:control>'>
	<meta name="theme" content='<apn:control runat="server" type="smartlet-theme"><apn:value runat="server"/></apn:control>'>
	<meta name="author" content='<apn:control runat="server" type="smartlet-author"><apn:value runat="server"/></apn:control>'>
	<meta name="lastmodified" content='<apn:control runat="server" type="smartlet-lastmodification"><apn:value runat="server"/></apn:control>'>
	<meta name="keywords" content='<apn:control runat="server" type="keyword"><apn:value runat="server"/></apn:control>'>
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="generator" content="SmartGuide 8.0"> <!-- leave this for stats please -->
	<meta name="application-name" content="<apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control>">
	
	<% Server.Execute(resolvePath("/layout/dcterms.aspx")); %>

	<!--[if gte IE 9 | !IE ]><!-->
	<link href='<%=resolvePath("/resources/img/favicon.ico")%>' rel="icon" type="image/x-icon">
	<link href='<%=resolvePath("/resources/apn_icon.png")%>' rel="icon" sizes="192x192">
	<link href='<%=resolvePath("/resources/img/apn_icon.png")%>' rel="apple-touch-icon">
	<script src='<%=cacheBreak("/resources/js/jquery.min.js")%>'></script>
	<!--<![endif]-->
	<!--[if lt IE 9]>
	<link href='<%= resolvePath("/resources/img/favicon.ico")%>' rel="shortcut icon" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous" />

	<!-- Bootstrap CSS -->
	<link href='<%=cacheBreak("/resources/css/bootstrap.min.css")%>' rel="stylesheet">
	<!-- dataTables.net -->
	<!-- <link href='<%=cacheBreak("/resources/plugins/dataTables/css/dataTables.bootstrap.css")%>' rel="stylesheet"> -->
	<link href='<%=cacheBreak("/resources/plugins/dataTables/datatables.min.css")%>' rel="stylesheet">
	<link href='<%=cacheBreak("/resources/plugins/dataTables/Responsive-2.2.5/css/responsive.datatables.min.css")%>' rel="stylesheet">
	<link href='<%=cacheBreak("/resources/plugins/dataTables/Select-1.3.1/css/select.dataTables.min.css")%>' rel="stylesheet">
	<!-- Date widget support -->
	<link href='<%=cacheBreak("/resources/css/bootstrap-datepicker.min.css")%>' rel="stylesheet">
	<!-- Autocomplete support -->
	<link href='<%=cacheBreak("/resources/css/autocomplete.min.css")%>' rel="stylesheet">
	<!-- SmartGuide CSS -->
	<link href='<%=cacheBreak("/resources/css/smartguide/smartguide.css")%>' rel="stylesheet">
	<link href='<%=cacheBreak("/resources/css/smartguide/custom.css")%>' rel="stylesheet">

	<script src='<%=cacheBreak("/resources/js/iso-639-1.js")%>'></script>
	<script>
		var currentLocale = '<%=Context.Items["currentLocale"]%>';
		var basePath = '<%=Context.Items["basePath"]%>';
		var supportedLocales = [];
		var smartletName = '<%=Context.Items["interviewID"]%>'; 
		<apn:ifsmartletmultilingual runat="server">
			<apn:forEach runat="server" id="locale" items="languages">
			supportedLocales.push('<%=locale.Current.getValue()%>'); 
			</apn:forEach>
		</apn:ifsmartletmultilingual>
	</script>	
</head>