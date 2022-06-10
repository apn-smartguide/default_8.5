var WETdataTablesController = {
	init: function(sgRef) {},
	
	bindEvents: function (sgRef, context, rebindInitiator) {

		$( ".wb-tables", context ).off("wb-init.wb-tables").on("wb-init.wb-tables", function() {
			var id = $(this).parents(".repeat").attr("id");
			if(typeof id !== 'undefined') {
				//console.log("bindEvents:wb-tables (initing) " + id);
				setTimeout(function (rebindInitiator) {
					if (rebindInitiator != "WETdataTablesController") {
						sgRef.bindEvents([$("#"+id)], "WETdataTablesController");
					}
				},0);
			}
		});

		$('.datatables.wb-tables:not(.wb-tables-inited)', context).each(function () {
			if (rebindInitiator != "WETdataTablesController") {
				$(this).trigger("wb-init.wb-tables");
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
			if (rebindInitiator != "WETdataTablesController") {
				sgRef.bindEvents([id], "WETdataTablesController");
			}
		});

		$('[name=select_all]', '.wb-tables thead tr th').first().off('click').on('click', function(){
			var dataTable = $(this).closest('table').DataTable();
			var tableId = $(this).closest('.dataTables_wrapper').parents(".repeat").attr('id');
			var rows = dataTable.rows({ 'page': 'current' }).nodes();
			// Check/uncheck checkboxes for all rows in the table
			$('input[type="checkbox"]', rows).prop('checked', this.checked);
			// check if we are server side, in which case we must post
			if (dataTable.page.info().serverSide) {
				// ajax call to selection aspx file
				var originalAction = $("form").attr('action');
				$("form").attr('action', dataTablesSelections);
				$("form").ajaxSubmit({data:{ appID: smartletName, tableId: tableId }});
				$("form").attr('action', originalAction);
			}
		});

		//TODO: The following is broken, enabling this will reset the datatable on any click of checkboxes
		// Handle click on checkbox to set state of "Select all" control
		$('input[type="checkbox"]', '.wb-tables tbody').off('change').on('change', function(){
			var dataTable = $(this).closest('table').DataTable();
			var tableId = $(this).closest('.dataTables_wrapper').parents(".repeat").attr('id');

			var hiddenName = $(this).attr('id');
			//var inputName = hiddenName.substring(0, hiddenName.indexOf("[")).replace("d_s", "d_");

			
			
			// If checkbox is not checked
			if(!this.checked){
				$('[type=hidden][name=' + CSS.escape(hiddenName) + ']').val(false);
				var el = $('[name=select_all]', $(this).closest('table')).get(0);
				// If "Select all" control is checked and has 'indeterminate' property
				if(el && el.checked && ('indeterminate' in el)){
					// Set visual state of "Select all" control
					// as 'indeterminate'
					el.indeterminate = true;
				}
			} else {
				$('[type=hidden][name=' + CSS.escape(hiddenName) + ']').val(true);
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
				// ajax call to selection aspx file
				var originalAction = $("form").attr('action');
				$("form").attr('action', dataTablesSelections);
				$("form").ajaxSubmit({data:{ appID: smartletName, tableId: tableId }});
				$("form").attr('action', originalAction);
			}
		});
		
		
		// support for selection radios for server side repeats
		$('[type=radio]', $('.wb-tables tbody', context)).off('click', RadioSelections).callbackOn('click', RadioSelections);

		function RadioSelections(completeCallback, event) {
			var $this = $(this);
			var dataTable = $(this).closest('table').DataTable();
			var tableId = $(this).closest('.dataTables_wrapper').parents(".repeat").attr('id');

			// unselect all, then just re-selects our instance (e.g. d_s1590340615680[5])
			var id = $(this).attr('id');
			var hiddenName = id.substring(0, id.indexOf("["));
			var inputName = id.substring(0, id.indexOf("[")).replace("d_s", "d_");
			if (dataTable.page.info().serverSide) {
				$('[type=radio][name^=' + inputName + ']').prop('checked', false);
			} else {
				// client side must fetch all radios
				var rows = dataTable.rows({ 'page': 'all' }).nodes();
				$('[type=radio][name^=' + inputName + ']', rows).prop('checked', false);
			}
			$('[type=hidden][name^=' + hiddenName + ']').val(false);
			$('[type=hidden][name=' + CSS.escape(id) + ']').val(true);
			$(this).prop('checked', true);
			$(this).prop('disabled', true);

			// check if we are server side, in which case we must post
			//if (dataTable.page.info().serverSide) {
			//var originalAction = $("form").attr('action');
			//$("form").attr('action', dataTablesSelections);

			$("form").ajaxSubmit({
				url: dataTablesSelections, data: { appID: smartletName, tableId: tableId }, success: function () {
				//$("form").attr('action', originalAction);
				$this.prop('disabled', false);
				if (completeCallback) completeCallback(event);
			}});

			//}
		}
	}
}