// Audio binding for Text To Speach option on Labels, Lengends & StaticText
// The text supporting this will have the tts class, audio files will have been generated for the containing field using it's SG identifier.
// If we can't find the SG identifier, we'll silently log it.
function tts(context) {
    console.log("IE")
    $(".tts", context).each(function () {
        var fieldId = "";
        //1st check if we are on a SG Field directly.
        if (typeof $(this).attr("id") != "undefined") {
            fieldId = $(this).attr("id").substring(6);
        } else {
            // Try to find the parent SG Field
            var parentObj = $(this).parents("[id^='div_d_']")[0];
            if (typeof parentObj != "undefined") {
                fieldId = $(parentObj).attr("id").substring(6);
            }
        }

        //We found a fieldId, let's bind the click
        if (fieldId.length > 0) {
            var $playObj = $($(this).find("span.tts-play"));
            $playObj.each(function () {
                $player = $(this);
                var suffix = "_value";
                var prefix = "";
                if ($player.parents("label").length > 0 || $player.parents(".panel-title").length > 0) {
                    suffix = "_label";
                }
                if ($player.parent().siblings("[type='radio'], [type='checkbox']").length > 0) {
                    suffix = "_option";
                    prefix = $player.parent().attr('data-index');
                    if (prefix.length > 0) prefix = "." + prefix;
                    suffix = prefix + suffix;
                }
                $player.off("click").on("click", function () {
                    var audio = new Audio();
                    var source = "./resources/do.aspx?file=" + smartletName + "/" + currentLocale + "/" + fieldId + suffix + ".wav";
                    audio.src = source;
                    audio.load();
                    audio.onloadeddata = function() {
                        audio.play();
                    };
                });
            });
        } else {
            console.log("could not find the field id for this TTS");
        }
    });

    // Audio binding for Text To Speech Input AddOn, for live processing of typed text.
    $(".tts-addon", context).each(function () {
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
    $(".stt-addon", context).each(function () {
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

                    // Used babeljs.io to convert ES6 version of the code (smartguide.utils.tts.js lines 93 to 107) to ES5 compliant for IE11
                    function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { Promise.resolve(value).then(_next, _throw); } }
                    function _asyncToGenerator(fn) { return function () { var self = this, args = arguments; return new Promise(function (resolve, reject) { var gen = fn.apply(self, args); function _next(value) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value); } function _throw(err) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err); } _next(undefined); }); }; }

                    navigator.mediaDevices.getUserMedia({
                        video: false,
                        audio: true
                    }).then(function () {
                        var _ref = _asyncToGenerator(regeneratorRuntime.mark(function _callee(stream) {
                        var options, StereoAudioRecorder;
                        return regeneratorRuntime.wrap(function _callee$(_context) {
                        while (1) {
                            switch (_context.prev = _context.next) {
                            case 0:
                                options = {
                                mimeType: "audio/wav",
                                numberOfAudioChannels: 1
                                }; //Start Actual Recording

                                StereoAudioRecorder = RecordRTC.StereoAudioRecorder;
                                record = new StereoAudioRecorder(stream, options);
                                record.record();

                            case 4:
                            case "end":
                                return _context.stop();
                            }
                        }
                        }, _callee);
                    }));

                    return function (_x) {
                        return _ref.apply(this, arguments);
                    };
                    }());
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