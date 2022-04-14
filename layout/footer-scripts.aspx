<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<% if(Options.Contains("WET") && !Options.Contains("CDTS")) { %>
<!-- WET-BOEW -->
<script src='<%= CacheBreak("/resources/WET/wet-boew/js/wet-boew.min.js") %>'></script>
<% } %>

<!-- JQuery -->
<% if(LayoutEngine.Equals("BS3")) { %>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery-ui-1.13.0.custom/jquery-ui.min.js") %>'></script>
<% } else if(LayoutEngine.Equals("BS4")) { %>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery-ui-1.13.0.custom/jquery-ui-draggable.min.js") %>'></script>
<% } %>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.form.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.bootpag.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.autocomplete.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/inputmask/jquery.inputmask.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.caret-1.5.2.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.ba-throttle-debounce.js") %>'></script>

<!-- Bootstrap -->
<% if(LayoutEngine.Equals("BS3")) { %>
<script src='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap3/bootstrap.min.js") %>'></script>
<% } else if(LayoutEngine.Equals("BS4")) { %>
<%-- <script src='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap4/bootstrap.min.js") %>'></script> --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap4/bootstrap.bundle.min.js") %>'></script>
<% } else if(LayoutEngine.Equals("BS5")) { %>
<% } %>
<script src='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap-session-timeout.js") %>'></script>

<!-- Additional -->
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src='<%= CacheBreak("/resources/js/polyfill/html5shiv.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/polyfill/respond.min.js") %>'></script>
<![endif]-->
<script src='<%= CacheBreak("/resources/js/polyfill/getUserMedia-polyfill.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/polyfill/css.escape.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/moment/moment.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/moment/locale.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/tinymce/tinymce.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/js-cookie.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/jSignature.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/holder.min.js") %>'></script>
<% if(Options.Contains("TTS")) { %>
<script src='<%= CacheBreak("/resources/js/RecordRTC.js") %>'></script>
<% } %>
<script src='<%= CacheBreak("/resources/js/select2.full.min.js") %>'></script>
<% if(!Options.Contains("WET") && !Options.Contains("CDTS")) { %>
<script src='<%= CacheBreak("/resources/plugins/dataTables/datatables.min.js") %>'></script>
<%--<script src='<%= CacheBreak("/resources/plugins/dataTables/DataTables-1.11.3/js/jquery.datatables.js") %>'></script>--%>
<%--<script src='<%= CacheBreak("/resources/plugins/dataTables/Responsive-2.2.9/js/dataTables.responsive.js") %>'></script>--%>
<% } %>
<% if(Options.Contains("ARCGIS")) { %>
<script src="https://js.arcgis.com/4.20/"></script>
<% } %>

<!-- SmartGuide JS -->
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.tinymce.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.dataTables.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.crud.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.keepalive.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.utils.js") %>'></script>
<% if(Options.Contains("TTS")) { %>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.utils.tts.js") %>'></script>
<% } %>
<script src='<%= CacheBreak("/resources/js/smartguide/custom.js") %>'></script>
<% if(Options.Contains("WET") && !Options.Contains("CDTS")) { %>
<script src='<%= CacheBreak("/resources/WET/smartguide.dataTables.wb.js") %>'></script>
<% } %>
<script type="text/javascript">
	var dataTableTranslations = {
		'zeroRecords': '<apn:localize runat="server" key="theme.text.datatable.zeroRecords"/>',
		'infoEmpty': '<apn:localize runat="server" key="theme.text.datatable.infoEmpty"/>',
		'emptyTable': '<apn:localize runat="server" key="theme.text.datatable.emptyTable"/>',
		'search': '<apn:localize runat="server" key="theme.text.datatable.search"/>',
		'lengthMenu': '<apn:localize runat="server" key="theme.text.datatable.lengthMenu"/>',
		'info': '<apn:localize runat="server" key="theme.text.datatable.info"/>',
		'paginate': {
			'next': '<apn:localize runat="server" key="theme.text.datatable.paginate.next"/>',
			'previous': '<apn:localize runat="server" key="theme.text.datatable.paginate.previous"/>'
		}
	};
	var crudModalsTranslations = {
		'discardChanges': $("<div>").html('<apn:localize runat="server" key="theme.text.modals.discardChanges"/>').text(),
		'deleteRow': $("<div>").html('<apn:localize runat="server" key="theme.text.modals.deleteRow"/>').text()
	};
	<% if (Options.Contains("WET")) { %>
	wb.doc.on("wb-ready.wb", function (event) {
		for (let smartlet in SMARTGUIDES) {
			SMARTGUIDES[smartlet].init();
		}
	});
	<% } else { %>
	$(document).ready(function () {
		for (let smartlet in SMARTGUIDES) {
			SMARTGUIDES[smartlet].init();
		}
	});
	<% } %>
	<% if (!IsLogged()) { %>
		backgroundKeepAlive('<%= ResolvePath("/handlers/keepalive.ashx") %>', 30 * 1000);
	<% } %>
	initToBrowserLocale(currentLocale);
	<% if (ShouldNavigateToFriendlyURL) { %>
		ReplaceUrl('<%=CurrentPage.getTitle()%>', '<%=FriendlyURL%>');
	<% } %>
	<%=Context.Items["javascript"] %>
	$("#loader").fadeOut("slow");
</script>