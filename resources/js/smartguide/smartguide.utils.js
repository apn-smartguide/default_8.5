var utilsController = {

	init: function (sgRef) {
		//Prevent press enter to submit the form
		$(window).keydown(function (event) {
			if (event.keyCode == 13) {
				if (event.target.nodeName == 'INPUT' && event.target.type == "password") {
					$('.btn-primary[data-eventtarget*='+$(event.target).attr('id')+']:visible').triggerHandler('click');
				} else if (event.target.nodeName != 'TEXTAREA') {
					// if we have a input with class next, and we're not in a modal, we can trigger the button
					if ($('input.next:visible').length == 1 && $(event.target).closest('.modal').length == 0) {
						var nextButton = $('input.next:visible').first();
						nextButton.triggerHandler('click');
						return false;
					}
				}
			}
		});

		showSignature();
	},

	bindEvents: function (sgRef, context) {
		
		if (!context) {
			context = sgRef.fm;
		}
		
		if(!isDateSupported()) {
			$("[type=date]").attr("type","text");
		}

		var isIE11 = !!window.MSInputMethodContext && !!document.documentMode;
		
		//Init Formatters
		reformatAllFieldTypes();

		$('[data-toggle="tooltip"]').tooltip({container: 'body', placement: 'auto'});

		//make help window dragable, JQuery UI Draggable
		$('.modal-dialog', context).draggable({
			handle: ".modal-header"
		});

		$(".toggle-password").off('click').click(function() {
			$(this).toggleClass("fa-eye fa-eye-slash")
			var input = $($(this).attr("toggle"));
			if (input.attr("type") == "password") {
				input.attr("type", "text");
			} else {
				input.attr("type", "password");
			}
		});

		// Devbridge autocomplete dropdowns
		// https://github.com/devbridge/jQuery-Autocomplete
		$('input.autocomplete', context).each(function () {
			var datalist = [];
			$('option', $(this).next()).each(function () {
				var label = $(this).text();
				var value = $(this).attr('value');
				datalist.push({ value: label, data: value });
			});
			$(this).devbridgeAutocomplete({
				lookup: datalist,
				onInvalidateSelection:function(){
					$(this).prev().attr('value', '')
				},
				onSelect: function (suggestion) {
					$(this).prev().attr('value', suggestion.data);
				},
				minChars: 0
			});
		});

		//if(!isIE11) {
			// Input masks
			// https://github.com/RobinHerbots/Inputmask
			$('input[data-mask], input[data-mask-options], input[data-mask-raw]', context).each(function (index) {
				var $this = $(this);
				
				var dataMaskRaw = $this.attr('data-mask-raw');
				if (typeof dataMaskRaw !== 'undefined') {
					$this.inputmask(JSON.parse(dataMaskRaw));
				} else {
					var options = { autoGroup: true, jitMasking: true, autoUnmask: true, removeMaskOnSubmit: true };
					var dataMask = $this.attr('data-mask');
					if (typeof dataMask !== 'undefined') {
						$.extend(options, JSON.parse('{"mask":"' + dataMask + '"}'));
					}
					var dataMaskOptions = $this.attr('data-mask-options');
					if (typeof dataMaskOptions !== 'undefined') {
						$.extend(options, JSON.parse(dataMaskOptions));
					}			
					
					$this.inputmask(options);
				}
			});
		//}

		//For multi-level support
		$('ul.dropdown-menu [data-toggle=dropdown]').on('click', function (event) {
			event.preventDefault();
			event.stopPropagation();
			$(this).parent().siblings().removeClass('open');
			$(this).parent().toggleClass('open');
		});
		
		$('a[data-toggle="collapse"]').off("click").on("click",function () {
			$(this).find('span.toggle-icon').toggleClass('fas fa-chevron-up fas fa-chevron-down');
		});

		$('.panel-collapse.collapse').off("shown.bs.collapse").on("shown.bs.collapse", function() {
			window.dispatchEvent(new Event('resize'));
			setTimeout(function(){
				$(".datatables", $(this)).each(function(){
					var dt = $(this).closest('.panel');
					//The below code should detect display of a datatables row when it's expanded in responsive mode and bind the sg controls in it.
					//At this time, touching dt.dataTable() (or any of the datatables api access methods) will re-init the datatable and double the controls displayed (search/items per page/and collapsed content of rows in responsive)
					//dt.dataTable().api().on('responsive-display', function (e, datatable, row, showHide, update) {
						//console.log( 'Details for row '+row.index()+' '+(showHide ? 'shown' : 'hidden') );
						//Bind SG object shown when expanding the panel
						//sgRef.bindEvents([dt]);
					//});
					if(typeof dt !== "undefined" && dt.length > 0) sgRef.bindEvents([dt]);
				});
			}, 0);
			
		});
		
		//if(!isIE11) {
		// Date widget initializations
		$('input[type=date][data-apnformat],input[type=text][data-apnformat]', context).each(function(index) {
			var $this = $(this);
			// if type contains date then skip, as the browser will take care of data entry
			var type = $this.prop('type');

			if (type.indexOf('date') > -1)
				return;
			
			//remove onblur for input, instead, using onchange
			if(type.indexOf('text') && typeof $this.attr("data-eventtarget") !== 'undefined') {
				$this.off('keyup paste').off('blur')
				.off('change',sgRef.bindThisAllowSelfRefresh).on('change', sgRef.bindThisAllowSelfRefresh);
			}

			var format = $this.attr('data-apnformat');
			//translate
			if (format) format = format.replace("mois","MM").replace("mmm", "M").replace("jj","dd").replace("aaaa","yyyy").replace("aa","yy");
			else format = "yyyy-mm-dd";
			
			var readonly = $this.prop('readonly');
			
			//Requires Jquery.datepicker
			if(typeof $this.datepicker !== 'undefined') {
				var dtOptions = {
					format: format
					,autoclose: true
					,enableOnReadonly: !readonly
					,language: currentLocale
					,orientation: 'bottom auto'
					,assumeNearbyYear: true // this is for 2-year dates; assumes by default margin of 20 years; see online docs
				};
				// Check extra options through data attributes
				var minDate = $this.attr('data-mindate')
				if (minDate) {
					dtOptions.startDate = minDate;
				}
				var maxDate = $this.attr('data-maxdate')
				if (maxDate) {
					dtOptions.endDate = maxDate;
				}
				
				$this.datepicker(dtOptions).on("show", function(e){
					//prevent conflict with crud modal
					e.preventDefault();
					e.stopPropagation();
				}).on("hide", function(e){
					//prevent conflict with crud modal
					e.preventDefault();
					e.stopPropagation();
				});
			}
		});
		//}

		$('.link-as-post').off('click').on('click',function(e){
			e.preventDefault();
			e.stopImmediatePropagation();

			var form = document.createElement('form');
			form.action = $(this).attr('href');
			form.method = 'post';

			var $input = $(document.createElement('input'));
			$input.attr('name', 'com.alphinat.sgs.anticsrftoken');
			$input.attr('type', 'hidden');
			$input.attr('value', $("[name='com.alphinat.sgs.anticsrftoken']").val());
			
			if(this.target != "") {
				form.target = this.target;
			}

			$(form).append($input);
			$('body').append(form)
			form.submit();
			$('body').remove(form);

			return false;
		});

		$('.clear-upload').off('click').on('click', function (e) {
            $('#loader').fadeIn("fast");
            var $this = $(this);
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value=""/>';
			$this.before(newinput);
            sgRef.ajaxProcess(this, null, true,
                null,
                null,
                function(){
                    $("#loader").fadeOut("fast");
                }
            );
        });
		
		//Support for auto-expandable textarea
		function setAutoHeight(obj) {
			if (obj.value == '') {
				obj.style.overflow = 'auto';
				obj.style.height = '37px';
			} else if(obj.scrollHeight < 120) {
				obj.style.overflow = 'hidden';
				obj.style.height = obj.scrollHeight + 'px';
			} else {
				obj.style.overflow = 'auto';
				obj.style.height = '100px';
			}
		}

		$("textarea.autoexpand", context).each(function(){
			setAutoHeight(this);
			$(this).on("keyup", function() {
				this.style.height = 0;
				setAutoHeight(this);
			});
		});

		$(".uploads-render").each(function(){
			var $this = $(this);

			$this.find('*').on('dragover', function(event) {
				event.preventDefault();
				event.stopPropagation();
				$('.drop-popup', $this).css('display','block');
			});

			$('.drop-popup', $this).on('dragover dragleave drop', function(event) {
				event.preventDefault();
				event.stopPropagation();
			
				// layout and drop events
				if ( event.type == 'dragover') {
					$('.drop-popup', $this).css('display','block');
				} else {
					$('.drop-popup', $this).css('display','none');
				
					if ( event.type == 'drop' ) {
						var droppedFiles = event.originalEvent.dataTransfer.files;
						$this.find('input[type="file"]').prop('files', droppedFiles);
						$("form").submit();
					}
				}
			});
		});

		//Disable required field html client-side validation
		$('.no-validate').on('click', function(){
			$('form').prop('novalidate', true);
			$('input, select').each(function() {
				$(this).removeAttr('required');
			});
		});

		if (typeof tts === 'function'){
			tts();
		}
	}
}

// Same as .on() but moves the binding to the front of the queue.
// Note, this does not garranty first call will complete before next, all call are still sent async.
$.fn.priorityOn = function (type, fn) {
	this.each(function () {
		var $this = $(this);
		var types = type.split(" ");
		for (var t in types) {
			$this.on(types[t], fn);
			var currentBindings = $._data(this, 'events')[types[t]];
			if ($.isArray(currentBindings)) {
				currentBindings.unshift(currentBindings.pop());
			}
		}
	});
	return this;
};

// Will remove the events from the object, place them in an array to be called on the callback of the event passed in argument.
$.fn.callbackOn = function (type, fn) {
	this.each(function () {
		var $this = $(this);
		var types = type.split(" ");
		for (var t in types) {
			var eventsArray = [];
			$._data(this, 'events')[types[t]].forEach(function (obj) {
				var handler = obj.handler;
				if(typeof handler != undefined) eventsArray.push(handler);
			},this);

			$this.off(types[t]);
			$this.on(types[t], function(e){
				fn.call(this, function(e){
					for(var i =0; i < eventsArray.length; i++) {
						eventsArray[i].call($this, e);
					}
				},e);
			});
		}
	});
	return this;
};

// Polyfill for Object.assign from https://developer.mozilla.org/
if (typeof Object.assign !== 'function') {
	// Must be writable: true, enumerable: false, configurable: true
	Object.defineProperty(Object, "assign", {
	value: function assign(target, varArgs) { // .length of function is 2
		'use strict';
		if (target === null || target === undefined) {
		throw new TypeError('Cannot convert undefined or null to object');
		}

		var to = Object(target);

		for (var index = 1; index < arguments.length; index++) {
		var nextSource = arguments[index];

		if (nextSource !== null && nextSource !== undefined) {
			for (var nextKey in nextSource) {
			// Avoid bugs when hasOwnProperty is shadowed
			if (Object.prototype.hasOwnProperty.call(nextSource, nextKey)) {
				to[nextKey] = nextSource[nextKey];
			}
			}
		}
		}
		return to;
	},
	writable: true,
	configurable: true
	});
}

var isDateSupported = function () {
	var input = document.createElement('input');
	var value = 'a';
	input.setAttribute('type', 'date');
	input.setAttribute('value', value);
	return (input.value !== value);
};

function formatCurrency(n) {
	var res = Number(n.replace(/,/g, '').replace(/ /g, '')).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	return res;
}

function formatNumber(n) {
	if (isNaN(parseInt(n))) {
		alert("Please enter a valid number.");
		return "0";
	}
	return n.replace(/\./g, '').replace(/,/g, '').replace(/ /g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function formatPhoneFax(t) {
	var text = t.replace(/\D/g, '');
	return text.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
}

function formatPostalCode(p) {
	return p.toUpperCase();
}

function formatDecimalNumber(n) {
	if (isNaN(parseFloat(n))) {
		alert("Please enter a valid decimal number.");
		return "0.00";
	}
	// strip , from number as it causes problems in formatting expression below
	n = n.replace(/,/g, "");
	return parseFloat(n).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function reformatCurrency() {
	if ($(this).val() != '') {
		try {
			var formattedNumber = formatCurrency($(this).val());
			$(this).val(formattedNumber);
		} catch (e) {
		}
	}
}

function reformatPhone() {
	if ($(this).val() != '') {
		var formattedNumber = formatPhoneFax($(this).val());
		$(this).val(formattedNumber);
	}
}

function reformatNumber() {
	if ($(this).val() != '') {
		try {
			var formattedNumber = formatNumber($(this).val());
			$(this).val(formattedNumber);
		} catch (e) {
		}
	}
}

function reformatDecimalNumber() {
	if ($(this).val() != '') {
		try {
			var formattedNumber = formatDecimalNumber($(this).val());
			$(this).val(formattedNumber);
		} catch (e) {
		}
	}
}

function reformatPostalCode() {
	var postalcode = formatPostalCode($(this).val());
	$(this).val(postalcode);
}

function reformatAllFieldTypes(src) {
	if (typeof src != 'undefined') {
		if ($(src).hasClass('Currency') || $(src).hasClass('currency')) {
			$('input', src).each(reformatCurrency);
		}
		$('input[data-masktype=postalcanada],input[data-masktype=postalzip]').each(reformatPostalCode);
		if ($(src).hasClass('Number') || $(src).hasClass('number')) {
			$('div > input, div >input', src).each(reformatNumber);
		}
		if ($(src).hasClass('DecimalNumber') || $(src).hasClass('decimalnumber')) {
			$('input', src).each(reformatDecimalNumber);
		}
	} else {
		// apply to whole form
		$('div.Currency input,div.currency input').each(reformatCurrency);
		$('input[data-masktype=postalcanada],input[data-masktype=postalzip]').each(reformatPostalCode);
		$('div.Number > div > input, div.number > div >input').each(reformatNumber);
		$('div.DecimalNumber input, div.decimalnumber input').each(reformatDecimalNumber);
	}
}

function setGetParameter(paramName, paramValue) {
	var url = window.location.href;
	var hash = location.hash;
	url = url.replace(hash, "");
	if (url.indexOf(paramName + "=") >= 0) {
		var prefix = url.substring(0, url.indexOf(paramName + "="));
		var suffix = url.substring(url.indexOf(paramName + "="));
		suffix = suffix.substring(suffix.indexOf("=") + 1);
		suffix =
			suffix.indexOf("&") >= 0 ? suffix.substring(suffix.indexOf("&")) : "";
		url = prefix + paramName + "=" + paramValue + suffix;
	} else {
		if (url.indexOf("?") < 0) url += "?" + paramName + "=" + paramValue;
		else url += "&" + paramName + "=" + paramValue;
	}
	window.location.href = url + hash;
}

function showSignature() {
	//clean jsignature
	var ele1 = $(".jSignature").prev();
	var ele2 = $(".jSignature");
	var ele3 = $(".jSignature").next();
	ele1.remove();
	ele2.remove();
	ele3.remove();
	$(".clear_signature").remove();

	if ($(".signature").length == 0) {
		return;
	}
	var sigdiv = $(".signature").parent("div");
	var sigData = $("textarea", sigdiv).val();
	$("textarea", sigdiv).hide();
	sigdiv.jSignature({
		signatureLine: false
	});
	$("canvas", sigdiv)
		.css("border", "1px solid")
		.css("background-color", "#f2f2f2");
	try {
		if (sigData) {
			console.log(sigData);
			sigdiv.jSignature("setData", sigData);
		}
	} catch (err) {
		console.log(err);
	}
	sigdiv.on("change", function (e) {
		var datapair = sigdiv.jSignature("getData", "base30"); //use base30 to detect empty image
		$("textarea", sigdiv).val("data:" + datapair[0] + "," + datapair[1]);
		console.log($("textarea", sigdiv).val());
	});
	//resete button
	var clearButton = $(
		'<input type="button" value="Clear" class="clear_signature pull-right"/>'
	);
	clearButton.insertAfter($("canvas", sigdiv));
	clearButton.on("click", function () {
		sigdiv.jSignature("reset");
		$("textarea", sigdiv).val("");
	});
}

function initToBrowserLocale(currentLocale) {
	if (typeof Cookies.get("locale_pref") !== "undefined") return;
	Cookies.set("locale_pref", currentLocale);

	var browserLocale = window.navigator.language.slice(0, 2);
	if (
		supportedLocales.indexOf(browserLocale) > 0 &&
		browserLocale != currentLocale
	) {
		Cookies.set("locale_pref", browserLocale);
		setGetParameter("lang", browserLocale);
	}
}

function ScrollToError(target, index) {
	$(target).animate({ scrollTop: $('#error_index_'+index).offset().top }, 1000);
	return false;
}

function ChangeUrl(page, url) {
	if (typeof (history.pushState) != "undefined") {
		var obj = { Page: page, Url: url };
		history.pushState(obj, obj.Page, obj.Url);
	} else {
		alert("Browser does not support HTML5.");
	}
}

function ReplaceUrl(page, url) {
	if (typeof (history.replaceState) != "undefined") {
		var obj = { Page: page, Url: url };
		history.replaceState(obj, obj.Page, obj.Url);
	} else {
		alert("Browser does not support HTML5.");
	}
}
/*
 Input Mask plugin binding
 http://github.com/RobinHerbots/jquery.inputmask
 Copyright (c) Robin Herbots
 Licensed under the MIT license
 */
(function (factory) {
	factory(jQuery, window.Inputmask, window);
}
(function ($, Inputmask, window) {
	$(window.document).ajaxComplete(function (event, xmlHttpRequest, ajaxOptions) {
		if ($.inArray("html", ajaxOptions.dataTypes) !== -1) {
			$(".inputmask, [data-inputmask], [data-inputmask-mask], [data-inputmask-alias], [data-inputmask-regex]").each(function (ndx, lmnt) {
				if (lmnt.inputmask === undefined) {
					Inputmask().mask(lmnt);
				}
			});
		}
	}).ready(function () {
		$(".inputmask, [data-inputmask], [data-inputmask-mask], [data-inputmask-alias],[data-inputmask-regex]").each(function (ndx, lmnt) {
			if (lmnt.inputmask === undefined) {
				Inputmask().mask(lmnt);
			}
		});
	});
}));