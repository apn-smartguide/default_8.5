var uploadsController = {

	init: function (sgRef) {

	},

	bindEvents: function (sgRef, context) {
		$(".uploads-render").each(function(){
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
