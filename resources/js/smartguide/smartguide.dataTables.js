
//TODO: refactor as not dependent of WET version

var dataTablesController = { 
	init: function(sgRef) { 
		Modernizr.load( {
			load: [
				basePath + "/default_8.5/resources/plugins/dataTables/DataTables-1.10.21/js/jquery.datatables.js",
				basePath + "/default_8.5/resources/plugins/dataTables/Responsive-2.2.5/js/dataTables.responsive.js"
			],
			complete: function() {
				//$(".wb-tables").trigger("wb-init.wb-tables");
			}
		} );

		//$( ".wb-tables" ).on("wb-init.wb-tables", function() {
			//This will be called after the trigger
			// new $.fn.DataTable.Responsive( $(".wb-tables"), {
			// 	details: false
			// });
			//$( ".wb-tables" ).find('thead th').css('width', 'auto');
			//sgRef.bindEvents([$(this)]);
		//});
	},
	
	bindEvents : function(sgRef, context) {
		// WET reinit controls
		//$( ".wb-tables", context).trigger("wb-init.wb-tables");

		$('button:not(#session-timeout-dialog-keepalive, .repeat_cancel_edit_btn, .repeat_save_edit_btn, :has(span.glyphicon-indent-right, span.glyphicon-indent-left)),' +
		'button:not(#session-timeout-dialog-keepalive, .repeat_cancel_edit_btn, .repeat_save_edit_btn) > span:not(.glyphicon-indent-right, .glyphicon-indent-left), ' + 
		'a:not(.paginate_button), a:not(.paginate_button) > span')
		.click(function () {
			var id = $(this).parent().attr("id");
			
			if(id == undefined || id.indexOf("error_") < 0) {
				var isSGPost = true;
			
				if($(this).is('a')) {
					if($(this).attr("href").indexOf("do.aspx?") < 0) {
						isSGPost = false;
					}
				}
				if(isSGPost) {
					$("#loader").fadeIn("slow");
				}
			}
		});
		
		// rebind on wet datatable event
		$("table.table :checkbox :radio", context).change(function (event) {
			// handle status of select all checkbox if available
			var el = $('[name=select_all]', $(this).closest('table')).get(0);
			if (typeof el != 'undefined') {
				// check status of select all checkbox vs the currently checked rows
				var dataTable = $(this).DataTable();
				var rows = dataTable.rows({ 'page': 'current' }).nodes();
				var totalRows = rows.length;
				// how many checked
				var checkedRows = $('input[type="checkbox"]', rows).filter(':checked').length;

				if (checkedRows == totalRows) {
					el.checked = true;
					el.indeterminate = false;
				} else {
					if (checkedRows > 0) {
						// at least one check, set indeterminate 
						el.checked = true;
						el.indeterminate = true;
					} else {
						// nothing checked
						el.checked = false;
						el.indeterminate = false;					
					}
				}
			}
			
			sgRef.bindEvents([$(this)]);
		});

		$('[name=select_all]', 'table.table thead tr th').first().off('click').on('click', function(){
			var dataTable = $(this).closest('table').DataTable();
			var rows = dataTable.rows({ 'page': 'current' }).nodes();
			// Check/uncheck checkboxes for all rows in the table
			$('input[type="checkbox"]', rows).prop('checked', this.checked);
			// check if we are server side, in which case we must post
			if (dataTable.page.info().serverSide) {
				var tableId = $(this).closest('.dataTables_wrapper').parent().attr('id');
				// ajax call to selection aspx file
				var originalAction = $("form").attr('action');
				$("form").attr('action', basePath.toString() + "/controls/repeats/datatables-selection.aspx");
				$("form").ajaxSubmit({data:{ appID: smartletName, tableId: tableId }}); 
				$("form").attr('action', originalAction);
			}
		});

		// Handle click on checkbox to set state of "Select all" control
		$('input[type="checkbox"]', 'table.table tbody').off('change').on('change', function(){
			var dataTable = $(this).closest('table').DataTable();
			
			// If checkbox is not checked
			if(!this.checked){
				var el = $('[name=select_all]', $(this).closest('table')).get(0);
				// If "Select all" control is checked and has 'indeterminate' property
				if(el && el.checked && ('indeterminate' in el)){
					// Set visual state of "Select all" control
					// as 'indeterminate'
					el.indeterminate = true;
				}
			} else {
				// must verify if all element on page have been checked
				var dataTable = $(this).closest('table').DataTable();
				var rows = dataTable.rows({ 'page': 'current' }).nodes();
				var totalRows = rows.length;
				// how many checked
				var checkedRows = $('input[type="checkbox"]', rows).filter(':checked').length;
				if (checkedRows == totalRows) {
					var el = $('[name=select_all]', $(this).closest('table')).get(0);
					el.checked = true;
					el.indeterminate = false;
				}
			}
			// check if we are server side, in which case we must post
			if (dataTable.page.info().serverSide) {
				var tableId = $(this).closest('.dataTables_wrapper').parent().attr('id');
				// ajax call to selection aspx file
				var originalAction = $("form").attr('action');
				$("form").attr('action', basePath.toString() + "/controls/repeats/datatables-selection.aspx");
				$("form").ajaxSubmit({data:{ appID: smartletName, tableId: tableId }}); 
				$("form").attr('action', originalAction);
			}
		});
		
		// support for selection radios for server side repeats
		$('[type=radio][name^=d_s]').off('click').on('click', function() { 
			var dataTable = $(this).closest('table').DataTable();

			// unselect all, then just re-selects our instance (e.g. d_s1590340615680[5])
			var id = $(this).attr('id');
			id = id.substring(0, id.indexOf("["));
			if (dataTable.page.info().serverSide) {
				$('[type=radio][name^='+id+']').prop('checked', false);
			} else {
				// client side must fetch all radios
				var rows = dataTable.rows({ 'page': 'all' }).nodes();
				$('[type=radio][name^='+id+']', rows).prop('checked', false);
			}
			$(this).prop('checked', true);
			
			// check if we are server side, in which case we must post
			if (dataTable.page.info().serverSide) {
				var originalAction = $("form").attr('action');
				$("form").attr('action', basePath.toString() + "/controls/repeats/datatables-selection.aspx");
				$("form").ajaxSubmit({data:{ appID: smartletName, tableId: $(this).attr('id') }}); 
				$("form").attr('action', originalAction);
			}
		});
	}
}
		