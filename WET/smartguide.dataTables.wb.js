var WETdataTablesController = {
	init: function(sgRef) {},
	
	bindEvents : function(sgRef, context) {

		$( ".wb-tables" ).off("wb-init.wb-tables").on("wb-init.wb-tables", function() {
			var id = $(this).parents(".repeat").attr("id");
			if(typeof id !== 'undefined') {
				//console.log("bindEvents:wb-tables (initing) " + id);
				setTimeout(function() {
					sgRef.bindEvents([$("#"+id)], "WETdataTablesController");
				},0);
			}
		});

		$('input[type=date]', context).not("wb-date-inited").each( function () {
			//console.log("bindEvents:wb-date (re-initing) " + this.id);
			$(this).trigger("wb-init.wb-date");
		});

		// rebind on wet datatable event
		$(".wb-tables", context).off("wb-updated.wb-tables").on("wb-updated.wb-tables", function (event) {
			// handle status of select all checkbox if available
			var id = $(this).parents(".repeat").attr("id");
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
					// nothing checked
					el.checked = false;
					el.indeterminate = false;
				}
			}
			
			sgRef.bindEvents([id], "WETdataTablesController");
		});

		$('[name=select_all2]', '.wb-tables thead tr th').first().off('click').on('click', function(){
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

		//TODO: The following is broken, enabling this will reset the datatable on any click of checkboxes
		// Handle click on checkbox to set state of "Select all" control
		$('input[type="checkbox2"]', '.wb-tables tbody').off('change').on('change', function(){
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
		$('[type=radio2][name^=d_s]').off('click').on('click', function() {
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