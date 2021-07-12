<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<!-- JQuery -->
<script src='<%= CacheBreak("/resources/js/ui/jquery-ui.min.js") %>'></script>
<%-- the following line is to remove the conflict between jquery-ui tooltip and bootstrap tooltip. bootstap will override and be default --%>
<script>$.widget.bridge('uitooltip', $.ui.tooltip);</script>
<!-- Boostrap -->
<script src='<%= CacheBreak("/resources/js/bootstrap4/bootstrap.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/bootstrap4/bootstrap.bundle.min.js") %>'></script>
<!-- Modernizr -->
<script src='<%= CacheBreak("/resources/js/modernizr-custom.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/jquery.form.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/jquery.bootpag.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/jquery.autocomplete.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/inputmask/jquery.inputmask.min.js") %>'></script>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src='<%= CacheBreak("/resources/js/html5shiv.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/respond.min.js") %>'></script>
<![endif]-->
<script src='<%= CacheBreak("/resources/js/getUserMedia-polyfill.js") %>'></script>
<!-- Additional -->
<script src='<%= CacheBreak("/resources/js/moment/moment.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/moment/fr.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/moment/en-ca.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/tinymce/tinymce.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/js-cookie.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/jSignature.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.en-CA.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.fr.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/bootstrap-datetimepicker.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/holder.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/bootstrap-session-timeout.js") %>'></script>
<script src="https://www.WebRTC-Experiment.com/RecordRTC.js"></script>
<!-- SmartGuide JS -->
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.tinymce.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.tables.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.dataTables.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.formatters.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.keepalive.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.crud.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.utils.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/custom.js") %>'></script>
<script>
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
	initToBrowserLocale(currentLocale);	
</script>