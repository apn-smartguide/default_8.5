var crudController = {

	init: function (sgRef) {

	},

	bindEvents: function (sgRef, context) {
		var r = sgRef;
		var $form = sgRef.fm;

		// Note: bootstrap modal should be refactored to
		// https://wet-boew.github.io/v4.0-ci/demos/overlay/overlay-en.html

		$('button.repeat_prepare_add_btn', $form).off('click').on('click', function () {
			var $this = $(this);
			var level = $this.attr('data-level');
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var modal = $('.crud-modal' + level, $form);
			if(modal.length > 0) {
				modal.modal('hide').data('modal', null).remove();
			}
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.id + '" />';
			$this.after(newinput);
			r.ajaxProcess(this, null, true,
				function () {
					var modal = $('.crud-modal' + level, $form);
					// Clear any validation errors that might have appeared
					$('.alert', modal).html('').hide();
					modal.data('data', $('input,textarea,select', modal).serialize());
					modal.modal({ backdrop: 'static', keyboard: false });
					//$('[data-toggle="tooltip"]', modal).tooltip();
					modal.on('hide.bs.modal', function (e) {
						var cancelBtn = $('button.btn.repeat_cancel_add_btn', this);
						var newinput = '<input type="hidden" name="' + cancelBtn[0].id + '" id="' + cancelBtn[0].id + '" value="' + cancelBtn[0].id + '" />';
						$(cancelBtn[0]).after(newinput);
						r.ajaxProcess(cancelBtn[0], null, true, null, null, null);
					});

					// $('.crud-modal' + level + ' .modal-content', $form).draggable({
					// 	handle: ".modal-header"
					// });

					$('.hide-from-add-view', '.crud-modal' + level).parent().hide();
					$('input:visible:first', '.crud-modal' + level).focus();
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});
		// repeat save added instance
		$('button.repeat_save_add_btn', $form).off('click').on('click', function (e) {
			//onAddInstance
			var $this = $(this);
			var level = $this.attr('data-level');
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var f = $repeat.triggerHandler('repeat:addinstance');
			if (typeof f !== 'undefined' && f === false) {
				e.stopImmediatePropagation();
				return false;
			}
			$('.crud-modal' + level, $form).off('hide.bs.modal');
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.id + '"/>';
			$this.before(newinput);
			$this.prop('disabled', true);
			r.ajaxProcess(this, null, true,
				function (updatedEles) {
					$('div#alerts', $form).hide();
					var hasModal = false;
					if (updatedEles && updatedEles.length > 0) {
						for (var i = 0; i < updatedEles.length; i++) {
							if (updatedEles[i].hasClass('modal-body')) hasModal = true;
						}
					}
					if (!hasModal) {
						//no modal in updated eles, add succesfully, close modal
						$('.crud-modal' + level, $form).modal('hide').data('modal', null).remove();
						//show main alert
						$('div#alerts', $form).show();
					}
					$this.prop('disabled', false);
					$('.hide-from-add-view', '.crud-modal' + level).parent().hide();
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});
		//cancel add
		$('button.repeat_cancel_add_btn', $form).off('click').on('click', function () {
			var $this = $(this);
			var level = $this.attr('data-level');
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var modal = $('.crud-modal' + level, $form);
			if (modal.data('data') != $('input,textarea,select', modal).serialize()) {
				//confirm discard modification
				if (!confirm(crudModalsTranslations.discardChanges)) {
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
					return false;
				}
			}
			modal.off('hide.bs.modal');
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.id + '" />';
			$this.after(newinput);
			r.ajaxProcess(this, null, true, 
				function(){
					$('.crud-modal' + level, $form).modal('hide').data('modal', null).remove();
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});
		//repeat prepare edit instance
		$('.repeat_prepare_edit_btn', $form).off('click').on('click', function () {
			var $this = $(this);
			var level = $this.attr('data-level');
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var $modal = $('.crud-modal' + level, $form);
			if($modal.length > 0) {
				$modal.modal('hide').data('modal', null).remove();
			}
			var rpt = $this.attr('data-repeat-index-name');
			var count = $this.attr('data-instance-pos');
			$('input[name=' + rpt.replace("[", "\\[").replace("]", "\\]") + ']').val(count);
			var basename = this.id.substring(0, this.id.lastIndexOf("_"));
			$('#' + this.id.replace("[", "\\[").replace("]", "\\]")).after('<input type="hidden" name="' + basename + '" id="' + basename + '" value="' + basename + '" />');
			r.ajaxProcess(this, 'input[name=' + rpt.replace("[", "\\[").replace("]", "\\]") + ']', true,
				function () {
					$modal = $('.crud-modal' + level, $form);
					// Clear any validation errors that might have appeared
					if($modal.length > 0) {
						$('.alert', $modal).html('').hide();
						$modal.data('data', $('input,textarea,select', $modal).serialize());
						$modal.modal({ backdrop: 'static', keyboard: false });
						$modal.on('hide.bs.modal', function (e) {
							var cancelBtn = $('button.btn.repeat_cancel_edit_btn', this);
							var newinput = '<input type="hidden" name="' + cancelBtn[0].id + '" id="' + cancelBtn[0].id + '" value="' + cancelBtn[0].id + '" />';
							$(cancelBtn[0]).after(newinput);
							r.ajaxProcess(cancelBtn[0], null, true, null, null, null);
						});
					}
					// $('.crud-modal' + level + ' .modal-content', $form).draggable({
					// 	handle: ".modal-header"
					// });
					$('.hide-from-edit-view', '.crud-modal' + level).parent().hide();
					$('input:visible:first', '.crud-modal' + level).focus();
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});
		//Cancel edit repeat
		$('button.repeat_cancel_edit_btn', $form).off('click').on('click', function () {
			var $this = $(this);
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var level = $this.attr('data-level');
			var modal = $('.crud-modal' + level, $form);
			if (modal.data('data') != $('input,textarea,select', modal).serialize()) {
				//confirm discard modification
				if (!confirm(crudModalsTranslations.discardChanges)) {
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
					return false;
				}
			}
			modal.off('hide.bs.modal');
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.id + '" />';
			$this.after(newinput);
			r.ajaxProcess(this, null, true, 
				function () {
					$('.crud-modal' + level, $form).modal('hide').data('modal', null).remove();
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});
		//Save edit instance
		$('button.repeat_save_edit_btn', $form).off('click').on('click', function (e) {
			//onUpdateInstance
			var $this = $(this);
			var level = $this.attr('data-level');
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var f = $repeat.triggerHandler('repeat:updateinstance');
			if (typeof f !== 'undefined' && f === false) {
				e.stopImmediatePropagation();
				return false;
			}
			$('.crud-modal' + level, $form).off('hide.bs.modal');
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.id + '" />';
			$this.before(newinput);
			// handle large dataset mode if present
			if ($(".paginationInfo", ".bootpag").length > 0) {
				var beforeUpdate = $("#" + $repeat.attr("id").replace("[", "\\[").replace("]", "\\]") + " > .bootpag").html();
				$this.after('<div tableID="' + $repeat.attr("id") + '" style="display:none;" id="beforeUpdate">' + beforeUpdate + '</div>');
			}
			var btn = $this;
			btn.prop('disabled', true);
			r.ajaxProcess(this, null, true,
				function (updatedEles) {
					$('div#alerts', $form).hide(); //Do not display CRUD error in main alerts section
					var hasModal = false;
					if (updatedEles && updatedEles.length > 0) {
						for (var i = 0; i < updatedEles.length; i++) {
							if (updatedEles[i].hasClass('modal-body')) hasModal = true;
						}
					}
					if (!hasModal) {
						//no modal in updated eles, add succesfully, close modal
						$('.crud-modal' + level, $form).modal('hide').data('modal', null).remove();
						$('div#alerts', $form).show();
					}
					btn.prop('disabled', false);
					$('.hide-from-edit-view', '.crud-modal' + level).parent().hide();
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});

		//Delete instance
		$('.repeat_del_btn').off('click').on('click', function (e) {
			if (!confirm(crudModalsTranslations.deleteRow)) return false;
			//onDeleteInstance
			var $this = $(this);
			var $repeat = $this.closest('div.repeat');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var f = $repeat.triggerHandler('repeat:deleteinstance');
			if (typeof f !== 'undefined' && f === false) {
				e.stopImmediatePropagation();
				return false;
			}
			$repeat.find("table").dataTable().fnDestroy();
			var rpt = $this.attr('data-repeat-index-name');
			var count = $this.attr('data-instance-pos');
			$('input[name=' + rpt.replace("[", "\\[").replace("]", "\\]") + ']').val(count);
			var basename = this.id.substring(0, this.id.lastIndexOf("_"));
			$('#' + this.id.replace("[", "\\[").replace("]", "\\]")).after('<input type="hidden" name="' + basename + '" id="' + basename + '" value="' + basename + '" />');
			r.ajaxProcess(this, 'input[name=' + rpt + ']', true, 
				function(){
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});

		/**** Non CRUD table/group mode ****/
		//Insert
		$('.repeat_table_add_btn, .repeat_block_add_btn').off('click').on('click', function (e) {
			//onAddInstance
			var $this = $(this);
			var isRepeatTable = $this.hasClass('repeat_table_add_btn');
			var $repeat = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var f = $repeat.triggerHandler('repeat:addinstance');
			if (typeof f !== 'undefined' && f === false) {
				e.stopImmediatePropagation();
				return false;
			}
			var newinput = '<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.id + '" />';
			$this.after(newinput);
			r.ajaxProcess(this, null, true, 
				function(updatedEles){
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});

		//delete
		$('.repeat_table_del_btn, .repeat_block_del_btn').off('click').on('click', function (e) {
			//onDeleteInstance
			var $this = $(this);
			var isRepeatTable = $this.hasClass('repeat_table_del_btn');
			var $repeat = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var f = $repeat.triggerHandler('repeat:deleteinstance');
			if (typeof f !== 'undefined' && f === false) {
				e.stopImmediatePropagation();
				return false;
			}

			var classes = $('#' + this.id).attr('class');
			var rptandid = classes.substring(classes.lastIndexOf(" "));
			var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
			var count = rptandid.substring(rptandid.lastIndexOf("_") + 1);
			$('input[name=' + rpt + ']').val(count);
			var basename = this.id.substring(0, this.id.lastIndexOf("_"));
			$('#' + this.id).after('<input type="hidden" name="' + basename + '" id="' + basename + '" value="' + basename + '" />');
			r.ajaxProcess(this, 'input[name=' + rpt + ']', true, 
				function(){
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});

		//Move up
		$('.repeat_table_moveup_btn, .repeat_block_moveup_btn, .repeat_moveup_btn').off('click').on('click', function (e) {
			//onMoveUpInstance
			var $this = $(this);
			var isRepeatTable = $this.hasClass('repeat_table_moveup_btn');
			var $repeat = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var thisId = this.id.replace("[", "\\[").replace("]", "\\]");
			var classes = $('#' + thisId).attr('class');
			var rptandid = classes.substring(classes.lastIndexOf(" "));
			var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
			var count = rptandid.substring(rptandid.lastIndexOf("_") + 1);
			$('input[name=' + rpt.replace("[", "\\[").replace("]", "\\]") + ']').val(count);
			var basename = this.id.substring(0, this.id.lastIndexOf("_"));
			var newinput = '<input type="hidden" name="' + basename + '" id="' + basename + '" value="' + basename + '" />';
			$this.after(newinput);
			r.ajaxProcess(this, null, true, 
				function(){
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});

		//Move down
		$('.repeat_table_movedown_btn, .repeat_block_movedown_btn, .repeat_movedown_btn').off('click').on('click', function (e) {
			//onMoveDownInstance
			var $this = $(this);
			var isRepeatTable = $this.hasClass('repeat_table_movedown_btn');
			var $repeat = $this.closest(isRepeatTable ? 'div.repeat' : 'div.repeatblock');
			var repeatId = $repeat.attr('id').replace("[", "\\[").replace("]", "\\]");
			var thisId = this.id.replace("[", "\\[").replace("]", "\\]");
			var classes = $('#' + thisId).attr('class');
			var rptandid = classes.substring(classes.lastIndexOf(" "));
			var rpt = rptandid.substring(0, rptandid.lastIndexOf("_"));
			var count = rptandid.substring(rptandid.lastIndexOf("_") + 1);
			$('input[name=' + rpt.replace("[", "\\[").replace("]", "\\]") + ']').val(count);
			var basename = this.id.substring(0, this.id.lastIndexOf("_"));
			var newinput = '<input type="hidden" name="' + basename + '" id="' + basename + '" value="' + basename + '" />';
			$this.after(newinput);
			r.ajaxProcess(this, null, true, 
				function(){
					$('#'+repeatId).find("table").trigger( "wb-init.wb-tables" );
				},
				null,
				null
			);
		});

		//hide-from-list-view
		$('.hide-from-list-view', r.fm).each(function(){
			//ignore element under '.crud-modal'
			if ($(this).closest('.crud-modal').length > 0) return;
			if ($(this).closest('td').length > 0) $(this).closest('td').remove();
			else $(this).parent().remove();
		});

	}
}
