<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<!--[if gte IE 9 | !IE ]><!-->
<link href='<%= ResolvePath("/resources/img/favicon.ico") %>' rel="icon" type="image/x-icon">
<link href='<%= ResolvePath("/resources/img/apn_icon.png") %>' rel="icon" sizes="192x192">
<link href='<%= ResolvePath("/resources/img/apn_icon.png") %>' rel="apple-touch-icon">
<!--<![endif]-->
<link href='<%= CacheBreak("/resources/plugins/jquery/jquery.autocomplete.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/jquery/jquery-ui-1.13.0.custom/jquery-ui-draggable.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/jquery/jquery-timepicker/jquery.timepicker.css") %>' rel="stylesheet">

<!-- Bootstrap -->
<% if(LayoutEngine.Equals("BS3") && !Options.Contains("CDTS")) { %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap3/bootstrap.css") %>' rel="stylesheet">
	<% if(Options.Contains("boootstrap-theme")) { %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap3/bootstrap-theme.css") %>' rel="stylesheet">
	<% } %>
<% } else if(LayoutEngine.Equals("BS4") && !Options.Contains("CDTS")) { %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap4/bootstrap.min.css") %>' rel="stylesheet">
<% } else if(LayoutEngine.Equals("BS5") && !Options.Contains("CDTS")) { %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap5/css/bootstrap.min.css") %>' rel="stylesheet">
<% } %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap-datepicker/css/bootstrap-datepicker.min.css") %>' rel="stylesheet">

<!-- Fonts -->
<link href='<%= CacheBreak("/resources/fonts/fontawesome-free-5.15.3-web/css/all.min.css") %>' rel="stylesheet">

<!-- Additional -->
<link href='<%= CacheBreak("/resources/plugins/select2/css/select2.min.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/select2/css/select2-bootstrap4.min.css") %>' rel="stylesheet">
<% if(!Options.Contains("WET") || !Options.Contains("CDTS")) { %>
<link href='<%= CacheBreak("/resources/plugins/dataTables/datatables.min.css") %>' rel="stylesheet">
<%--<link href='<%= CacheBreak("/resources/plugins/dataTables/Responsive-2.2.9/css/responsive.datatables.min.css") %>' rel="stylesheet">--%>
<%--<link href='<%= CacheBreak("/resources/plugins/dataTables/Select-1.3.3/css/select.dataTables.min.css") %>' rel="stylesheet">--%>
<% } %>
<% if(Options.Contains("ARCGIS")) { %>
<link href="https://js.arcgis.com/4.20/esri/themes/light/main.css" rel="stylesheet">
<% } %>

<% if(Options.Contains("WET") && !Options.Contains("CDTS")) { %>
<!-- WET-->
<link href='<%= CacheBreak("/resources/WET/theme-wet-boew/css/theme.css") %>' rel="stylesheet">
<% } %>

<!-- SmartGuide CSS -->
<link href='<%= CacheBreak("/resources/css/smartguide/base.css") %>' rel="stylesheet">
<% if(Options.Contains("WET") && !Options.Contains("CDTS")) { %>
<link href='<%= CacheBreak("/resources/WET/wet-custom.css") %>' rel="stylesheet">
<% } %>
<link href='<%= CacheBreak("/resources/css/smartguide/custom.css") %>' rel="stylesheet">
<noscript>
	<link href='<%= CacheBreak("/resources/WET/wet-boew/css/noscript.min.css") %>' rel="stylesheet">
</noscript>
