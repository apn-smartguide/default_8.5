// Use this file as a base copy to customize in project theme.
// Proeject specific changes should not be implemented here.
var customJS = {
	init: function (sgRef) {
		// This section is for code that must be run once after the page is loaded
		// It is called within the $(document).ready(function(){ of smartguide.js
		// You can reference objects and methods contained in smartguide.js
		// e.g.: $('#myselector', context).addClass("myclass");
		var context = sgRef.fm;

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

		utilsController.init(sgRef);
		tinymceController.init(sgRef, currentLocale);
		dataTablesController.init(sgRef);
		crudController.init(sgRef);
		keepAliveController.init(sgRef, (sessionDuration-2), sessionDuration, 30);
	}
	, bindEvents: function (sgRef, context) {
		// can reference objects and methods in smartguide.js
		// e.g.: $('#myselector', context).unbind('click',sgRef.bindThis).bind('click', sgRef.bindThis);
		if (!context) {
			context = sgRef.fm;
		}

		for(i=0; i<context.length; i++) {
			utilsController.bindEvents(sgRef, context[i]);
			tinymceController.bindEvents(sgRef, "TEXTAREA.tinymce", context[i]);
			dataTablesController.bindEvents(sgRef, context[i]);
			crudController.bindEvents(sgRef, context[i]);
		}
	}
};

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

function getLangLinks(supportedLocales, currentLocale) {
	var lngLinks = [];
	for (var i = 0; i < supportedLocales.length; i++) {
		var element = supportedLocales[i];
		var langDesc = element;
		if (LANGUAGES_LIST.hasOwnProperty(element)) {
			langDesc = LANGUAGES_LIST[element].nativeName;
		}
		if(element != currentLocale) {
			lngLinks.push({'lang':element, 'href': 'do.aspx?lang=' + element, 'text': langDesc});
		}
	}
	return lngLinks;
}