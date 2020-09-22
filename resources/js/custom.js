var customJS = {
	init: function(sgRef) {
		// This section is for code that must be run once after the page is loaded
		// It is called within the $(document).ready(function(){ of smartguide.js
		// You can reference objects and methods contained in smartguide.js
		// e.g.: var frm = sgRef.fm; $('#myselector', frm).addClass("myclass");
		
		//Prevent press enter to submit the form
		$(window).keydown(function(event){
			if(event.keyCode == 13) {
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
	}
	,bindEvents : function(sgRef) {
		// can reference objects and methods in smartguide.js
		// e.g.: var frm = sgRef.fm; $('#myselector', frm).unbind('click',sgRef.bindThis).bind('click', sgRef.bindThis);
		var frm = sgRef.fm;
		
		// Devbridge autocomplete dropdowns
		// https://github.com/devbridge/jQuery-Autocomplete
		$('input.autocomplete', frm).each(function() {
			var datalist = [];
			$('option', $(this).next()).each(function() {
				var label = $(this).text();
				var value = $(this).attr('value');
				datalist.push({ value:label,data:value});
			});
			$(this).devbridgeAutocomplete({lookup:datalist,
				onSelect: function (suggestion) {
					$(this).prev().attr('value', suggestion.data);
				},
				minChars:0
			});
		});

		// Input masks
		// https://github.com/RobinHerbots/Inputmask
		$('input[data-mask]', frm).each(function(index) {
			var $this = $(this);
			$this.inputmask($this.attr('data-mask'));
		});

		// Date widget initializations
		$('div.date[data-apnformat]', frm).each(function(index) {
			var $this = $(this);
			// if type contains date then skip, as the browser will take care of data entry
			var type = $('input', $this).attr('type');
			if (type.indexOf('date') > -1)
				return;
			
			//remove onblur for input, instead, using onchange
			$('input[type=text][data-eventtarget]', $this)
				.unbind('keyup paste').unbind('blur')
				.unbind('change',sgRef.bindThisAllowSelfRefresh).bind('change', sgRef.bindThisAllowSelfRefresh);
			
			var format = $this.attr('data-apnformat');
			//translate
			if (format) format = format.replace("mois","MM").replace("mmm", "M").replace("jj","dd").replace("aaaa","yyyy").replace("aa","yy");
			else format = "yyyy-mm-dd";
			
			var readonly = $('input',$this).prop('readonly');
			
			var dtOptions = {
				format: format
				,autoclose: true
				,enableOnReadonly: !readonly
				,language: currentLocale
				,orientation: 'bottom auto'
				,assumeNearbyYear: true // this is for 2-year dates; assumes by default margin of 20 years; see online docs
			};
			// Check extra options through data attributes
			var minDate = $('input',$this).attr('data-mindate')
			if (minDate) {
				dtOptions.startDate = minDate;
			}
			var maxDate = $('input',$this).attr('data-maxdate')
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
		});
	}
}