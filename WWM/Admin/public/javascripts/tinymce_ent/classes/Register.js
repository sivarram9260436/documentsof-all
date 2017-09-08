
define("tinymce/Register", [
], function() {
	/*eslint consistent-this: 0 */
	var context = this || window;

	var tinymce = function() {
		return context.tinymce;
	};

	if (typeof context.define === "function") {
		// Bolt
		if (!context.define.amd) {
			context.define("ephox/tinymce", [], tinymce);
		}
	}

	return {};
});
