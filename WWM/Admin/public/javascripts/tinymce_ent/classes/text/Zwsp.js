
define("tinymce/text/Zwsp", [], function() {
	var ZWSP = '\u200b';

	function isZwsp(chr) {
		return chr == ZWSP;
	}

	function trim(str) {
		return str.replace(new RegExp(ZWSP, 'g'), '');
	}

	return {
		isZwsp: isZwsp,
		ZWSP: ZWSP,
		trim: trim
	};
});
