var tablesController = { 
	init: function(sgRef) { 

	},
	
	bindEvents : function(sgRef, context) {
		var r = sgRef;
		var $form = sgRef.fm;
		// main binding event to transform repeat group structure into datatable
		r.dataTableInstances = {};
		$('div.repeat table').each(function(index, elmt) {
			var table = $(this);
			var repeatDivId = table.closest('div.repeat').prop('id');
			if ($('#'+repeatDivId).hasClass('repeatblock')) return true;
			var loadTable = function(){
				$('#loader').show();
				table.fadeTo(0, 0.2);
				$form.ajaxSubmit({
					crossDomain: false,
					type: 'post',
					iframe:false,
					data : { isAjax : 'true' },
					success:  function(data){
						try {
							response = data;
							var responseDiv = $("div#sgControls", response);
							var repeatDiv = $('div#' + repeatDivId, responseDiv);
							var paginationInfo = $('span.paginationInfo', repeatDiv);
							
							var newTable = $('table.hasPagination', repeatDiv);
							table.empty();
							table.html(newTable.html());
							$('span.paginationInfo', table.parent()).html(paginationInfo.html());
							
							$.each(newTable.prop("attributes"), function() {
								table.attr(this.name, this.value);
							});
							r.bindEvents([repeatDiv]);
						} catch(e) {
							if (console) console.log(e.stack);
						}
						$('#loader').hide();
						table.fadeTo(0, 1.0);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						if (console) {
							console.log('Error: print XMLHttpRequest textStatus and errorThrown');
							console.log(XMLHttpRequest);
							console.log(textStatus);
							console.log(errorThrown);
						}
						$('#loader').hide();
						table.fadeTo(0, 1.0);
					}
				});
			};
			var refreshTable = function(){
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
				}).off('page').on('page', function(event, num){
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
			if ($(elmt).hasClass('hasPagination')) {
				table.addClass('table responsive table-striped table-hover no-footer dtr-inline collapsed');
				table.css('margin-bottom', 0);
				refreshTable();
			} else {
				//no pagination, use datatable for client pagination
				try {
					if (!$.fn.dataTable.isDataTable('#' + $(elmt).closest('div.repeat').attr('id') )) {
						var gridOption = {};
						var repeatDiv = $(this).parent().parent();
						if (repeatDiv.hasClass('hide-search')) gridOption['hide-search'] = true;
						if (repeatDiv.hasClass('hide-pagination')) gridOption['hide-pagination'] = true;
						if (repeatDiv.hasClass('grid-view')) gridOption['standard-search'] = true;
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
									$('.dataTables_info', $(this).closest('.dataTables_wrapper')).hide();
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
							dtOptions['responsive'] = { "details": { type: "inline", "display": function (row, update, render ) {
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
											if ($('label.responsive', this).length ==0)
												$(this).prepend('<label class=\'responsive\'>' + $('th:eq(' + index +') > span', theader).text() + '</label>');
										}).show().css({'display':'inline-block'});
										return true;
									}
								} } };
						}
						
						var otable = $(elmt).show().DataTable(dtOptions);
						// hook onto paging and filtering events
						otable.on('draw.dt', function () {
							r.bindEvents();
						} );

						r.dataTableInstances[$(repeatDiv).attr('id')] = otable;
					} else {
						var repeatDiv = $(this).parent().parent();
						var otable = $(elmt).DataTable();
						r.dataTableInstances[$(repeatDiv).attr('id')] = otable;
					}
				} catch(e) {
					if (console)
						console.log(e.stack);
				}
			}
		});
	}
}
		