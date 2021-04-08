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
		,init: function(){
			// This section is for code that must be run once after the page is loaded
			$(document).ready(function(){
				var r = SMARTGUIDES[smartletCode];
				
				//init tooltip
				$('[data-toggle="tooltip"]').tooltip();
				
				//make help window dragable, JQuery UI Draggable
				$('.modal-dialog', r.fm).draggable({
					handle: ".modal-header"
				});
			
				// Disable buttons after submitting the SMARTGUIDE form to prevent double submissions
				$('button:not([data-toggle="collapse"]), input[type="button"], input[type="submit"], input[type="image"]', r.fm).off('click').on('click', r._baseDoubleClickHandler);

				//Smartlet events
				r._bindOrTriggerSmartletAndPageEvent();
				
				// invoke custom init methods
				customJS.init(r);
				
				// call the main bind events function
				r.bindEvents(); 
			});
		}
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
		, _baseDoubleClickHandler : function(e) {
			// check if button should be excluded from double click restriction
			if (!$(this).hasClass("always-enabled")) {
				// use flag to determine if we allow submit
				e.preventDefault();
				var r = SMARTGUIDES[smartletCode];
				if (!r.posted) {
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
							$body.on('smartlet:init', handler);
						} else if (jqEvent.indexOf("event_on_enter_page") == 0) {
							$body.on('smartlet:page_enter', handler);
						} else if (jqEvent.indexOf("event_on_exit_page") == 0) {
							$body.on('smartlet:page_exit', handler);
							$(window).off('beforeunload').on('beforeunload', function(e){
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
								$body.on('page:init', handler);
							} else if (jqEvent.indexOf("onpagerender") == 0) {
								$body.on('page:render', handler);
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
						
			// $('div.date[data-apnformat]', r.fm).each(function(index) {
			// 	var format = $(this).attr('data-apnformat');
			// 	if (format !== null) {
			// 		// translate
			// 		format = format.replace("mois","MMM").replace("mm","MM").replace("jj","DD").replace("aaaa","YYYY").replace("aa","YY");
			// 	} else {
			// 		// use default
			// 		format = "YYYY-MM-DD";
			// 	}
			// 	$(this).datetimepicker({locale: currentLocale, format: format, showClear:true, calendarWeeks:false, debug:false});
			// });

			// basic bindings for field event with dependencies to other fields
			// textboxes, textarea and password
			$('input[type=text][data-eventtarget],input[type=password][data-eventtarget],textarea[data-eventtarget]').off('keyup paste',r.bindThis).on('keyup paste', r.bindThis);
			$('input[type=text][data-eventtarget],input[type=password][data-eventtarget],textarea[data-eventtarget]').off('blur',r.bindThisAllowSelfRefresh).on('blur', r.bindThisAllowSelfRefresh);

			// checkboxes and radio buttons
			//$('input[type=checkbox][data-eventtarget],input[type=radio][data-eventtarget]').off('change',r.bindThisAllowSelfRefresh).on('change', r.bindThisAllowSelfRefresh);
			$('input[type=checkbox][data-eventtarget],input[type=radio][data-eventtarget]').each(function() { // check if we already have change event attached
				var id = $(this).attr('name'); 
				if ($.isEmptyObject(smartletfields[id].events.onchange)) { 
					$(this).off('change',r.bindThisAllowSelfRefresh).on('change', r.bindThisAllowSelfRefresh); 
				}
			});

			// listbox and dropdown
			$('input[type=image][data-eventtarget]').off('click',r.bindThis).on('click', r.bindThis);
			$('select:has(option[data-eventtarget])').off('change',r.bindThisOption).on('change', r.bindThisOption);
			$('.modal-close').off('click').on('click', function(e){
				var modal = $(this).parent().parent().parent().parent();  
				r.ajaxProcess(modal, null, true, null, null, function () {
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
					
					//Revise for repeat of multiple level.
					field.isUnderRepeat = (field.isUnderRepeat & (typeof field.class !== 'undefined' && field.class.indexOf("panel-heading-button") < 0));

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
								repeatDiv.data('_smartlet', smartlet).on('repeat:' + jqEvent.substring(2), handler);
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
								var jqField = r._getJQField(fieldType, fieldHtmlName);
								if(jqField != null && jqField.attr('class') != null && jqField.attr('class').indexOf("btn-modal") < 0) {
									r._bindFieldEvent(field, fieldType, fieldHtmlName, event, events[event].server, events[event].client, events[event]['isAjax']);
								} else {
									r._bindModalFieldEvent(field, fieldType, fieldHtmlName, event, events[event].server, events[event].client, events[event]['isAjax']);
								}
							}
						} else if($field.is(":visible") || $("#div_" + key).parents('.smartmodal').length > 0) {
							if($field.attr('class') == null || ($field.attr('class') != null && $field.attr('class').indexOf("btn-modal") < 0)) {
								r._bindFieldEvent(field, fieldType, key, event, events[event].server, events[event].client, events[event]['isAjax']);
							} else {
								r._bindModalFieldEvent(field, fieldType, key, event, events[event].server, events[event].client, events[event]['isAjax']);
							}
						}
					}
			}

			// reapply tooltip
			$('[data-toggle="tooltip"]').tooltip();

			// invoke custom binding methods
			customJS.bindEvents(r, ajaxUpdates);			
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
						if($field.length == 0) $field = $('#'+htmlName, r.fm);

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
						return currentLocale;
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
						r.ajaxProcess(modal,null,true,
							function() {
								r.addScrollLock();
							},
							null,
							null
						);
						//Clear validation errors that might have appeared						
						modal.modal('show');

					}
					,closeModal : function(modal) {
						var r = SMARTGUIDES[smartletCode];

						r.ajaxProcess(modal, null, true, null, null,
							function () {
								r.removeScrollLock();
							}
						);
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
				$field = $('[name="'+fieldHtmlName+'"]:not([type="hidden"])', r.fm);
				if($field.length == 0) {
					$field = $('#'+fieldHtmlName+'', r.fm);
				}
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
				$field.off(jqEvent);
				$field.on(jqEvent, function(e) {
					var r = SMARTGUIDES[smartletCode];
					
					$(this).after($('<input/>', {
						type: 'hidden',
						name: 'e_'+fieldHtmlName.substring(2).replace(/\\/g,""),
						value: 'on'+e.type
					}));					

					if (isAjax) {
						var modalId = "";
						
						// fix the data event target to have the modal id instead of the whole form as its target
						var $modal = $field.closest('.modal');
						if ($modal.length > 0) {
							modalId = $modal.attr('id');
							var targets = $field.attr('data-eventtarget');
							if (targets.indexOf('form') > -1) {
								targets = targets.replace('form',modalId);
								$field.attr('data-eventtarget', targets);
							}
						}

						r.ajaxProcess(this, null, true, 
							function() {
								// must remove the e_ field we added
								$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();

								var $container = $('form');
								// just re-show the modal after form was swapped, if it is available
								// need the complex selector below because the whole modal might have been swapped
								// in the current ajaxProcess call
								var $modal = $('[name="' + $field.attr('name') + '"]').closest('.modal');
								if ($modal.length > 0) {
									$('#'+$modal.attr('id')).modal('show');
									$container = $modal;
								}

								setTimeout(function() {
									var updated = [];
									
									var errorMessages = $('.alert-danger', $container).text().trim();
									if(errorMessages == '') {								
										$field.off(jqEvent);
										//prepare client event context
										var smartlet = r._createSmartletContext(contextField, fieldType, fieldHtmlName);
										var handler = r._createEventHandler(clientEvent);
										$field.data('_smartlet', smartlet).on(jqEvent, handler);
																						
										$field.triggerHandler(jqEvent);
									}
								}, 0);
							},
							null,
							null
						);
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
				$field.off(jqEvent);
				var smartlet = r._createSmartletContext(contextField, fieldType, fieldHtmlName);
				var handler = r._createEventHandler(clientEvent);
				$field.data('_smartlet', smartlet).on(jqEvent, handler);
				
				//for init and render, directly trigger
				if ((jqEvent == 'fieldinit' || jqEvent == 'fieldrender') && $field.is(":visible")) {
					$field.triggerHandler(jqEvent);
				} 
			}
			//then bind server event
			if (isServer) {
				if (typeof clientEvent == 'undefined') {
					// must unbind first
					$field.off(jqEvent);
				}
				$field.on(jqEvent, function(e) {
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
						r.ajaxProcess(this, null, true, 
							function() {
								// must remove the e_ field we added
								$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
							},
							null,
							null
						);
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
			r.ajaxProcess(this, null, false, null, null, null);
		}
		, bindThisAllowSelfRefresh: function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess(this, null, true, null, null, null); 
		}
		, bindThisOption: function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess($('option', this), null, false, null, null, null); 
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
						if (typeof smartletfields[baseId] !== 'undefined' && smartletfields[baseId].isUnderRepeat) {
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
			/*$('input[type=radio][data-group]').each(function() {
				$(this).off('change').on('change', function() {
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
			}); */
		}		
		, ajaxProcess : function(elmt, elmt2, allowSelfRefresh, successCallback, errorCallback, completeCallback) {
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

			if(!$(elmt).hasClass('save-blobs')){
				$("div.blob > input[type='file']").each(function(){
					$(this).attr('name',"");
				})
			}

			fm.ajaxSubmit({ 
				crossDomain: false,
				type: 'post',
				iframe:false,
				data : { isAjax : 'true' },
				success:  function(data){
					try {

						if(!$(elmt).hasClass('save-blobs')){
							$("div.blob > input[type='file']").each(function(){
								var fieldid = $(this).attr('id');
								$(this).attr('name',fieldid);
							})
						}
						
						response = data;
						// get array of response elements
						var responseDiv = $("#sgControls", response);
						var currentDiv = $("#sgControls");

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
									var targetDiv = targetArr[i];
									if(typeof targetDiv != 'undefined' && targetDiv != "") {
										targetDiv = targetDiv.replace("[","\\[").replace("]","\\]");					
										var responseTarget = $('#div_'+targetDiv, responseDiv);
										if(responseTarget.length == 0) responseTarget = $('#'+targetDiv, responseDiv);

										responseTarget = responseTarget.clone();
										if (responseTarget.length > 0) {
											var currentTarget = $('#div_'+targetDiv, currentDiv);
											if(currentTarget.length == 0) currentTarget = $('#'+targetDiv, currentDiv);
											//Check to see if we're using a crud-modal, is so, need to hide it.
											//Display happens at the event handler level (ie. save_...)
											if($('.crud-modal', responseTarget).length > 0) {
												$('.crud-modal', responseTarget).hide(); //.show need to be handled in the callback.
											}
											// handling modals
											if(currentTarget.hasClass('modal')) {
												currentTarget.modal('hide'); //.show need to be handled in the callback.
											}
											
											$(currentTarget).after(responseTarget).remove();
											updated.push(responseTarget);
										}
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
								//$('.alert:not(.alert-warning)', elmt).html('').hide();
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

						r.bindEvents(updated);
						
						if (elmt2 != null && !(typeof elmt2 === 'undefined')) $(elmt2).val('');	
						
						if (successCallback) successCallback(updated);
						
					} catch(e) {
						if (console) console.log(e.stack);
					}
					
					r.posted = false;
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					if (r.posted) {
						// this is to make sure we don't interpret as an error if
						// there is already a server side submit running
						return;
					}
					r.posted = false;
					if (console) {
						console.log(XMLHttpRequest);
						console.log(textStatus);
						console.log(errorThrown);
						console.log(XMLHttpRequest.responseText);
						alert("ERROR: <code>" + XMLHttpRequest.responseText + "<code>")
					}
					if(errorCallback) {
						errorCallback(XMLHttpRequest, textStatus, errorThrown);
					} else if (!console) {
						alert("ERROR: Could not process action, please try again.")
					}
				},
				complete: function() {
					if(completeCallback) completeCallback();
				}
			}); 
		}
	};
	SMARTGUIDES[smartletCode].init();
});

//Prevent press enter to submit the form
// $(document).ready(function() {
//   $(window).keydown(function(event){
//     if(event.keyCode == 13) {
//         if(event.target.nodeName == 'IMG' || event.target.nodeName == 'SPAN'){
// 			event.target.click();
// 		}
// 		// make sure we only overwrite behaviour when pressing enter on an input field
// 		else if (event.target.nodeName != 'TEXTAREA' && event.target.nodeName != 'A' && event.target.nodeName != 'BUTTON' && event.target.type != "submit") {
// 			// if we have a input with class next, and we're not in a modal, we can trigger the next button
// 			if ($('input.next:visible').length == 1 && $(event.target).closest('.modal').length == 0) {
// 				var nextButton = $('input.next:visible').first();
// 				nextButton.trigger('click');
// 				return false;
// 			} else {
// 				event.preventDefault();
// 				return false;
// 			}
// 		}
//     }
//   });
// });

function getScripts(scripts, callback) {
    var progress = 0;
    scripts.forEach(function(script) { 
        $.getScript(script, function () {
            if (++progress == scripts.length) callback();
        }); 
    });
}