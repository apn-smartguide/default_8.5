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
			//if (rebindInitiator != "WETdataTablesController") {
				sgRef.bindEvents([$("#" + id)], "WETdataTablesController");
			//}
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

		$('[type=checkbox]', $('.wb-tables tbody', context)).off('change', CheckboxSelections).on('change', CheckboxSelections);

		function CheckboxSelections(completeCallback, event) {
			var $this = $(this);
			var dataTable = $this.closest('table').DataTable();
			var tableId = $this.closest('.dataTables_wrapper').parents(".repeat").attr('id');
			
			//var selectId = CSS.escape($(this).attr('id')); // e.g. d_s1590340615680[5] -  numeric part might be different from repeatId, if using a Proxy
			//var selectName = CSS.escape($(this).attr('name')); //e.g. d_1590340615680 numeric part might be different from repeatId, if using a Proxy
			//var repeatId = CSS.escape($this.data('repeat-id')); //e.g. 1590340615680 - does not contains d_
			var intanceId = CSS.escape($this.data('instance-id')); // e.g. d_s1590340615680[5] - numric part is = to repeatId

			// If checkbox is not checked
			if(!this.checked){
				$('[type=hidden][name=' + intanceId + ']').val(false);
				var el = $('[name=select_all]', $(this).closest('table')).get(0);
				// If "Select all" control is checked and has 'indeterminate' property
				if(el && el.checked && ('indeterminate' in el)){
					// Set visual state of "Select all" control
					// as 'indeterminate'
					el.indeterminate = true;
				}
			} else {
				$('[type=hidden][name=' + intanceId + ']').val(true);
				// must verify if all element on page have been checked
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

			$this.prop('disabled', true);
			$("form").ajaxSubmit({
				url: dataTablesSelections, data: { appID: smartletName, tableId: tableId }, success: function () {
					$this.prop('disabled', false);
					//if (typeof completeCallback !== 'undefined') completeCallback(event);
				}
			});
		}
		
		// support for selection radios for server side repeats
		$('[type=radio]', $('.wb-tables tbody', context)).off('click', RadioSelections).callbackOn('click', RadioSelections);

		function RadioSelections(completeCallback, event) {
			var $this = $(this);
			var tableId = $this.closest('.dataTables_wrapper').parents(".repeat").attr('id');

			//var selectId = CSS.escape($(this).attr('id')); // e.g. d_s1590340615680[5] -  numeric part might be different from repeatId, if using a Proxy
			//var selectName = CSS.escape($(this).attr('name')); //e.g. d_1590340615680 numeric part might be different from repeatId, if using a Proxy
			var repeatId = CSS.escape($this.data('repeat-id')); //e.g. 1590340615680 - does not contains d_
			var intanceId = CSS.escape($this.data('instance-id')); // e.g. d_s1590340615680[5] - numric part is = to repeatId

			$('[type=hidden][name^=d_s' + repeatId + ']').val(false);
			$('[type=hidden][name=' + intanceId + ']').val(true);
			$this.prop('checked', true);
			$this.prop('disabled', true);

			$("form").ajaxSubmit({
				url: dataTablesSelections, data: { appID: smartletName, tableId: tableId }, success: function () {
				$this.prop('disabled', false);
				if (typeof completeCallback !== 'undefined') completeCallback(event);
			}});
		}
	}
}