//Experimental implementation, not to push in production.
var wwtcController = { 
	init: function(sgRef) { 

	},
	
	bindEvents : function(sgRef, context) {
		$("#detectLanguageModal").on("show.bs.modal", function () {
			$(".response").hide();
		});
	}
}

function startRecording() {
	$("#locale-record").hide();
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
			//Start Actuall Recording
			var StereoAudioRecorder = RecordRTC.StereoAudioRecorder;
			var record = new StereoAudioRecorder(stream, options);
			record.record();

			$("#Progress_Status").show();
			$(".response").hide();

			update(record);
		});
}

function update(recorder) {
	var element = $("#myprogressBar");
	var width = 1;

	var id = setInterval(frame, 75);

	function frame() {
		if (width >= 100) {
			clearInterval(id);
			recorder.stop(function (blob) {
				$("#loader").fadeIn("slow");
				// invoke api
				var url =
					"https://rb7aid96ng.execute-api.us-east-1.amazonaws.com/prod/language-recognition";
				var form = new FormData();
				var recording = new Blob([blob], {
					type: "audio/wav"
				});
				form.append("data", recording);

				$.ajax({
					type: "POST",
					url: url,
					data: blob,
					processData: false,
					contentType: "audio/wav",
					headers: {
						Authorization: "Basic 1234567890"
					},
				}).done(function (data) {
					$("#loader").fadeOut("slow");
					console.log(data);
					var locale_not_supported = '<span class="fas fa-exclamation-circle"></span> The language detected "{0}" is not available in this form';
					var locale_supported = 'We have detected "{0}" as your language';
					var locale_not_detected = '<span class="fas fa-exclamation-circle"></span> Sorry, we could not detect your language, you can try again?';
					$("#Progress_Status").hide();
					$(".response").show();
					$(".message").show();
					if (typeof data.languageCode != "undefined") {
						var localeCode = data.languageCode.substring(0, 2);
						var localeDesc = "";
						if (LANGUAGES_LIST.hasOwnProperty(localeCode) > 0) {
							localeDesc = LANGUAGES_LIST[localeCode].nativeName;
						}
						if (
							localeDesc.length > 0 &&
							supportedLocales.indexOf(localeCode) > 0
						) {
							newLocale = localeCode;
							$("#locale-confirm").show();
							$(".message").html(locale_supported.replace("{0}", localeDesc));
						} else {
							$("#locale-confirm").hide();
							if (localeDesc.length <= 0) {
								localeDesc = localeCode;
							}
							$(".message").html(
								locale_not_supported.replace("{0}", localeDesc)
							);
						}
					} else {
						$("#locale-confirm").hide();
						$(".message").html(locale_not_detected);
					}
				});
				width = 0;
				element.attr("style", "width: " + width + "%");
				$(".pct", element).text(width + "%");
			});
		} else {
			width++;
			element.attr("style", "width: " + width + "%");
			$(".pct", element).text(width + "%");
		}
	}
}

function resetFindLocale() {
	$("#locale-record").show();
}

function confirmRecording() {
	resetFindLocale();
	setGetParameter("lang", newLocale);
}