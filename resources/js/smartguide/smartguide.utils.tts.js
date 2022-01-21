
// Audio binding for Text To Speach option on Labels, Lengends & StaticText
// The text supporting this will have the tts class, audio files will have been generated for the containing field using it's SG identifier.
// If we can't find the SG identifier, we'll silently log it.

function tts(){
	console.log("tts enabled")
	$("[data-tts]").each(function(){
		let ttsId = $(this).attr("data-tts");
		let encodedTtsId = CSS.escape(ttsId);
		// $(this).off('hover').hover(function() {
		// 	$("#tts_" + encodedTtsId).attr("style", 'display:content;');
		// },function(){
		// 	$("#tts_" + encodedTtsId).attr("style", 'display:none;');
		// });
		$(this).off('mouseenter').mouseenter(function() {
			$("#tts_" + encodedTtsId).attr("style", 'display:content; cursor: pointer;');
		});
		$(this).parent().off('mouseleave').mouseleave(function(){
			$("#tts_" + encodedTtsId).attr("style", 'display:none; cursor: pointer;');
		});
		$(`#tts_${encodedTtsId}`).off("click").on("click", function (e) {
			e.preventDefault();
			var audio = new Audio();
			var source = "./resources/do.aspx?file=" + smartletName + "/" + currentLocale + "/" + ttsId + ".wav";
			audio.src = source;
			audio.load();
			audio.onloadeddata = function() {
				audio.play();
			};
		});
	});

	// $(".tts").each(function () {
	// 	var fieldId = "";
	// 	//1st check if we are on a SG Field directly.
	// 	if (typeof $(this).attr("id") != "undefined") {
	// 		fieldId = $(this).attr("id").substring(6);
	// 	} else {
	// 		// Try to find the parent SG Field
	// 		var parentObj = $(this).parents("[id^='d_']")[0];
	// 		if (typeof parentObj != "undefined") {
	// 			fieldId = $(parentObj).attr("id").substring(6);
	// 		} else {
	// 			var parentObj = $(this).parents("[id^='div_d_']")[0];
	// 			if (typeof parentObj != "undefined") {
	// 				fieldId = $(parentObj).attr("id").substring(6);
	// 			} else {
	// 				fieldId = $(this).attr("id");
	// 			}
	// 		}
	// 	}

	// 	//We found a fieldId, let's bind the click
	// 	if (typeof fieldId != 'undefined' && fieldId.length > 0) {
	// 		var $playObj = $(this);
	// 		$playObj.each(function () {
	// 			$this = $(this);
	// 			//$player = $(".tts-icon",this);
	// 			$this.off('hover').hover(function() {
	// 				$(".tts-icon",this).first().attr("style", 'display:content;');
	// 			},function(){
	// 				$(".tts-icon",this).first().attr("style", 'display:none;');
	// 			});

	// 			var suffix = "_value";
	// 			var prefix = "";
	// 			if ($this.parents("label").length > 0 || $this.parents(".panel-title").length > 0 || $(".tts-icon",this).parents("label").length > 0 || $(".tts-icon",this).parents(".panel-title").length > 0) {
	// 				suffix = "_label";
	// 			}
	// 			if ($this.parent().siblings("[type='radio'], [type='checkbox']").length > 0) {
	// 				suffix = "_option";
	// 				prefix = $player.parent().attr('data-index');
	// 				if (prefix.length > 0) prefix = "." + prefix;
	// 				suffix = prefix + suffix;
	// 			}
	// 			$this.off("click").on("click", function () {
	// 				var audio = new Audio();
	// 				var source = "./resources/do.aspx?file=" + smartletName + "/" + currentLocale + "/" + fieldId + suffix + ".wav";
	// 				audio.src = source;
	// 				audio.load();
	// 				audio.onloadeddata = function() {
	// 					audio.play();
	// 				};
	// 			});
	// 		});
	// 	} else {
	// 		console.log("could not find the field id for this TTS");
	// 	}
	// });

	// Audio binding for Text To Speech Input AddOn, for live processing of typed text.
	$(".tts-addon").each(function () {
		$(this)
			.off("click")
			.on("click", function () {
				var input = $(this).parent().siblings("input")[0];
				var text = $(input).val();
				if (text == "") return;
				var audio = new Audio();
				audio.src = applicationPath + "/do.aspx?t_tts=true&text=" + text;
				audio.load();
				audio.onloadeddata = function() {
					audio.play();
				}
			});
	});

	//Speach to text implementation, requires adding a "stt" class to the SG Field.
	var record;
	var state = true;
	$(".stt-addon").each(function () {
		//
		$(this)
			.off("click")
			.on("click", function () {
				$this = $(this);
				if (state) {
					$this.animate({
						color: "#3498db",
					},
						1000
					);
				} else {
					$this.animate({
						color: "#000",
					},
						1000
					);
				}
				state = !state;

				var status = $this.data("recording");
				if (typeof status == "undefined" || status == null) {
					// set attribute to indicate we're recording
					$this.data("recording", true);
					navigator.mediaDevices
						.getUserMedia({
							video: false,
							audio: true,
						})
						.then(async function (stream) {
							var options = {
								mimeType: "audio/wav",
								numberOfAudioChannels: 1,
							};
							//Start Actual Recording
							var StereoAudioRecorder = RecordRTC.StereoAudioRecorder;
							record = new StereoAudioRecorder(stream, options);
							record.record();
						});
				} else {
					// there was already a value, so we were recording.  Now need to stop
					$this.data("recording", null);
					record.stop(function (blob) {
						console.log("stopping recording");
						// send data to service to text
						$.ajax({
							type: "POST",
							url: applicationPath + "/do.aspx?t_stt=true",
							data: blob,
							processData: false,
							contentType: "audio/wav",
						}).done(function (data) {
							// data should contain the text to be put back in the input
							//console.log(data);
							var input = $this.parent().siblings("input")[0];
							$(input).val(data.text);
						});
					});
				}
			});
		// }
	});
}