// Use this file as a base copy to customize in project theme.
// Proeject specific changes should not be implemented here.
var customJS = {
	init: function (sgRef) {
		// This section is for code that must be run once after the page is loaded
		// It is called within the $(document).ready(function(){ of smartguide.js
		// You can reference objects and methods contained in smartguide.js
		// e.g.: var frm = sgRef.fm; $('#myselector', frm).addClass("myclass");
		
		//Prevent press enter to submit the form
		$(window).keydown(function (event) {
			if (event.keyCode == 13) {
				if (event.target.nodeName != 'TEXTAREA') {
					// if we have a input with class next, and we're not in a modal, we can trigger the button
					if ($('input.next:visible').length == 1 && $(event.target).closest('.modal').length == 0) {
						var nextButton = $('input.next:visible').first();
						nextButton.triggerHandler('click');
						return false;
					} else {
						event.preventDefault();
						return false;
					}
				}
			}
		});

		var navHeight = $('.navbar').outerHeight(true) + 10;

		$('#sidebar').affix({
			offset: {
				top: 20,
				bottom: navHeight
			}
		});

		$("body").scrollspy({
			target: '#leftCol',
			offset: navHeight
		});
		
		tinymceController.init(sgRef, currentLocale);
		tablesController.init(sgRef);
		//dataTablesController.init(sgRef);
		formatterController.init(sgRef);
		crudController.init(sgRef);
	}
	, bindEvents: function (sgRef, context) {
		// can reference objects and methods in smartguide.js
		// e.g.: var frm = sgRef.fm; $('#myselector', frm).unbind('click',sgRef.bindThis).bind('click', sgRef.bindThis);
		var frm = sgRef.fm;
		if (!context) {
			context = sgRef.fm;
		}

		for(i=0; i<context.length; i++) {
			tinymceController.bindEvents(sgRef, "TEXTAREA.tinymce", context[i]);
			tablesController.bindEvents(sgRef, context[i]);
			//wet_dataTablesController.bindEvents(sgRef, context[i]);
			formatterController.bindEvents(sgRef, context[i]);
			crudController.bindEvents(sgRef, context[i]);
		}

		$('[data-toggle="tooltip"]').tooltip();
				
		// Devbridge autocomplete dropdowns
		// https://github.com/devbridge/jQuery-Autocomplete
		$('input.autocomplete', frm).each(function () {
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
		$('input[data-mask]', frm).each(function (index) {
			var $this = $(this);
			$this.inputmask($this.attr('data-mask'));
		});
		
		
	},
};

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

$("[id^=btn-lang-").each(function () {
	var country = $(this).attr("data-lang").slice(-2);
	var lang = $(this).attr("data-lang").substring(0, 2);
	if (lang == "ja") country = "jp"; //fix for LANGUAGE_LIST
	if (lang == "ko") country = "kr";
	if (lang == "zh") country = "cn";

	var flagLocale = country;
	if (country == "en") flagLocale = "us";
	var flag = $("<span class='flag-icon flag-icon-" + flagLocale + "'></span>");

	var langDesc = lang;
	if (LANGUAGES_LIST.hasOwnProperty(lang)) {
		langDesc = LANGUAGES_LIST[lang].nativeName;
	}
	$(this).prepend(langDesc);
	//$(this).prepend("&nbsp;&nbsp;");
	//$(this).prepend(flag);
});

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