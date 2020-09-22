var tinymceController = { 

	initWithObject: function(obj, selector) {

		// **Patch**
		// Once an element is initialized with tinymce, if the element is removed from the dom, the instance will remain in memory.
		// Thus, if we try to add this element again on the page, we won't be able to initialize it with tinymce.
		// But, we can check via tinymce.get, and if we find it by don't have a sibbling tinymce, then we need to reset by a remove.
		var objID = $(obj).attr('id');
		// if we don't find an id, we can't do the below check, but we'll fallback to the selector.
		if(objID) {
			if(tinymce.get(objID) && $(obj).siblings('[role=application].tox.tox-tinymce').length <= 0) {
				tinymce.get(objID).remove();
			}
			selector = "#"+objID.replace(/\[/g,"\\[").replace(/\]/g,"\\]");	
		}

		tinymceController.initWithSelector(selector);
	},

	initWithSelector: function(selector) {

		setTimeout(function () {
		tinymce.init({
			selector: selector,
			language: currentLocale,
			height: 200,
			menubar: false,
			statusbar: true,
			branding: true,
			padding: 5,
			autoresize_bottom_margin: 15,
			autoresize_overflow_padding: 5,
			paste_as_text: true,
			force_p_newlines: false,
			forced_root_block: false,
			convert_newlines_to_brs : false,
			formats: {
		  		bold: {inline: 'b'},
		  		underline: {inline: 'u'},
		  		italic: {inline: 'i'}
			},
			max_height: 500,
			min_height: 200,
			plugins: [
		    	'code, paste',
		    	'autoresize charmap',
		    	'searchreplace fullscreen',
		    	'paste help wordcount'
		  	],
			toolbar: 'undo redo | bold italic underline | charmap',
			content_css: [
		    '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i'
		  	],
		  	setup: function (editor) {
		        editor.on('change', function () {
		            editor.save();
		        });
		    }
		});
		},10);
	},


	init: function(sgRef, currentLocale) { 


	},
	
	bindEvents : function(sgRef, selector, context) {

		if(!selector) selector = "TEXTAREA.tinymce";

		if(context) {
			//find all objects with this selector in this context.
			$(selector, context).each(function(){
				if(!$(this).attr('readonly')) {
					tinymceController.initWithObject(this, selector);
				}
			});
		} else {
			//find all object with this selector.
			$(selector).each(function(){
				if(!$(this).attr('readonly')) {  
					tinymceController.initWithObject(this, selector);
				}
			});			
		}
	}
}
		