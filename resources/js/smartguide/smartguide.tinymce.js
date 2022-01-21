var tinymceController = {
	basicToolbar: 'undo redo | bold italic underline | charmap',
	fullToolbar: 'tinyAttribution | undo redo | styleselect | table | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright alignjustify | outdent indent | charmap',
	config: {
		selector: "TEXTAREA.tinymce",
		language: currentLocale,
		inline: false,
		height: 200,
		menubar: false,
		statusbar: true,
		branding: true,
		padding: 5,
		toolbar_mode: 'wrap',
		paste_as_text: true,
		convert_newlines_to_brs : true,
		force_p_newlines : false,
		forced_root_block : false,
		mobile: { theme: 'mobile' },
		formats: {
			bold: [
				{ inline: 'strong'},
				{ inline: 'b', remove: 'all' },
				{ inline: 'span', classes: 'bold' }
			],
			underline: [
				{ inline: 'u'},
				{ inline: 'span', styles: { 'text-decoration': 'underline' }, exact: true }
			],
			italic: [
				{inline: 'em'},
				{inline: 'i', remove: 'all'}
			],
			strikethrough: { inline: 'span', styles: { 'text-decoration': 'line-through' }, exact: true },
			h1: { block: 'h1', classes: 'heading' }
		},
		max_height: 500,
		min_height: 200,
		plugins: [
			'table',
			'lists',
			'code, paste',
			'autoresize charmap',
			'searchreplace fullscreen',
			'paste help wordcount'
		  ],
		toolbar: 'undo redo | bold italic underline | charmap',
		  setup: function (editor) {
			editor.on('change', function () {
				editor.save();
			});
			editor.on('init', function () {
				editor.save();
			});
			editor.ui.registry.addButton('tinyAttribution', {
				text: '<svg height="20" viewBox="0 0 640 209" version="1.1" xmlns="http://www.w3.org/2000/svg"><title>Powered by Tiny</title><path d="M554,48.0148681 L575,107.156355 L580,125.19952 L586,107.156355 L607,48.0148681 L640,48.0148681 L584.9,201.983213 L549.3,209 L564,167.30024 L521,48.0148681 L554,48.0148681 Z M132.174917,-1.42108547e-14 C166.168467,0.200392927 199.762092,28.4557957 199.762092,69.6365422 C199.762092,69.6365422 199.98295,80.6368415 199.999072,93.7327309 L199.999546,96.2637525 C199.997047,99.0993124 199.984049,102.004008 199.956455,104.892071 L199.938113,106.622226 C199.810442,117.558547 199.460149,128.006994 198.6623,133.261297 C193.963192,164.722986 170.467651,186.465619 138.073798,191.976424 C108.879338,197.687623 91.5826205,200.994106 85.983683,202.096267 C84.5721862,202.390963 80.3238574,202.997689 76.1284395,203.44738 L75.2909176,203.535085 C72.6464216,203.805308 70.1004227,204 68.3870223,204 C32.7937768,204 0.499905134,177.347741 0,134.363458 L0.000878633264,132.21184 C0.000946220438,132.105988 0.00101900663,131.996583 0.00109739175,131.883703 L0.00196482714,130.776147 C0.00647237175,125.588941 0.021320754,115.481538 0.070233072,105.179065 L0.0821360132,102.80026 L0.0821360132,102.80026 L0.0907751738,101.216914 C0.14881176,90.9420878 0.243953705,81.0779764 0.399924107,76.3497053 C1.59969643,44.9882122 23.2955792,19.6385069 64.5877433,11.5225933 L64.6475408,11.5109641 C66.5880037,11.1335906 115.120154,1.69532417 117.177763,1.30255403 C121.976853,0.400785855 127.275847,-1.42108547e-14 132.174917,-1.42108547e-14 Z M298,15.9381295 L298,48.0148681 L328,48.0148681 L328,77.0844125 L298,77.0844125 L298,127.204317 C298,137.027818 305.4,141.23789 310,141.23789 C314.357895,141.23789 318.267036,140.698094 322.322613,139.448041 L323,139.233094 L330,162.288249 C327,164.293046 318,169.305036 301,169.305036 C284,169.305036 266.4,156.273861 266,134.221103 C265.857895,127.241247 265.783102,119.294257 265.775623,110.380134 L265.775623,107.37294 C265.782763,98.658854 265.851235,89.0635578 265.981039,78.5870509 L266,77.0844125 L245,77.0844125 L245,48.0148681 L266,48.0148681 L266,22.1529976 L298,15.9381295 Z M155.970402,36.5717092 L75.9855804,52.1021611 L75.9855804,83.3634578 L43.9916518,89.5756385 L43.9916518,167.528487 L123.976473,151.998035 L123.976473,120.736739 L155.970402,114.524558 L155.970402,36.5717092 Z M468,45.0076739 C496.116,44.809199 517.3713,67.2070825 517.987654,95.2776343 L518,96.129976 L518,167.30024 L486,167.30024 L486,101.141966 C485.9,86.1059952 475,73.9769784 460,74.0772182 C445.15,74.1764556 432.16219,85.8686073 432.000949,100.691828 L432,167.30024 L400,167.30024 L400,48.0148681 L429,48.0148681 L430.1,61.9482014 C439.4,51.723741 453.1,45.1079137 468,45.0076739 Z M380,48.0148681 L380,167.30024 L348,167.30024 L348,48.0148681 L380,48.0148681 Z M123.976473,74.0451866 L123.976473,120.736739 L75.9855804,130.05501 L75.9855804,83.3634578 L123.976473,74.0451866 Z M380,-2.84217094e-14 L380,31.1745803 L348,37.3894484 L348,6.21486811 L380,-2.84217094e-14 Z"></path></svg>',
				tooltip: 'Powered by Tiny MCE',
				onAction: function () {
				  window.open("http://www.tiny.cloud","_blank");
				}
			});
		}
	},

	init: function(sgRef, currentLocale) {},
	
	initWithObject: function(obj) {

		// **Patch**
		// Once an element is initialized with tinymce, if the element is removed from the dom, the instance will remain in memory.
		// Thus, if we try to add this element again on the page, we won't be able to initialize it with tinymce.
		// But, we can check via tinymce.get, and if we find it by don't have a sibbling tinymce, then we need to reset by a remove.
		var objID = $(obj).attr('id');
		var selector = "TEXTAREA.tinymce";

		// if we don't find an id, we can't do the below check, but we'll fallback to the selector.
		if(objID) {
			if(tinymce.get(objID) && $(obj).siblings('[role=application].tox.tox-tinymce').length <= 0) {
				tinymce.get(objID).remove();
			}
			selector = "#"+objID.replace(/\[/g,"\\[").replace(/\]/g,"\\]");	
			tinymceController.initWithSelector(selector);
		}
	},

	initWithSelector: function(selector) {
		tinymceController.config.selector = selector;
		tinymce.init(tinymceController.config);
	},

	bindEvents : function(sgRef, selector, context) {
		//find all object with this selector.
		if (!selector.jquery){
			selector = $(selector);
		}
		if(typeof selector !== 'undefined' || selector.length > 0) { 
			selector.each(function(){
				if(!$(this).attr('readonly')) {
					tinymceController.initWithObject(this);
				}
			});
		}
	}
}