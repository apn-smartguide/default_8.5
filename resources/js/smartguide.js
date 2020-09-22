/*
	js file for each form, stored in SMARTGUIDES global variable
*/
if (typeof SMARTGUIDES === 'undefined') SMARTGUIDES = {};

$("form[id^='smartguide_']" ).each(function() {
	var smartletCode = $(this).attr('id').replace('smartguide_','');
	var $form = $(this);
	SMARTGUIDES[smartletCode] = {
		fm: $('form#smartguide_'+smartletCode)
		,posted: false
		,dataTableInstances : {}
		,addScrollLock: function() {
			var $body = $('body');
			var curScrollLockCount = 0;
			if($body.attr('scrolllock-count')) curScrollLockCount = parseInt($body.attr('scrolllock-count'));
			curScrollLockCount = curScrollLockCount + 1;
			$body.attr('scrolllock-count', curScrollLockCount);
			if(!$body.hasClass('modal-open')) $body.addClass('modal-open');
		}
		,removeScrollLock: function(){
			var $body = $('body');
			var curScrollLockCount = 0;
			if($body.attr('scrolllock-count')) curScrollLockCount = parseInt($body.attr('scrolllock-count'));			
			if(parseInt(curScrollLockCount) == 1) {
				$body.removeClass('modal-open');
				$body.removeAttr('scrolllock-count');
			} else if(parseInt(curScrollLockCount)>1){
				curScrollLockCount = curScrollLockCount - 1;
				$body.attr('scrolllock-count', curScrollLockCount);
			}
		}
		,init: function(){
			// This section is for code that must be run once after the page is loaded
			$(document).ready(function(){
				var r = SMARTGUIDES[smartletCode];
				
				//init tooltip
				$('[data-toggle="tooltip"]').tooltip();
				
				//make help window dragable
				$('.modal-dialog', r.fm).draggable({
					handle: ".modal-header"
				});
				
				// Disable buttons after submitting the SMARTGUIDE form to prevent double submissions
				$('button, input[type="button"], input[type="submit"], input[type="image"]', r.fm).click(r._baseDoubleClickHandler);

				//Smartlet events
				r._bindOrTriggerSmartletAndPageEvent();
				
				// invoke custom init methods
				customJS.init(r);
				
				// call the main bind events function
				r.bindEvents(); 
				
				// reinit paging length of datatables
				for(var i=0;i<Object.keys(r.dataTableInstances).length;i++) {
					r.dataTableInstances[Object.keys(r.dataTableInstances)[i]].rows().nodes().page.len(10).draw(false);
				}
			});
		}
		, _baseDoubleClickHandler : function(e) {
			// check if button should be excluded from double click restriction
			if (!$(this).hasClass("always-enabled")) {
				// use flag to determine if we allow submit
				e.preventDefault();
				var r = SMARTGUIDES[smartletCode];
				if (!r.posted) {
					// Also take the opportunity to append the datatable data, if they exist on the page
					for(var i=0;i<Object.keys(r.dataTableInstances).length;i++) {
						r.dataTableInstances[Object.keys(r.dataTableInstances)[i]].rows().nodes().page.len(-1).draw(false);
					}
					
					$(this).prop('disabled', true);
					r.posted = true;
					// SmartGuide requires the name and value of the button used to submit the form
					r.fm.append($('<input/>', {
						type: 'hidden',
						name: this.name,
						value: this.value
					})).submit();
				} else {
					if (console)
						console.log("Waiting for first post to complete...");
				}
			}
			return false;
		}
		, _doubleClickHandler : function(e) {
			// check if button should be excluded from double click restriction
			if (!$(this).hasClass("always-enabled")) {
				// use flag to determine if we allow submit
				e.preventDefault();
				var r = SMARTGUIDES[smartletCode];
				
				if (!r.posted) {
					// Also take the opportunity to append the datatable data, if they exist on the page
					for(var i=0;i<Object.keys(r.dataTableInstances).length;i++) {
						r.dataTableInstances[Object.keys(r.dataTableInstances)[i]].rows().nodes().page.len(-1).draw(false);
					}
					$(this).prop('disabled', true);
					
					r.posted = true;
					// SmartGuide requires the name and value of the button used to submit the form
					r.fm.submit();
				} else {
					if (console)
						console.log("Waiting for first post to complete...");
				}
			}
			return false;
		}
		, _bindOrTriggerSmartletAndPageEvent : function(){
			//trigger EVENT_ON_INIT_SMARTLET, EVENT_ON_ENTER_PAGE, bind  EVENT_ON_EXIT_PAGE
			var r = SMARTGUIDES[smartletCode];
			var $body = $('body');
			if (typeof smartletfields['smartlet'] !== 'undefined') {
				var events = smartletfields['smartlet'].events;
				if (events !== null) {
					//bind event to body
					var r = SMARTGUIDES[smartletCode];
					var smartlet = r._createSmartletContext(null, null, null);
					$body.data('_smartlet', smartlet);
					for(var event in events) {
						var jqEvent = event.toLowerCase();
						var handler = r._createEventHandler(events[event].client);
						if (jqEvent.indexOf("event_on_init_smartlet") == 0) {
							$body.bind('smartlet:init', handler);
						} else if (jqEvent.indexOf("event_on_enter_page") == 0) {
							$body.bind('smartlet:page_enter', handler);
						} else if (jqEvent.indexOf("event_on_exit_page") == 0) {
							$body.bind('smartlet:page_exit', handler);
							$(window).unbind('beforeunload').bind('beforeunload', function(e){
								$body.triggerHandler('smartlet:page_exit');
							});
						}
					}
				}
			}
			//Page event
			if (typeof smartletfields['page'] !== 'undefined') {
				var events = smartletfields['page'].events;
				if (events !== null) {
					// make sure the smartlet object is available on the body for page events
					if (typeof $body.data('_smartlet') == 'undefined') {
						var r = SMARTGUIDES[smartletCode];
						var smartlet = r._createSmartletContext(null, null, null);
						$body.data('_smartlet', smartlet);						
					}
					for(var event in events) {
						if (!events[event].server) {
							var jqEvent = event.toLowerCase();
							var handler = r._createEventHandler(events[event].client);
							if (jqEvent.indexOf("onpageinit") == 0) {
								$body.bind('page:init', handler);
							} else if (jqEvent.indexOf("onpagerender") == 0) {
								$body.bind('page:render', handler);
							}
						}
					}
				}
			}
			$body.triggerHandler('smartlet:init');
			$body.triggerHandler('page:init');
			$body.triggerHandler('smartlet:page_enter');
			$body.triggerHandler('page:render');
		}
		, bindEvents : function(ajaxUpdates) {
			var r = SMARTGUIDES[smartletCode];
			// initialisation code for datatables; base sorting and searching capabilities
			if (typeof $.fn.dataTable !== 'undefined') {
				$.fn.dataTable.ext.order['dom-text'] = function  ( settings, col )
				{
					return this.api().column( col, {order:'index'} ).nodes().map( function ( td, i ) {
						if ($('input[type=radio]', td).length > 0) {
							return $('input:checked',td).val();
						}
						if ($('input[type=checkbox]', td).length > 0) {
							return $('input[type=checkbox]:checked',td).val();
						}
						if ($('input', td).length > 0) {
							return $('input', td).val();
						}
						if ($('select', td).length > 0) {
							return $('select', td).val();
						}
						
						return $.trim($(td).text());
					} );
				}
				$.fn.dataTable.ext.search.length = 0;
				$.fn.dataTable.ext.search.push(
				function( settings, data, dataIndex, rowData, counter ) {
					var filter = $('.dataTables_filter input').val();
					if (filter === "") return true;
					for(var i=0;i<data.length;i++) {
						// filter text value. selection option or checkbox
						var text = "";
						try {
							var parentDiv = $(data[i]);
							//data is not live data, get live data by control name
							$('input[type=text]', parentDiv).each(function(){
								text += ' | ' + $("input[name='"+this.name+"']").val();
							});
							$('input[type=checkbox], input[type=radio]', parentDiv).each(function(){
								$("input[name='"+$(this).attr('name') +"']").each(function(){
									if (typeof (this.value) !== 'undefined'&& $(this).is(':checked')) 
										text += ' | ' + this.value;
								});
							});
							if(text === "")
							{
								text = $(data[i]).text();
							}
							if(text === "")
							{
								text = data[i];
							}
						} catch (e){//invalid xml
							text = data[i];
						}
						//ignore case
						if (text.toLowerCase().indexOf(filter.toLowerCase()) > -1) return true;
					}
					return false;
				});
			}
			/**** CRUD grid view ****/
			//bind before datatable
			// repeat prepare add
			$('button.repeat_prepare_add_btn', $form).unbind('click').bind('click', function() {
				var level = $(this).attr('data-level');
				$('.crud-modal'+level, $form).modal('hide').data('modal', null).remove();
				var newinput = '<input type="hidden" name="'+this.id+'" id="'+this.id+'" value="'+this.id+'" />';
				$(this).after(newinput);
				r.ajaxProcess(this,null,true, 
					function(){
						var modal =  $('.crud-modal'+level, $form);
						// Clear any validation errors that might have appeared
						$('.alert', modal).html('').hide();
						modal.data('data', $('input,textarea,select', modal).serialize());
						modal.modal({backdrop: 'static', keyboard: false});
						$('[data-toggle="tooltip"]', modal).tooltip();
						modal.on('hide.bs.modal', function (e) {
							var cancelBtn = $('button.btn.repeat_cancel_add_btn', this);
							var newinput = '<input type="hidden" name="'+cancelBtn[0].id+'" id="'+cancelBtn[0].id+'" value="'+cancelBtn[0].id+'" />';
							$(cancelBtn[0]).after(newinput);
							r.ajaxProcess(cancelBtn[0],null,true);
						});
						
						$('.crud-modal'+level+' .modal-content', $form).draggable({
						  handle: ".modal-header"
						});
						$('.hide-from-add-view', '.crud-modal'+level).parent().hide();
						$('input:visible:first', '.crud-modal'+level).focus();
					}
				);
			});
			// repeat save added instance
			$('button.repeat_save_add_btn', $form).unbind('click').bind('click', function(e) {
				//onAddInstance
				var level = $(this).attr('data-level');
				var $this = $(this);
				var tableDiv = $this.closest('div.repeat');
				var f = tableDiv.triggerHandler('repeat:addinstance');
				if (typeof f !== 'undefined' && f === false) {
					e.stopImmediatePropagation();
					return false;
				}
				$('.crud-modal'+level, $form).off('hide.bs.modal');
				var newinput = '<input type="hidden" name="'+this.id+'" id="'+this.id+'" value="'+this.id+'"/>';
				$this.before(newinput);
				$this.prop('disabled', true);
				r.ajaxProcess(this,null,true, 
					function(updatedEles){
						$('div#alerts', $form).hide();
						var hasModal = false;
						if (updatedEles && updatedEles.length >0){
							for (var i=0;i<updatedEles.length; i++){
								if (updatedEles[i].hasClass('modal-body')) hasModal = true;
							}
						}
						if (!hasModal){
							//no modal in updated eles, add succesfully, close modal
							$('.crud-modal'+level, $form).modal('hide').data('modal', null).remove();
							//show main alert
							$('div#alerts', $form).show();
						}
						$this.prop('disabled', false);
						$('.hide-from-add-view', '.crud-modal'+level).parent().hide();
					}
				);
			});
			//cancel add
			$('button.repeat_cancel_add_btn', $form).unbind('click').bind('click', function() {
				var level = $(this).attr('data-level');
				var modal =  $('.crud-modal'+level, $form);
				if (modal.data('data') != $('input,textarea,select', modal).serialize()){
					//confirm discard modification
					if (confirm(crudModalsTranslations.discardChanges)) return;
				}
				modal.off('hide.bs.modal');
				var newinput = '<input type="hidden" name="'+this.id+'" id="'+this.id+'" value="'+this.id+'" />';
				$(this).after(newinput);
				r.ajaxProcess(this,null,true);
				$('.crud-modal'+level, $form).modal('hide').data('modal', null).remove();
			});
			//repeat prepare edit instance
			$('.repeat_prepare_edit_btn', $form).unbind('click').bind('click', function() {
				var level = $(this).attr('data-level');
				$('.crud-modal'+level, $form).modal('hide').data('modal', null).remove();
				var rpt = $(this).attr('data-repeat-index-name');
				var count = $(this).attr('data-instance-pos');
				$('input[name='+rpt.replace("[","\\[").replace("]","\\]")+']').val(count);				
				var basename = this.id.substring(0,this.id.lastIndexOf("_"));
				$('#'+this.id.replace("[","\\[").replace("]","\\]")).after('<input type="hidden" name="'+basename+'" id="'+basename+'" value="'+basename+'" />');								
				r.ajaxProcess(this, 'input[name='+rpt.replace("[","\\[").replace("]","\\]")+']',true, 
					function(){
						var modal =  $('.crud-modal'+level, $form);
						// Clear any validation errors that might have appeared
						$('.alert', modal).html('').hide();
						modal.data('data', $('input,textarea,select', modal).serialize());
						$('.crud-modal'+level, $form).modal({backdrop: 'static', keyboard: false});
						$('[data-toggle="tooltip"]', modal).tooltip();
						$('.crud-modal'+level, $form).on('hide.bs.modal', function (e) {
							var cancelBtn = $('button.btn.repeat_cancel_edit_btn', this);
							var newinput = '<input type="hidden" name="'+cancelBtn[0].id+'" id="'+cancelBtn[0].id+'" value="'+cancelBtn[0].id+'" />';
							$(cancelBtn[0]).after(newinput);
							r.ajaxProcess(cancelBtn[0],null,true);
						});
						$('.crud-modal'+level+' .modal-content', $form).draggable({
						  handle: ".modal-header"
						});
						$('.hide-from-edit-view', '.crud-modal'+level).parent().hide();
						$('input:visible:first', '.crud-modal'+level).focus();
					}
				);
			});
			//Cancel edit repeat
			$('button.repeat_cancel_edit_btn', $form).unbind('click').bind('click', function() {
				var level = $(this).attr('data-level');
				var modal =  $('.crud-modal'+level, $form);
				if (modal.data('data') != $('input,textarea,select', modal).serialize()){
					//confirm discard modification
					if (confirm(crudModalsTranslations.discardChanges)) return;
				}
				modal.off('hide.bs.modal');
				var newinput = '<input type="hidden" name="'+this.id+'" id="'+this.id+'" value="'+this.id+'" />';
				$(this).after(newinput);
				r.ajaxProcess(this,null,true, function(){
					$('.crud-modal'+level, $form).modal('hide').data('modal', null).remove();
				});				
			});
			//Save edit instance
			$('button.repeat_save_edit_btn', $form).unbind('click').bind('click', function(e) {
				//onUpdateInstance
				var level = $(this).attr('data-level');
				var $this = $(this);
				var tableDiv = $this.closest('div.repeat');
				var f = tableDiv.triggerHandler('repeat:updateinstance');
				if (typeof f !== 'undefined' && f === false) {
					e.stopImmediatePropagation();
					return false;
				}
				$('.crud-modal'+level, $form).off('hide.bs.modal');
				var newinput = '<input type="hidden" name="'+this.id+'" id="'+this.id+'" value="'+this.id+'" />';
				$this.before(newinput);
				// handle large dataset mode if present
				if ($(".paginationInfo", ".bootpag").length > 0) {
					var beforeUpdate = $("#" + tableDiv.attr("id").replace("[","\\[").replace("]","\\]") + " > .bootpag").html();
					$this.after('<div tableID="' + tableDiv.attr("id") + '" style="display:none;" id="beforeUpdate">' + beforeUpdate + '</div>');
				}
				var btn = $this;
				btn.prop('disabled', true);
				r.ajaxProcess(this,null,true, 
					function(updatedEles){
						$('div#alerts', $form).hide(); //Do not display CRUD error in main alerts section
						var hasModal = false;
						if (updatedEles && updatedEles.length >0){
							for (var i=0;i<updatedEles.length; i++){
								if (updatedEles[i].hasClass('modal-body')) hasModal = true;
							}
						}
						if (!hasModal){
							//no modal in updated eles, add succesfully, close modal
							$('.crud-modal'+level, $form).modal('hide').data('modal', null).remove();
							$('div#alerts', $form).show();
						} 
						btn.prop('disabled', false);
						$('.hide-from-edit-view', '.crud-modal'+level).parent().hide();
					}
				);
			});
			
			//Delete instance
			$('.repeat_del_btn').unbind('click').bind('click', function(e) {
				if (!confirm(crudModalsTranslations.deleteRow)) return false;
				//onDeleteInstance
				var $this = $(this);
				var tableDiv = $this.closest('div.repeat');
				var f = tableDiv.triggerHandler('repeat:deleteinstance');
				if (typeof f !== 'undefined' && f === false) {
					e.stopImmediatePropagation();
					return false;
				}
				var rpt = $this.attr('data-repeat-index-name');
				var count = $this.attr('data-instance-pos');
				$('input[name='+rpt.replace("[","\\[").replace("]","\\]")+']').val(count);				
				var basename = this.id.substring(0,this.id.lastIndexOf("_"));
				$('#'+this.id.replace("[","\\[").replace("]","\\]")).after('<input type="hidden" name="'+basename+'" id="'+basename+'" value="'+basename+'" />');	
				r.ajaxProcess(this, 'input[name='+rpt+']',true);
			});
			
			/**** Non CRUD table/group mode ****/
			$('.repeat_table_append_btn, .repeat_block_append_btn').unbind('click').bind('click', function(e) {
				//onAddInstance
				var $this = $(this);
				var isRepeatTable = $this.hasClass('repeat_table_append_btn');
				var tableDiv = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
				var f = tableDiv.triggerHandler('repeat:addinstance');
				if (typeof f !== 'undefined' && f === false) {
					e.stopImmediatePropagation();
					return false;
				}
				var newinput = '<input type="hidden" name="'+this.id+'" id="'+this.id+'" value="'+this.id+'" />';
				$this.after(newinput);
				r.ajaxProcess(this,null,true);
				return false;
			});
			
			//Insert
			$('.repeat_table_add_btn, .repeat_block_add_btn').unbind('click').bind('click', function(e) {
				//onAddInstance
				var $this = $(this);
				var isRepeatTable = $this.hasClass('repeat_table_add_btn');
				var tableDiv = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
				var f = tableDiv.triggerHandler('repeat:addinstance');
				if (typeof f !== 'undefined' && f === false) {
					e.stopImmediatePropagation();
					return false;
				}
				var thisId = this.id.replace("[","\\[").replace("]","\\]");
				var classes = $('#'+thisId).attr('class');
				var rptandid = classes.substring(classes.lastIndexOf(" "));
				var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
				var count = rptandid.substring(rptandid.lastIndexOf("_")+1);
				$('input[name='+rpt.replace("[","\\[").replace("]","\\]")+']').val(count);
				var basename = this.id.substring(0,this.id.lastIndexOf("_"));
				var newinput = '<input type="hidden" name="'+basename+'" id="'+basename+'" value="'+basename+'" />';
				$this.after(newinput);
				r.ajaxProcess(this,null,true);
			});
			
			//delete
			$('.repeat_table_del_btn, .repeat_block_del_btn').unbind('click').bind('click', function(e) {
				//onDeleteInstance
				var $this = $(this);
				var isRepeatTable = $this.hasClass('repeat_table_del_btn');
				var tableDiv = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
				var f = tableDiv.triggerHandler('repeat:deleteinstance');
				if (typeof f !== 'undefined' && f === false) {
					e.stopImmediatePropagation();
					return false;
				}
				var thisId = this.id.replace("[","\\[").replace("]","\\]");
				var classes = $('#'+thisId).attr('class');
				var rptandid = classes.substring(classes.lastIndexOf(" "));
				var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
				var count = rptandid.substring(rptandid.lastIndexOf("_")+1);
				$('input[name='+rpt.replace("[","\\[").replace("]","\\]")+']').val(count);
				var basename = this.id.substring(0,this.id.lastIndexOf("_"));
				$('#'+thisId).after('<input type="hidden" name="'+basename+'" id="'+basename+'" value="'+basename+'" />');
				r.ajaxProcess(this, 'input[name='+rpt.replace("[","\\[").replace("]","\\]")+']',true);
			});

			//Move up
			$('.repeat_table_moveup_btn, .repeat_block_moveup_btn, .repeat_moveup_btn').unbind('click').bind('click', function(e) {
				//onMoveUpInstance
				var $this = $(this);
				var isRepeatTable = $this.hasClass('repeat_table_moveup_btn');
				var tableDiv = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');

				var thisId = this.id.replace("[","\\[").replace("]","\\]");
				var classes = $('#'+thisId).attr('class');
				var rptandid = classes.substring(classes.lastIndexOf(" "));
				var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
				var count = rptandid.substring(rptandid.lastIndexOf("_")+1);
				$('input[name='+rpt.replace("[","\\[").replace("]","\\]")+']').val(count);
				var basename = this.id.substring(0,this.id.lastIndexOf("_"));
				var newinput = '<input type="hidden" name="'+basename+'" id="'+basename+'" value="'+basename+'" />';
				$this.after(newinput);
				r.ajaxProcess(this,null,true);
			});

			//Move down
			$('.repeat_table_movedown_btn, .repeat_block_movedown_btn, .repeat_movedown_btn').unbind('click').bind('click', function(e) {
				//onMoveDownInstance
				var $this = $(this);
				var isRepeatTable = $this.hasClass('repeat_table_movedown_btn');
				var tableDiv = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');

				var thisId = this.id.replace("[","\\[").replace("]","\\]");
				var classes = $('#'+thisId).attr('class');
				var rptandid = classes.substring(classes.lastIndexOf(" "));
				var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
				var count = rptandid.substring(rptandid.lastIndexOf("_")+1);
				$('input[name='+rpt.replace("[","\\[").replace("]","\\]")+']').val(count);
				var basename = this.id.substring(0,this.id.lastIndexOf("_"));
				var newinput = '<input type="hidden" name="'+basename+'" id="'+basename+'" value="'+basename+'" />';
				$this.after(newinput);
				r.ajaxProcess(this,null,true);
			});

			//hide-from-list-view
			$('.hide-from-list-view', r.fm).each(function(){
				//ignore element under '.crud-modal'
				var skipElement = false;
				$('.modal').each(function() { 
					var classes = $(this).attr('class'); 
					if (classes.indexOf('crud-modal') > -1) {
						skipElement = true;
						return;
					}
				});
				if (skipElement) return;
				if ($(this).closest('td').length > 0) $(this).closest('td').remove();
				else $(this).parent().remove();
			})

			// main binding event to transform repeat group structure into datatable
			r.dataTableInstances = {};
			$('div.repeat table').each(function(index, elmt) {
				var table = $(this);
				var repeatDivId = table.closest('div.repeat').prop('id');
				if ($('#'+repeatDivId).hasClass('repeatblock')) return true;
				var r = SMARTGUIDES[smartletCode];
				var fm = r.fm;
				var loadTable = function(){
					$('#loader').show();
					table.fadeTo(0, 0.2);
					fm.ajaxSubmit({
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
						if (!$.fn.dataTable.isDataTable('#' + $(elmt).attr('id') )) {
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

			// basic bindings for field event with dependencies to other fields
			// textboxes, textarea and password
			$('input[type=text][data-eventtarget],input[type=password][data-eventtarget],textarea[data-eventtarget]').unbind('keyup paste',r.bindThis).bind('keyup paste', r.bindThis);
			$('input[type=text][data-eventtarget],input[type=password][data-eventtarget],textarea[data-eventtarget]').unbind('blur',r.bindThisAllowSelfRefresh).bind('blur', r.bindThisAllowSelfRefresh);

			// checkboxes and radio buttons
			$('input[type=checkbox][data-eventtarget],input[type=radio][data-eventtarget]').unbind('change',r.bindThisAllowSelfRefresh).bind('change', r.bindThisAllowSelfRefresh);

			// listbox and dropdown
			$('input[type=image][data-eventtarget]').unbind('click',r.bindThis).bind('click', r.bindThis);
			$('select:has(option[data-eventtarget])').unbind('change',r.bindThisOption).bind('change', r.bindThisOption);
			$('.modal-close').unbind('click').bind('click', function(e){
				var modal = $(this).parent().parent().parent().parent();  
				r.ajaxProcess(modal,null,true, function () {
					r.removeScrollLock();
				});
				modal.modal('hide');
			});
			
			r.bindSelectBoxRadios();
			
			// bind events attached to fields
			var updatedRepeatIds = [];
			for (var key in smartletfields) {
				var field = smartletfields[key];
					var events = field.events;
					if (events === null) continue;
					var fieldType = field.type;
					if (fieldType == 'repeat')
						updatedRepeatIds.push(key);
					
					var $field = null;			
					
					if (field.isUnderRepeat) {				
						$field = r._getJQField(fieldType, key+'[1]');
					} else {
						$field = r._getJQField(fieldType, key);	
					}
					
					if ($field != null && typeof ajaxUpdates !== 'undefined' && ajaxUpdates!=null && ajaxUpdates.length >0){ //Ajax submit, only bind events for updated elements
							var updated = false;
							
							if(field.isUnderRepeat) {
								var rptId = field.repeatId;
								var numberOfGroups = smartletfields[rptId].numberOfGroups;
								for(var i=0;i<numberOfGroups;i++) {
									$field = r._getJQField(fieldType, key + "[" + (i+1) + "]");
									for (var j=0; j < ajaxUpdates.length; j++){
										if (ajaxUpdates[j].is($field[0]) || $.contains(ajaxUpdates[j][0], $field[0]) || $.inArray(field.repeatId, updatedRepeatIds) > -1) {
											updated = true;
											break;
										}
									}
								}
							} else {
								for (var i=0; i < ajaxUpdates.length; i++){
									if (ajaxUpdates[i].is($field[0]) || $.contains(ajaxUpdates[i][0], $field[0]) || $.inArray(field.repeatId, updatedRepeatIds) > -1) {
										updated = true;
										break;
									}
								}
							}
							if (!updated) continue;
						}
				
					for(var event in events) {
						var jqEvent = event.toLowerCase();
						// bind repeat events for add/delete/update instance
						if (fieldType === 'repeat') {
							if (jqEvent === 'onupdateinstance' || jqEvent === 'ondeleteinstance' || jqEvent === 'onaddinstance'){
								var repeatDiv = $('div#div_' + key, r.fm);
								var smartlet = r._createSmartletContext(field, fieldType, key);
								var handler = r._createEventHandler(events[event].client);
								repeatDiv.data('_smartlet', smartlet).bind('repeat:' + jqEvent.substring(2), handler);
								continue;
							}
						}	
						// check if we are under repeat, in which case we must bind each instance of that field
						if (field.isUnderRepeat) {
							// get number of instances to bind
							var rptId = field.repeatId;
							var numberOfGroups = smartletfields[rptId].numberOfGroups;

							for(var i=0;i<numberOfGroups;i++) {
								var fieldHtmlName = key + "\\[" + (i+1) + "\\]";
								if($field.attr('class') != null && $field.attr('class').indexOf("btn-modal") < 0) {
									r._bindFieldEvent(field, fieldType, fieldHtmlName, event, events[event].server, events[event].client, events[event]['isAjax']);
								} else {
									r._bindModalFieldEvent(field, fieldType, fieldHtmlName, event, events[event].server, events[event].client, events[event]['isAjax']);
								}
							}
						} else if($field.is(":visible") || $("#div_" + key).parents('.smartmodal').length > 0) {
							if($field.attr('class') != null && $field.attr('class').indexOf("btn-modal") < 0) {
								r._bindFieldEvent(field, fieldType, key, event, events[event].server, events[event].client, events[event]['isAjax']);
							} else {
								r._bindModalFieldEvent(field, fieldType, key, event, events[event].server, events[event].client, events[event]['isAjax']);
							}
						}
					}
			}

			// reapply tooltip
			$('[data-toggle="tooltip"]', r.fm).tooltip();

			// invoke custom binding methods
			customJS.bindEvents(r);			
		}
		, _createSmartletContext : function(contextField, fieldType, fieldHtmlName) {
			var smartlet = 
				{
					_fieldObj : function(fieldNode, htmlName) {
						if (!fieldNode) return null;
						var r = SMARTGUIDES[smartletCode];
						var $field;
						if (fieldNode.type === 'staticText' || fieldNode.type === 'staticImg'){
							$field = $('div#div_'+htmlName, r.fm);
						} else if (this._fieldType === 'sub-smartlet'){
							//subsmartlet access button
							$field = $('[name="'+'t_e'+htmlName.substring(2)+'"]', r.fm);
						} else {
							$field = $('[name="'+htmlName+'"]', r.fm);
						}
						return {
							name: fieldNode.name,
							id:  htmlName.substring(2).replace(/\\/g,""),
							htmlName: htmlName.replace(/\\/g,""),
							$: $field,
							value: $field.val()
						}
					}
					,_fieldType : fieldType
					,_contextField: contextField
					,_fieldHtmlName : fieldHtmlName
					,lang: function(){
						return currentLang;
					}
					,field : function(nameOrId){
						if (!nameOrId) return this._fieldObj(this._contextField, this._fieldHtmlName);
						if (typeof smartletfields['d_' + nameOrId] !== 'undefined') return this._fieldObj(smartletfields['d_' + nameOrId], 'd_' + nameOrId);
						if (typeof smartletfields['t_' + nameOrId] !== 'undefined') return this._fieldObj(smartletfields['t_' + nameOrId], 't_' + nameOrId);
						for (var key in smartletfields) {
							var f = smartletfields[key];
							if (f.name == nameOrId) {
								// return contextual instance in case field and this are under repeat
								if (f.isUnderRepeat && this.field().htmlName.indexOf("[")>-1) {
									// append index to key
									var index = this.field().htmlName.substring(this.field().htmlName.indexOf("["));
									key = key + index;
								}
								return this._fieldObj(f, key);
							}
						}
						return null;
					}
					,openModal : function(modal) {
						var r = SMARTGUIDES[smartletCode];
						r.ajaxProcess(modal,null,true, function() {
							r.addScrollLock();
						});
						//Clear validation errors that might have appeared						
						modal.modal('show');
					}
					,closeModal : function(modal) {
						var r = SMARTGUIDES[smartletCode];

						r.ajaxProcess(modal,null,true, function () {
							r.removeScrollLock();
						});
						modal.modal('hide');
					}
					,validateModal : function(modalId, callback){
						var validationResult = true;
						var r = SMARTGUIDES[smartletCode];
						var fm = r.fm;
						//Posts the form and check for errors
						fm.ajaxSubmit({ 
							crossDomain: false,
							type: 'post',
							iframe:false,
							data : { g_validation : modalId },
							success:  function(data){
								try {
									response = data;
									// automatically replace the alert div
									var sourceAlertDiv = $('#alerts', r.fm);
									var targetAlertDiv = $('#alerts', response);
									$(sourceAlertDiv).after(targetAlertDiv).remove();
									
									var errorMessages = $('.alert-danger', response).text().trim();
									if(errorMessages !== '') {
										validationResult = false;
									}
									
									var res = true;																		
								} catch(e) {
									if (console) console.log(e.stack);
								}
								
								r.posted = false;
							},
							error: function(XMLHttpRequest, textStatus, errorThrown) {
								r.posted = false;
								if (console) {
									console.log('Error: print XMLHttpRequest textStatus and errorThrown');
									console.log(XMLHttpRequest);
									console.log(textStatus);
									console.log(errorThrown);
								}
							}
						}); 
						return validationResult;
					}
				};
			return smartlet;
		}
		, _createEventHandler : function(clientEvent){
			var handler = 
				function(e) {
					var f = true;
					try {
						var smartlet = $(this).data('_smartlet');
						f = Function("smartlet", "field", "ajaxSubmit", "submit", clientEvent).bind(smartlet.field())
								(smartlet, smartlet.field.bind(smartlet));
					} catch (err){
						alert(err);
					}
					if (typeof e !== 'undefined' && typeof f !== 'undefined' && f === false) {
						e.stopImmediatePropagation();
						return false;
					}
				};
			return handler;
		}
		, _getJQField: function (fieldType, fieldHtmlName){
			var r = SMARTGUIDES[smartletCode];
			var $field;
			if (fieldType === 'staticText' || fieldType === 'staticImg'){
				$field = $('div#div_'+fieldHtmlName, r.fm);
			} else {
				$field = $('[name="'+fieldHtmlName+'"]', r.fm);
			}
			return $field;
		}
		, _bindModalFieldEvent : function(contextField, fieldType, fieldHtmlName, event, isServer, clientEvent, isAjax){
			var r = SMARTGUIDES[smartletCode];
			var jqEvent = event.toLowerCase();
			if (jqEvent.indexOf("on") == 0) {
				jqEvent = jqEvent.substring(2);
			}
			
			var $field = r._getJQField(fieldType, fieldHtmlName);
			
			// check if we need to bind the div_ of a repeat or group field
			if (fieldType == 'repeat') {
				$field = $("#div_" + fieldHtmlName);
			} 
			
			// bind server event first
			if (isServer) {
				$field.unbind(jqEvent);
				$field.bind(jqEvent, function(e) {
					var r = SMARTGUIDES[smartletCode];
					
					$(this).after($('<input/>', {
						type: 'hidden',
						name: 'e_'+fieldHtmlName.substring(2).replace(/\\/g,""),
						value: 'on'+e.type
					}));					

					if (isAjax) {
						var modalId = "";
						
						r.ajaxProcess(this,null,true, function() {
							// must remove the e_ field we added
							$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
							
							setTimeout(function() {
								var updated = [];
								
								$field.unbind(jqEvent);
								
								var errorMessages = $('.alert-danger', $form).text().trim();
								if(errorMessages == '') {								
									//prepare client event context
									var smartlet = r._createSmartletContext(contextField, fieldType, fieldHtmlName);
									var handler = r._createEventHandler(clientEvent);
									$field.data('_smartlet', smartlet).bind(jqEvent, handler);
																					
									$field.triggerHandler(jqEvent);
								}
							}, 0);
						});
					}
					else {
						if (!$(this).hasClass("always-enabled")) {
							r._doubleClickHandler(e);
						} else {
							r.fm.submit();
						}
						
						// must remove the e_ field we added is the button is always enabled, like when triggering a file download
						if ($(this).hasClass("always-enabled")) {
							$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
						}
					}

					return false;
				});				
			}		
		}		
		, _bindFieldEvent : function(contextField, fieldType, fieldHtmlName, event, isServer, clientEvent, isAjax){
			var r = SMARTGUIDES[smartletCode];
			var jqEvent = event.toLowerCase();
			if (jqEvent.indexOf("on") == 0) {
				jqEvent = jqEvent.substring(2);
			}
			
			var $field = r._getJQField(fieldType, fieldHtmlName);
			
			// check if we need to bind the div_ of a repeat or group field
			if (fieldType == 'repeat') {
				$field = $("#div_" + fieldHtmlName);
			} 
			
			//first bind client event
			if (typeof clientEvent !== 'undefined') {
				//prepare client event context
				$field.unbind(jqEvent);
				var smartlet = r._createSmartletContext(contextField, fieldType, fieldHtmlName);
				var handler = r._createEventHandler(clientEvent);
				$field.data('_smartlet', smartlet).bind(jqEvent, handler);
				
				//for init and render, directly trigger
				if ((jqEvent == 'fieldinit' || jqEvent == 'fieldrender') && $field.is(":visible")) {
					$field.triggerHandler(jqEvent);
				} 
			}
			//then bind server event
			if (isServer) {
				if (typeof clientEvent == 'undefined') {
					// must unbind first
					$field.unbind(jqEvent);
				}
				$field.bind(jqEvent, function(e) {
					var r = SMARTGUIDES[smartletCode];
					
					$(this).after($('<input/>', {
						type: 'hidden',
						name: 'e_'+fieldHtmlName.substring(2).replace(/\\/g,""),
						value: 'on'+e.type
					}));
					// for select, or static text, set event target
					if (!$(this).attr('data-eventtarget') && $('*[data-eventtarget]', this)){
						$(this).attr('data-eventtarget', $('*[data-eventtarget]', this).attr('data-eventtarget'));
					}

					if (isAjax) {
						r.ajaxProcess(this,null,true, function() {
							// must remove the e_ field we added
							$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
						});
					}
					else {
						if (!$(this).hasClass("always-enabled")) {
							r._doubleClickHandler(e);
						} else {
							r.fm.submit();
						}
						
						// must remove the e_ field we added is the button is always enabled, like when triggering a file download
						if ($(this).hasClass("always-enabled")) {
							$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
						}
					}

					return false;
				});
			}
		}		
		, bindThis : function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess(this,null,false);
		}
		, bindThisAllowSelfRefresh: function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess(this,null,true); 
		}
		, bindThisOption: function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess($('option', this),null,false); 
		}
		, bindAllFieldsUnderRepeat: function(elmt) {
			// check if we are outside a repeat, but make modifications to a field in a repeat
			// in which case all instances of the repeated fields must be added to the data-eventtarget array
			if ($(elmt).attr('id') != null && $(elmt).attr('id').indexOf('[') == -1) {
				var newArr = [];
				var targetArr = eval($(elmt).attr('data-eventtarget'));
				var bReplacements = false;
				if(typeof targetArr !== 'undefined' && targetArr!= null) {
					for(var i=0;i<targetArr.length;i++) {
						var baseId = targetArr[i];
						if (targetArr[i].indexOf('[') > -1) {
							baseId = targetArr[i].substring(0, targetArr[i].indexOf('['));
						}
						if (smartletfields[baseId].isUnderRepeat) {
							// find parent repeat
							var rptId = smartletfields[baseId].repeatId;
							var nbrGroups = smartletfields[rptId].numberOfGroups;
							// push all instances of the field in the array
							for(var j=1;j<=nbrGroups;j++) {
								if (!newArr.includes(baseId + '[' + j + ']')) {
									newArr.push(baseId + '[' + j + ']');
									bReplacements = true;
								}
							}
						} else {
							if (!newArr.includes(targetArr[i])) {
								newArr.push(targetArr[i]);
							}
						}
					}
				}
				if (bReplacements) {
					// replace current data-eventtarget on field
					var newDataEventTarget = newArr.join('","');
					$(elmt).attr('data-eventtarget', '["' + newDataEventTarget + '"]');
				}
			}
		}
		, bindSelectBoxRadios: function(){
			var r = SMARTGUIDES[smartletCode];
			// radio buttons in the context of select control instance on repeat
			$('input[type=radio][data-group]').each(function() {
				$(this).unbind('change').bind('change', function() {
					// When any radio button in the data-group is selected,
					// then deselect all other radio buttons.
					var dataGroup = $(this).attr('data-group');
					// Check if we are under a datatable
					var otable = r.dataTableInstances['div_'+dataGroup];
					if (typeof otable !== 'undefined') {
						$('input[type=radio][data-group]',otable.cells().nodes()).not(this).prop('checked', false)						
					} else {
						$('input[type=radio][data-group]',$('#div_'+dataGroup)).not(this).prop('checked', false)						
					}
					
				});
			});
		}		
		, ajaxProcess : function(elmt, elmt2, allowSelfRefresh, callBack) {
			var r = SMARTGUIDES[smartletCode];
			var fm = r.fm;
			// Optimization in case we don't allow self refresh and the target is the same as the source field
			if (!allowSelfRefresh) {
				var targetArr = eval($(elmt).attr('data-eventtarget'));
				if(typeof targetArr !== 'undefined' && targetArr!= null) {
					if (targetArr.length == 1) {
						var currentID=$(elmt).attr('id');
						if (targetArr[0] == currentID) return;
					}
				}
			}
			fm.ajaxSubmit({ 
				crossDomain: false,
				type: 'post',
				iframe:false,
				data : { isAjax : 'true' },
				success:  function(data){
					try {
						response = data;

						// get array of response elements
						var responseDiv = $("div#sgControls", response);
						var currentDiv = $("div#sgControls");

						var targetArr = eval($(elmt).attr('data-eventtarget'));
						var currentID=$(elmt).attr('id');
						var updated = [];
						if(typeof targetArr !== 'undefined' && targetArr!= null) {
							for(var i=0;i<targetArr.length;i++) {
								if (targetArr[i] == 'form') {
									var responseTarget = responseDiv;
									responseTarget = responseTarget.clone();
									$(currentDiv).after(responseTarget).remove();
									break;
								}
								// Prevent self refresh
								if (allowSelfRefresh||targetArr[i]!=currentID) {
									var targetDiv = "div_"+targetArr[i];
									targetDiv = targetDiv.replace("[","\\[").replace("]","\\]");					
									var responseTarget = $('#'+targetDiv, responseDiv);
									responseTarget = responseTarget.clone();
									if (responseTarget.length > 0) {
										var currentTarget = $('#'+targetDiv, currentDiv);
										//Check to see if we're using a crud-modal, is so, need to hide it.
										//Display happens at the event handler level (ie. save_...)
										if($('.crud-modal', responseTarget).length > 0) {
											$('.crud-modal', responseTarget).hide(); //.show need to be handled in the callback.
										 }  
										$(currentTarget).after(responseTarget).remove();
										updated.push(responseTarget);
									}
								}
							}
						}						
						
						//replace the alert modal div if necessary	
						var modalAlertId = $('#repeat-errors-validation').attr('id');
						var showErrors = false;
						if(typeof modalAlertId === 'undefined') {
							showErrors = true;
							var parentId = $(elmt).parent().attr('id');							
							modalAlertId = $('*[id*=modalAlerts]' , $('#' + parentId).closest('.smartmodal')).attr('id');
						}
						if(typeof modalAlertId !== 'undefined') {
							if(showErrors) {
								var sourceModalAlertDiv = $('#' + modalAlertId, fm);
								var targetModalAlertDiv = $('#' + modalAlertId, response);
								$(sourceModalAlertDiv).after(targetModalAlertDiv).remove();
							} else {
								$('.alert:not(.alert-warning)', elmt).html('').hide();
							}
						} else {
							// replace the alert div
							var sourceAlertDiv = $('#alerts', fm);
							var targetAlertDiv = $('#alerts', response);
							$(sourceAlertDiv).after(targetAlertDiv).remove();
						}						
						
						// automatically replace the SG JS div
						var sourceSGLIBDiv = $('#sglib', fm);
						var targetSGLIBDiv = $('#sglib', response);
						$(sourceSGLIBDiv).after(targetSGLIBDiv).remove();

						// rebind events, which should always be done last just before the callback
						r.bindEvents(updated);

						if (elmt2 != null && !(typeof elmt2 === 'undefined')) $(elmt2).val('');	
						
						if (callBack) callBack(updated);
						
					} catch(e) {
						if (console) console.log(e.stack);
					}
					
					r.posted = false;
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					r.posted = false;
					if (console) {
						console.log('Error: print XMLHttpRequest textStatus and errorThrown');
						console.log(XMLHttpRequest);
						console.log(textStatus);
						console.log(errorThrown);
					}
				}
			}); 
		}
	};
	SMARTGUIDES[smartletCode].init();
});