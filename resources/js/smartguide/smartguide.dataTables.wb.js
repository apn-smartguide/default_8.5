
//TODO: refactor as not dependent of WET version

var dataTablesController = { 
	init: function(sgRef) { 
		Modernizr.load( {
			load: [
				basePath + "/default_8.5/resources/plugins/dataTables/DataTables-1.10.21/js/jquery.datatables" + wb.getMode() + ".js",
				basePath + "/default_8.5/resources/plugins/dataTables/Responsive-2.2.5/js/dataTables.responsive" + wb.getMode() + ".js"
			],
			complete: function() {
				$(".wb-tables").trigger("wb-init.wb-tables");
			}
		} );

		$( ".wb-tables" ).on("wb-init.wb-tables", function() {
			//This will be called after the trigger
			// new $.fn.DataTable.Responsive( $(".wb-tables"), {
			// 	details: false
			// });
			$( ".wb-tables" ).find('thead th').css('width', 'auto');
			sgRef.bindEvents([$(this)]);
		});
	},
	
	bindEvents : function(sgRef, context) {
		// WET reinit controls
		$( ".wb-tables", context).trigger("wb-init.wb-tables");

		// rebind on wet datatable event
		$(".wb-tables", context).off("wb-updated.wb-tables").on("wb-updated.wb-tables", function (event) {
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

		$('[name=select_all]', '.wb-tables thead tr th').first().unbind('click').bind('click', function(){
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
		$('input[type="checkbox"]', '.wb-tables tbody').unbind('change').bind('change', function(){
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
		$('[type=radio][name^=d_s]').unbind('click').bind('click', function() { 
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
		