<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<!--[if gte IE 9 | !IE ]><!-->
<link href='<%=resolvePath("/resources/img/favicon.ico")%>' rel="icon" type="image/x-icon">
<link href='<%=resolvePath("/resources/img/apn_icon.png")%>' rel="icon" sizes="192x192">
<link href='<%=resolvePath("/resources/img/apn_icon.png")%>' rel="apple-touch-icon">
<script src='<%=cacheBreak("/resources/js/jquery-3.5.1.js")%>'></script>
<!--<![endif]-->
<!--[if lt IE 9]>
<link href='<%= resolvePath("/resources/img/favicon.ico")%>' rel="shortcut icon" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<![endif]-->
<link href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous" rel="stylesheet">
<!-- Bootstrap CSS -->
<link href='<%=cacheBreak("/resources/css/bootstrap.css")%>' rel="stylesheet">
<!-- <link href='<%=cacheBreak("/resources/css/bootstrap-theme.css")%>' rel="stylesheet"> -->
<!-- dataTables.net -->
<link href='<%=cacheBreak("/resources/plugins/dataTables/datatables.min.css")%>' rel="stylesheet">
<link href='<%=cacheBreak("/resources/plugins/dataTables/Responsive-2.2.5/css/responsive.datatables.min.css")%>' rel="stylesheet">
<link href='<%=cacheBreak("/resources/plugins/dataTables/Select-1.3.1/css/select.dataTables.min.css")%>' rel="stylesheet">
<!-- Date widget support -->
<link href='<%=cacheBreak("/resources/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css")%>' rel="stylesheet">
<!-- Autocomplete support -->
<link href='<%=cacheBreak("/resources/css/jquery.autocomplete.css")%>' rel="stylesheet">
<!-- JQuery UI CSS -->
<link href='<%= cacheBreak("/resources/css/jquery-ui.css") %>' rel="stylesheet">
<!-- SmartGuide CSS -->
<link href='<%=cacheBreak("/resources/css/smartguide/smartguide.css")%>' rel="stylesheet">
<link href='<%=cacheBreak("/resources/css/smartguide/custom.css")%>' rel="stylesheet">
