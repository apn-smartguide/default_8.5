<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>

<!--[if gte IE 9 | !IE ]><!-->
<!-- JQuery -->
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery-3.6.0.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery-migrate-3.3.2.min.js") %>'></script>
<link href='<%= ResolvePath("/resources/img/favicon.ico") %>' rel="icon" type="image/x-icon">
<link href='<%= ResolvePath("/resources/img/apn_icon.png") %>' rel="icon" sizes="192x192">
<link href='<%= ResolvePath("/resources/img/apn_icon.png") %>' rel="apple-touch-icon">
<!--<![endif]-->
<!--[if lt IE 9]>
<link href='<%= ResolvePath("/resources/img/favicon.ico") %>' rel="shortcut icon" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<![endif]-->
<link href='<%= CacheBreak("/resources/plugins/jquery/jquery.autocomplete.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/jquery/jquery-ui-1.13.0.custom/jquery-ui.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/jquery/jquery-timepicker/jquery.timepicker.css") %>' rel="stylesheet">

<!-- Bootstrap -->
<% if(LayoutEngine.Equals("BS3")) { %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap3/bootstrap.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap3/bootstrap-theme.css") %>' rel="stylesheet">
<% } else if(LayoutEngine.Equals("BS4")) { %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap4/bootstrap.css") %>' rel="stylesheet">
<% } else if(LayoutEngine.Equals("BS5")) { %>
<% } %>
<link href='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap-datepicker/css/bootstrap-datepicker.min.css") %>' rel="stylesheet">

<!-- Fonts -->
<link href='<%= CacheBreak("/resources/fonts/fontawesome-free-5.15.3-web/css/all.min.css") %>' rel="stylesheet">

<!-- Additional -->
<link href='<%= CacheBreak("/resources/css/select2.min.css") %>' rel="stylesheet">
<% if(!WETEnabled) { %>
<link href='<%= CacheBreak("/resources/plugins/dataTables/datatables.min.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/dataTables/Responsive-2.2.9/css/responsive.datatables.min.css") %>' rel="stylesheet">
<link href='<%= CacheBreak("/resources/plugins/dataTables/Select-1.3.3/css/select.dataTables.min.css") %>' rel="stylesheet">
<% } %>

<% if(WETEnabled) { %>
<!-- WET-->
<link href='<%= CacheBreak("/WET/theme-wet-boew/css/theme.css") %>' rel="stylesheet">
<% } %>

<!-- SmartGuide CSS -->
<link href='<%= CacheBreak("/resources/css/smartguide/base.css") %>' rel="stylesheet">
<% if(WETEnabled) { %>
<link href='<%= CacheBreak("/WET/wet-custom.css") %>' rel="stylesheet">
<% } %>
<link href='<%= CacheBreak("/resources/css/smartguide/custom.css") %>' rel="stylesheet">
<noscript>
	<link href='<%= CacheBreak("/WET/wet-boew/css/noscript.min.css") %>' rel="stylesheet">
</noscript>
