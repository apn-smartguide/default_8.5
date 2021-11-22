var utilsController = {

	init: function (sgRef) {
		//Prevent press enter to submit the form
		$(window).keydown(function (event) {
			if (event.keyCode == 13) {
				if (event.target.nodeName != 'TEXTAREA') {
					// if we have a input with class next, and we're not in a modal, we can trigger the button
					if ($('input.next:visible').length == 1 && $(event.target).closest('.modal').length == 0) {
						var nextButton = $('input.next:visible').first();
						nextButton.triggerHandler('click');
						return false;
					}
				}
			}
		});
	},

	bindEvents: function (sgRef, context) {
		
		if (!context) {
			context = sgRef.fm;
		}

		//if(!isDateSupported()) {
		//	$("[type=date]").attr("type","text");
		//}
		//Init Formatters
		reformatAllFieldTypes();

		$('[data-toggle="tooltip"]').tooltip({container: 'body'});

		//make help window dragable, JQuery UI Draggable
		$('.modal-dialog', context).draggable({
			handle: ".modal-header"
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
				onSelect: function (suggestion) {
					$(this).prev().attr('value', suggestion.data);
				},
				minChars: 0
			});
		});

		// Input masks
		// https://github.com/RobinHerbots/Inputmask
		$('input[data-mask]', context).each(function (index) {
			var $this = $(this);
			var type = $this.attr('type');
			if(type != "date") {
				$this.inputmask({ mask: $this.attr('data-mask'), jitMasking: true, autoUnmask: true, removeMaskOnSubmit: true });
			} else {
				$this.inputmask({ mask: $this.attr('data-mask'), jitMasking: true});
			}
		});

		$('a[data-toggle="collapse"]').click(function () {
			$(this).find('span.toggle-icon').toggleClass('fas fa-chevron-up fas fa-chevron-down');
		})

		// Date widget initializations
		$('input[type=date][data-apnformat],input[type=text][data-apnformat]', context).each(function(index) {
			var $this = $(this);
			// if type contains date then skip, as the browser will take care of data entry
			var type = $this.attr('type');

			//In case it's not SG control, but still participage to conditional visibility
			if(typeof $this.attr("data-eventtarget") !== 'undefined') {
				$this.unbind('change').bind('blur', sgRef.bindThisAllowSelfRefresh);
			}

			if (type.indexOf('date') > -1)
				return;
			
			//remove onblur for input, instead, using onchange
			if(type.indexOf('text') && typeof $this.attr("data-eventtarget") !== 'undefined') {
				$this.unbind('keyup paste').unbind('blur')
				.unbind('change',sgRef.bindThisAllowSelfRefresh).bind('change', sgRef.bindThisAllowSelfRefresh);
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

		//Support for auto-expandable textarea
		function setAutoHeight(obj) {
			if(obj.scrollHeight < 120) {
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
		
		$(".uploads-render", context).each(function(){
			var $this = $(this);

			$this.on('dragover', function(event) {
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

	}
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
		//var datapair = sigdiv.jSignature("getData", "image");
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