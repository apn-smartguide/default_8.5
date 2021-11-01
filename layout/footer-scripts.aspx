<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<!-- JQuery -->
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery-ui-1.13.0.custom/jquery-ui.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.form.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.bootpag.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.autocomplete.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/inputmask/jquery.inputmask.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.caret-1.5.2.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/jquery/jquery.ba-throttle-debounce.js") %>'></script>

<!-- Boostrap -->
<script src='<%= CacheBreak("/resources/plugins/bootstrap/bootstrap.min.js") %>'></script>
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
<script src='<%= CacheBreak("/resources/js/moment/fr.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/moment/en-ca.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/tinymce/tinymce.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/js-cookie.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/jSignature.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/holder.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/plugins/dataTables/datatables.min.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/RecordRTC.js") %>'></script>

<!-- SmartGuide JS -->
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.tinymce.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.dataTables.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.crud.js") %>'></script>
<script src='<%= CacheBreak("/resources/js/smartguide/smartguide.keepalive.js") %>'></script>

<script type="text/javascript">
	//Manually start SmartGuide
	$(document).ready(function(){
		for(let i=0; i < SMARTGUIDES.length; i++){
			SMARTGUIDES[i].init();
		} 
	});
</script>

<%--<script type="text/javascript">
	var ie = navigator.userAgent.indexOf("MSIE ") > -1 || navigator.userAgent.indexOf("Trident/") > -1;
	if(!ie) {
		<% var path = "/resources/js/smartguide/smartguide.utils.tts.js";%>
	  	document.write("<script src='<%= CacheBreak(path) %>'></scr"+"ipt>");
	} else {
		<% path = "/resources/js/smartguide/smartguide.utils.ttsIE.js";%>
	  	document.write("<script src='<%= CacheBreak(path) %>'></scr"+"ipt>");
	}
</script>--%>
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