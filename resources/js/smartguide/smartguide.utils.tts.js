
// Audio binding for Text To Speach option on Labels, Lengends & StaticText
// The text supporting this will have the tts class, audio files will have been generated for the containing field using it's SG identifier.
// If we can't find the SG identifier, we'll silently log it.

function tts(){
	console.log("tts enabled")
	$("[data-tts]").each(function(){
		let ttsId = $(this).attr("data-tts");
		let encodedTtsId = CSS.escape(ttsId);

		$(this).off('mouseenter focusin').on("mouseenter focusin", function() {
			$("#tts_" + encodedTtsId).attr("style", 'display:content; cursor: pointer;');
		});
		$(this).parent().off('mouseleave focusout').on("mouseleave focusout", function(){
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