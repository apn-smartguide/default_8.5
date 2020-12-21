<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<!-- Boostrap -->
<script src='<%= cacheBreak("/resources/js/bootstrap.js") %>'></script>
<!-- Modernizr -->
<script src='<%= cacheBreak("/resources/js/modernizr-custom.js") %>'></script>
<!-- JQuery -->
<script src='<%= cacheBreak("/resources/js/ui/jquery-ui.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/jquery.form.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/jquery.bootpag.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/jquery.autocomplete.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/inputmask/jquery.inputmask.js") %>'></script>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src='<%= cacheBreak("/resources/js/html5shiv.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/respond.min.js") %>'></script>
<![endif]-->
<script src='<%= cacheBreak("/resources/js/getUserMedia-polyfill.js") %>'></script>
<!-- Additional -->
<script src='<%= cacheBreak("/resources/js/moment/moment.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/moment/fr.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/moment/en-ca.js") %>'></script>
<script src='<%= cacheBreak("/resources/plugins/tinymce/tinymce.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/js-cookie.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/jSignature.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js") %>'></script>
<script src='<%= cacheBreak("/resources/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.en-CA.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.fr.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/bootstrap-datetimepicker.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/holder.min.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/bootstrap-session-timeout.js") %>'></script>
<script src="https://www.WebRTC-Experiment.com/RecordRTC.js"></script>
<!-- SmartGuide JS -->
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.tinymce.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.tables.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.dataTables.wb.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.formatters.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.keepalive.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/smartguide.crud.js") %>'></script>
<script src='<%= cacheBreak("/resources/js/smartguide/custom.js") %>'></script>
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