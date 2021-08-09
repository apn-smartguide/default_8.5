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
					if (typeof $body.data('_smartlet') === 'undefined') {
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
			// basic bindings for field event with dependencies to other fields
			// textboxes, textarea and password
			$('input[type=text][data-eventtarget],input[type=password][data-eventtarget],textarea[data-eventtarget]').off('keyup paste', r.bindThisResetFocus).on('keyup paste', r.bindThisResetFocus);
			$('input[type=text][data-eventtarget],input[type=password][data-eventtarget],textarea[data-eventtarget]').off('blur',r.bindThisAllowSelfRefresh).on('blur', r.bindThisAllowSelfRefresh);

			// checkboxes and radio buttons
			$('input[type=checkbox][data-eventtarget],input[type=radio][data-eventtarget]').each(function() { // check if we already have change event attached
				var id = $.escapeSelector($(this).attr('name'));
				if (typeof smartletfields[$.escapeSelector(id)] !== 'undefined' && $.isEmptyObject(smartletfields[id].events.onchange)) {
					$(this).off('change',r.bindThisAllowSelfRefresh).on('change', r.bindThisAllowSelfRefresh);
				}
			});

			$('input[type=image][data-eventtarget]').off('click',r.bindThis).on('click', r.bindThis);
			$('select:has(option[data-eventtarget])').off('change',r.bindThisOption).on('change', r.bindThisOption);
			
			$('.modal-close').off('click').on('click', function(e){
				var modal = $(this).parent().parent().parent().parent();
				r.ajaxProcess(modal, null, true, null, null, function () {
					r.removeScrollLock();
				});
				modal.modal('hide');
			});

			// bind events attached to fields
			var updatedRepeatIds = [];
			$("#alerts").hide();
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
						} else if($field.is(":visible") || $("#div_" + key).parents('.smartmodal').is(":visible")) {
							if($field.attr('class') == null || ($field.attr('class') != null && $field.attr('class').indexOf("btn-modal") < 0)) {
								r._bindFieldEvent(field, fieldType, key, event, events[event].server, events[event].client, events[event]['isAjax']);
							} else {
								r._bindModalFieldEvent(field, fieldType, key, event, events[event].server, events[event].client, events[event]['isAjax']);
							}
						}
					}
					if(field.isRequired && $field.is(":visible") || $('#errors-fdbck-frm').length > 0){
						$("#alerts").show();
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
					,openModal : function(modal, options) {
						var r = SMARTGUIDES[smartletCode];
						r.ajaxProcess(modal,null,true,
							function() {
								r.addScrollLock();
							},
							null,
							null
						);
						//Clear validation errors that might have appeared
						var modalOptions = {show:true};
						if (typeof options !== 'undefined') {
							$.extend(modalOptions, options);
						}
						modal.modal(modalOptions);
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
					$field = $('#div_'+fieldHtmlName+'', r.fm);
				}
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
							modalId = $.escapeSelector($modal.attr('id'));
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
									errorMessages += $('.label-danger', $container).text().trim();
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
				if (typeof clientEvent === 'undefined') {
					// must unbind first
					$field.off(jqEvent);
				}

				var processTimer; //timer identifier
			
				$field.on(jqEvent, 
					function(e) {
						var r = SMARTGUIDES[smartletCode];

						var doneInterval = 0;  //time in ms
						if(jqEvent == "keyup" || jqEvent == "keydown") {
							doneInterval = 500; //0.5s 
						}

						clearTimeout(processTimer);
						
						$(this).after($('<input/>', {
							type: 'hidden',
							name: 'e_'+fieldHtmlName.substring(2).replace(/\\/g,""),
							value: 'on'+e.type
						}));
						// for select, or static text, set event target
						if (!$(this).attr('data-eventtarget') && $('*[data-eventtarget]', this)){
							$(this).attr('data-eventtarget', $('*[data-eventtarget]', this).attr('data-eventtarget'));
						}

						processTimer = setTimeout(processAjax.bind(null, e, r, isAjax, this, fieldHtmlName), doneInterval);
						
						function processAjax (e, r, isAjax, field, fieldHtmlName) {
							clearTimeout(processTimer);
							var ogType = field.type;
							var curRange = null;
							if(field.tagName == "INPUT" && (field.type == 'text' || field.type == 'password') && ($(field).attr('type') != 'email') && ($(field).attr('type') != 'number')){
								curRange = $(field).range();
							}
							if (isAjax) {
								if(field.tagName == "BUTTON" && e.type == "click") {
									$("#loader").fadeIn("slow");
								}

								r.ajaxProcess(field, null, true, 
									function() {
										// must remove the e_ field we added
										$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
									},
									null,
									function() {
										if(e.type == "keyup") {
											var fieldInput = $("#"+fieldHtmlName);
											var fldLength= fieldInput.val().length;
											if(fieldInput[0].tagName == "INPUT" && (fieldInput[0].type == 'text' || fieldInput[0].type == 'password') && (fieldInput.attr('type') != 'email') && (fieldInput.attr('type') != 'number')) {
												console.log(e.keyCode);
												if(curRange.length > 0) {
													fieldInput.range(curRange.start, curRange.end);
												} else if(curRange.length <=0 && fldLength > 0) {
													fieldInput.range(fldLength,fldLength);
												} else {
													fieldInput.range(0,fldLength);
												} 
												fieldInput.focus();
											}
										}
										if(field.tagName == "BUTTON" && e.type == "click") {
											$("#loader").fadeOut("slow");
										}
									}
								);
							} else {
								if (!$(field).hasClass("always-enabled")) {
									r._doubleClickHandler(e);
								} else {
									r.fm.submit();
								}
								
								// must remove the e_ field we added is the button is always enabled, like when triggering a file download
								if ($(field).hasClass("always-enabled")) {
									$('[name="' + 'e_'+fieldHtmlName.substring(2).replace(/\\/g,"") + '"]').remove();
								}
							}
							field.type = ogType;
							return false;
						}
					}
				);
			}
		}		
		, bindThis : function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess(this, null, false, null, null, null);
		}
		, bindThisResetFocus : function(){
			var r = SMARTGUIDES[smartletCode];
			r.bindAllFieldsUnderRepeat(this);
			r.ajaxProcess(this, null, false, null, null, 
				function() {
					if(this.event.keyCode != 9) {
						this.focus();
					}
				}
			);
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
		, ajaxProcess : function(elmt, elmt2, allowSelfRefresh, successCallback, errorCallback, completeCallback) {
			var r = SMARTGUIDES[smartletCode];
			var fm = r.fm;
			// Optimization in case we don't allow self refresh and the target is the same as the source field
			if (!allowSelfRefresh) {
				var targetArr = eval($(elmt).attr('data-eventtarget'));
				if(typeof targetArr !== 'undefined' && targetArr!= null) {
					if (targetArr.length == 1) {
						var currentID= $.escapeSelector($(elmt).attr('id'));
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
				success:  function(data) {
					try {

						if(!$(elmt).hasClass('save-blobs')){
							$("div.blob > input[type='file']").each(function(){
								var fieldid = $.escapeSelector($(this).attr('id'));
								$(this).attr('name',fieldid);
							})
						}
						
						response = data;
						// get array of response elements
						var $responseDiv = $("#sgControls", response);
						var $currentDiv = $("#sgControls");

						var targetArr = eval($(elmt).attr('data-eventtarget'));
						var currentID= $.escapeSelector($(elmt).attr('id'));
						var selfRefresh = $(elmt).hasClass('self-refresh');
						if(selfRefresh) {
							targetArr.push($.escapeSelector(currentID));
						}

						var updated = [];
						if(typeof targetArr !== 'undefined' && targetArr != null) {
							if(targetArr.includes("form")) {
								$currentDiv.replaceWith($responseDiv.clone());
								//updated.push($responseDiv);
							} 
							else if(!targetArr.forEach(function(target) {
								if (allowSelfRefresh || selfRefresh || target!=currentID) {
									if(typeof target !== 'undefined' && target != "") {
										target = $.escapeSelector(target);
										var responseTarget = $('#div_'+target, $responseDiv);
										if(responseTarget.length == 0) responseTarget = $('#'+target, $responseDiv);

										responseTarget = responseTarget.clone();
										if (responseTarget.length > 0) {
											var currentTarget = $('#div_'+target, $currentDiv);
											if(currentTarget.length == 0) currentTarget = $('#'+target, $currentDiv);
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
									return true;
								}
							})) {
								$("#wb-rsz").remove();
							}
						}

						//replace all alerts returned; page & modals
						$('[id^=alerts').each(function(){
							var sourceAlertDiv = $('#'+$.escapeSelector(this.id), fm);
							var targetAlertDiv = $('#'+$.escapeSelector(this.id), response);
							$(sourceAlertDiv).after(targetAlertDiv).remove();
						});

						// automatically replace the SG Bottom controls
						var sourceBottomControls = $('#sgNavButtons', fm);
						var targetBottomControls = $('#sgNavButtons', response);
						$(sourceBottomControls).after(targetBottomControls).remove();
						
						// Keep events bound to buttons wizard in SG Bottom controls
						if (updated.length > 0 && $('#sgNavButtons .btn-wizard', fm).length > 0) {
							updated.push($('#sgNavButtons .btn-wizard', fm));
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
						console.log("ERROR: <code>" + XMLHttpRequest.responseText + "<code>")
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

function getScripts(scripts, callback) {
	var progress = 0;
	scripts.forEach(function(script) {
		$.getScript(script, function () {
			if (++progress == scripts.length) callback();
		});
	});
}