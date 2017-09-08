
define("tinymce/Env", [], function() {
	var nav = navigator, userAgent = nav.userAgent;
	var opera, webkit, ie, ie11, ie12, gecko, mac, iDevice, android, fileApi, phone, tablet, windowsPhone;

	function matchMediaQuery(query) {
		return "matchMedia" in window ? matchMedia(query).matches : false;
	}

	opera = window.opera && window.opera.buildNumber;
	android = /Android/.test(userAgent);
	webkit = /WebKit/.test(userAgent);
	ie = !webkit && !opera && (/MSIE/gi).test(userAgent) && (/Explorer/gi).test(nav.appName);
	ie = ie && /MSIE (\w+)\./.exec(userAgent)[1];
	ie11 = userAgent.indexOf('Trident/') != -1 && (userAgent.indexOf('rv:') != -1 || nav.appName.indexOf('Netscape') != -1) ? 11 : false;
	ie12 = (userAgent.indexOf('Edge/') != -1 && !ie && !ie11) ? 12 : false;
	ie = ie || ie11 || ie12;
	gecko = !webkit && !ie11 && /Gecko/.test(userAgent);
	mac = userAgent.indexOf('Mac') != -1;
	iDevice = /(iPad|iPhone)/.test(userAgent);
	fileApi = "FormData" in window && "FileReader" in window && "URL" in window && !!URL.createObjectURL;
	phone = matchMediaQuery("only screen and (max-device-width: 480px)") && (android || iDevice);
	tablet = matchMediaQuery("only screen and (min-width: 800px)") && (android || iDevice);
	windowsPhone = userAgent.indexOf('Windows Phone') != -1;

	if (ie12) {
		webkit = false;
	}

	// Is a iPad/iPhone and not on iOS5 sniff the WebKit version since older iOS WebKit versions
	// says it has contentEditable support but there is no visible caret.
	var contentEditable = !iDevice || fileApi || userAgent.match(/AppleWebKit\/(\d*)/)[1] >= 534;

	return {
		/**
		 * Constant that is true if the browser is Opera.
		 *
		 * @property opera
		 * @type Boolean
		 * @final
		 */
		opera: opera,

		/**
		 * Constant that is true if the browser is WebKit (Safari/Chrome).
		 *
		 * @property webKit
		 * @type Boolean
		 * @final
		 */
		webkit: webkit,

		/**
		 * Constant that is more than zero if the browser is IE.
		 *
		 * @property ie
		 * @type Boolean
		 * @final
		 */
		ie: ie,

		/**
		 * Constant that is true if the browser is Gecko.
		 *
		 * @property gecko
		 * @type Boolean
		 * @final
		 */
		gecko: gecko,

		/**
		 * Constant that is true if the os is Mac OS.
		 *
		 * @property mac
		 * @type Boolean
		 * @final
		 */
		mac: mac,

		/**
		 * Constant that is true if the os is iOS.
		 *
		 * @property iOS
		 * @type Boolean
		 * @final
		 */
		iOS: iDevice,

		/**
		 * Constant that is true if the os is android.
		 *
		 * @property android
		 * @type Boolean
		 * @final
		 */
		android: android,

		/**
		 * Constant that is true if the browser supports editing.
		 *
		 * @property contentEditable
		 * @type Boolean
		 * @final
		 */
		contentEditable: contentEditable,

		/**
		 * Transparent image data url.
		 *
		 * @property transparentSrc
		 * @type Boolean
		 * @final
		 */
		transparentSrc: "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7",

		/**
		 * Returns true/false if the browser can or can't place the caret after a inline block like an image.
		 *
		 * @property noCaretAfter
		 * @type Boolean
		 * @final
		 */
		caretAfter: ie != 8,

		/**
		 * Constant that is true if the browser supports native DOM Ranges. IE 9+.
		 *
		 * @property range
		 * @type Boolean
		 */
		range: window.getSelection && "Range" in window,

		/**
		 * Returns the IE document mode for non IE browsers this will fake IE 10.
		 *
		 * @property documentMode
		 * @type Number
		 */
		documentMode: ie && !ie12 ? (document.documentMode || 7) : 10,

		/**
		 * Constant that is true if the browser has a modern file api.
		 *
		 * @property fileApi
		 * @type Boolean
		 */
		fileApi: fileApi,

		/**
		 * Constant that is true if the browser supports contentEditable=false regions.
		 *
		 * @property ceFalse
		 * @type Boolean
		 */
		ceFalse: (ie === false || ie > 8),

		desktop: !phone && !tablet,
		windowsPhone: windowsPhone
	};
});
