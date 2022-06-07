var dataTablesController = {
	sgRef: null,
	ajax_targets: [],
	ajax_counter: 0,
	init: function(sgRef) {
		dataTablesController.sgRef = sgRef;
		sgRef.dataTableInstances = {};
	},
	preDTAjaxCall: function(e) {
		dataTablesController.ajax_counter++;
		dataTablesController.ajax_targets.push(e.target.id);
		$('#loader').fadeIn("fast");
		$(this).fadeTo("slow", 0.33);
	}, 
	postDTAjaxCall: function(e) {
		dataTablesController.ajax_counter--;
		if (dataTablesController.ajax_targets.indexOf(e.target.id) > -1) {
			dataTablesController.ajax_targets = dataTablesController.ajax_targets.filter(function(item) {
				return item !== e.target.id;
			});
			
			$(this).fadeTo("slow", 1);
			$('#loader').fadeOut("fast");
		}
	},

	bindEvents : function(sgRef, context, rebindInitiator) {
		var $form = sgRef.fm;

		$('div.repeat table:not(.wb-tables)').each(function(index, elmt) {
			var table = $(this);
			var repeatDivId = table.closest('div.repeat').attr('id');

			var loadTable = function(){
				$('#loader').fadeIn("fast");
				table.fadeTo(0, 0.2);
				$form.ajaxSubmit({
					crossDomain: false,
					type: 'post',
					iframe:false,
					data : { isAjax : 'true' },
					success: function(data){
						try {
							response = data;
							var responseDiv = $("#sgControls", response);
							var repeatDiv = $('#' + repeatDivId, responseDiv);
							var paginationInfo = $('span.paginationInfo', repeatDiv);
							
							var newTable = $('table.hasPagination', repeatDiv);
							table.empty();
							table.html(newTable.html());

							$('span.paginationInfo', table.parent()).html(paginationInfo.html());
							
							$.each(newTable.prop("attributes"), function() {
								table.attr(this.name, this.value);
							});
							sgRef.bindEvents([repeatDiv]);
						} catch(e) {
							if (console) console.log(e.stack);
						}
						$('#loader').fadeOut("fast");
						table.fadeTo(0, 1.0);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						if (console) {
							console.log('Error: print XMLHttpRequest textStatus and errorThrown');
							console.log(XMLHttpRequest);
							console.log(textStatus);
							console.log(errorThrown);
						}
						$('#loader').fadeOut("fast");
						table.fadeTo(0, 1.0);
					}
				});
			};

			var refreshTable = function()
			{
				//has pagination
				var currentPage = 1;

				var totalPage = parseInt(table.attr('data-total-pages'));
				if ($('input.repeatCurrentPage', table).length > 0){
					currentPage = parseInt($('input.repeatCurrentPage', table).val()) + 1;
				}

				$(elmt).closest('div.bootpag').bootpag({
					total: totalPage,
					page: currentPage,
					maxVisible: 5,
					href: "#pro-page-{{number}}",
					leaps: false,
					wrapClass: 'pagination',
					next: '>',
					prev: '<'
				}).off('page').on('page', function(event, num)
				{
					$('input.repeatCurrentPage', table).val(num -1);
					loadTable();
				});
			};

			$('.sortBtn', this).off('click').on('click', function(){
				var fieldId = $(this).attr('data-field-id');
				var currentSort = $(this).attr('data-sort');
				var sort = '+' + fieldId;
				if (currentSort == 'asc') sort = '-' + fieldId;
				$('input.repeatSort', table).val(sort);
				$('input.repeatCurrentPage', table).val('0');
				$(this).css('color', 'black');
				loadTable();
			});

			$('select.pageSize', $(this).closest('div.repeat')).off('change').on('change', function(){
				$('input.repeatCurrentPage', table).val('0');
				loadTable();
			});
			
			$('.searchBtn', $(this).closest('div.repeat')).off('click').on('click', function(){
				$('input.repeatCurrentPage', table).val('0');
				loadTable();
				refreshTable();
				return false;
			});

			var initDataTable = function(obj) {
				var otable;
				if (typeof elmt == 'undefined' || typeof $.fn.dataTable == 'undefined' || !$.fn.dataTable.isDataTable(elmt)) {
					var gridOption = {};
					var repeatDiv = $(obj).parent().parent();
					if (repeatDiv.hasClass('hide-search')) gridOption['hide-search'] = true;
					if (repeatDiv.hasClass('hide-pagination')) gridOption['hide-pagination'] = true;
					if (repeatDiv.hasClass('selectable')) gridOption['selectable'] = true;
					var dtOptions = {
						"stateSave": true,
						//save state
						stateSaveCallback: function(settings, data) {
							var divId = $(settings.oInstance).closest('div.repeat').attr('id');
							localStorage.setItem( 'DataTables_' + divId, JSON.stringify(data) );
						},
						stateLoadCallback: function(settings) {
							var divId = $(settings.oInstance).closest('div.repeat').attr('id');
							return JSON.parse(localStorage.getItem( 'DataTables_' + divId))
						},
						initComplete: function(settings, json) {
							if (!settings.oFeatures.bPaginate)
								$('.dataTables_info', $(obj).closest('.dataTables_wrapper')).hide();
						},
						"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
						"pageLength": 10,
						"language": dataTableTranslations,
						"autoWidth": false,
						"columnDefs": [
							{ "orderDataType": "dom-text", "targets": "_all", "type": "string"},
							{ "targets": "repeatbutton", "orderable": false , "width": "50px"}
						]
					};
					if (gridOption['hide-search']) dtOptions['searching'] = false;
					if (gridOption['hide-pagination']) dtOptions['paging'] = false;
					if (gridOption['standard-search'] && !gridOption['selectable']) dtOptions['columnDefs'] = [{ "targets": "repeatbutton", "orderable": false , "width": "50px"}];
					if (gridOption['selectable']) dtOptions['order'] = [[ 0, "desc" ]];
					if (repeatDiv.hasClass('hide-sort')) dtOptions['ordering'] = false;
					if (!repeatDiv.hasClass('grid-view')) {
						dtOptions['responsive'] = {
							"details":
							{
								type: "inline", "display": function (row, update, render )
								{
									//Customer rendering the row for responsive design
									var $rowNode = $(row.node());
									var table = $rowNode.closest('table');
									var theader = $('thead', table);
									if ( (! update && row.child.isShown()) || ! row.responsive.hasHidden() ) {
										//Reset for md
										$rowNode.removeClass( 'parent');
										$rowNode.css( 'border', '');
										row.child( false );
										$('th', theader).css({'display':'table-cell'});
										$('td', $rowNode).show().css('display', 'table-cell');
										$('label.responsive', $rowNode).remove();
										return false;
									} else {
										//For Small device
										$rowNode.addClass( 'parent');
										$rowNode.css( 'border', '1px solid #666666');
										$('th', theader).css({'display':'inline-block'});
										$('td', $rowNode).each(function(index){
											if ($('label.responsive', obj).length ==0)
												$(obj).prepend('<label class=\'responsive\'>' + $('th:eq(' + index +') > span', theader).text() + '</label>');
										}).show().css({'display':'inline-block'});
										return true;
									}
								} 
							} 
						};
					}
					//Init DataTables with Options
					var tempOptions = eval('dtOptions_' + $(repeatDiv).attr('id').replace("[","_").replace("]",""));
					if(tempOptions != '') {
						dtOptions = Object.assign(dtOptions, tempOptions);
					}
					otable = $(elmt).show().DataTable(dtOptions);
					sgRef.dataTableInstances[CSS.escape($(repeatDiv).attr('id'))] = otable;
				} else {
					var repeatDiv = $(obj).parent().parent();
					otable = $(elmt).DataTable();
					sgRef.dataTableInstances[CSS.escape($(repeatDiv).attr('id'))] = otable;
				}
				return otable;
			}
			if($(elmt).hasClass('datatables')) {
				var otable = initDataTable(this);
				otable.on('draw.dt', function () {
					sgRef.bindEvents();
				});
			}
			refreshTable();
		});

		// rebind on wet datatable event
		$("table:not(.wb-tables).table :checkbox :radio", context).change(function (event) {
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
			if(rebindInitiator != "dataTablesController") {
				sgRef.bindEvents([$(this)], "dataTablesController");
			}
		});

		$('[name=select_all]', 'table:not(.wb-tables).table thead tr th').first().off('click').on('click', function(){
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

		// Handle click on checkbox to set state of "Select all" control
		$('input[type="checkbox"]', 'table:not(.wb-tables).table tbody').off('change').on('change', function(){
			var dataTable = $(this).closest('table').DataTable();
			var tableId = $(this).closest('.dataTables_wrapper').parents(".repeat").attr('id');
			// If checkbox is not checked
			if(!this.checked){
				var el = $('[name=select_all]', $(this).closest('table')).get(0);
				// If "Select all" control is checked and has 'indeterminate' property
				if(el && el.checked && ('indeterminate' in el)){
					// Set visual state of "Select all" control as 'indeterminate'
					el.indeterminate = true;
				}
			} else {
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
			// check if we are server side, in which case we must post
			if (dataTable.page.info().serverSide) {
				// ajax call to selection aspx file
				var originalAction = $("form").attr('action');
				$("form").attr('action', dataTablesSelections);
				$("form").ajaxSubmit({data:{ appID: smartletName, tableId: tableId }}); 
				$("form").attr('action', originalAction);
			}
		});

		//To support client-side multipage selections
		$('[type=checkbox][name^=d_s]').off('change', sgRef.bindThisAllowSelfRefresh).on('change', sgRef.bindThisAllowSelfRefresh);
		
		// support for selection radios for server side repeats
		$('[type=radio][name^=d_s]').off('click').on('click', function() {
			var dataTable = $(this).closest('table').DataTable();
			var tableId = $(this).closest('.dataTables_wrapper').parents(".repeat").attr('id');
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
				$("form").attr('action', dataTablesSelections);
				$("form").ajaxSubmit({ data: { appID: smartletName, tableId: tableId }}); 
				$("form").attr('action', originalAction);
			}
		});
		
		// Listen on datatable ajax call events
		$('.datatables:not(.wb-tables)').each(function() {
			var input_filter_value;
			var input_filter_timeout=null;

			var table = $(this).DataTable();
			// check if we are server side, if not exit
			if (table.ajax.url() == null) return;

			console.log("datatable main process");

			table.off('preXhr.dt', dataTablesController.preDTAjaxCall).on('preXhr.dt', dataTablesController.preDTAjaxCall);
			table.off('xhr.dt', dataTablesController.postDTAjaxCall).on('xhr.dt', dataTablesController.postDTAjaxCall);

			var search_input = $('.dataTables_filter input', $(this).closest('.dataTables_wrapper'));
			search_input.unbind();
			search_input.keyup( function () {
				var searchtable = $('table', $(this).closest('.dataTables_wrapper')).DataTable();
				input_filter_value=this.value;
				clearTimeout(input_filter_timeout);
				input_filter_timeout=setTimeout(function(){
					searchtable.search(input_filter_value).draw();
				}, 800);
			});
		});
	}
}