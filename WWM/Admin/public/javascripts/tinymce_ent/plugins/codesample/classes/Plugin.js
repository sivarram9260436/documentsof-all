
define("tinymce/codesampleplugin/Plugin", [
	"tinymce/Env",
	"tinymce/PluginManager",
	"tinymce/codesampleplugin/Prism",
	"tinymce/codesampleplugin/Dialog",
	"tinymce/codesampleplugin/Utils"
], function(Env, PluginManager, Prism, Dialog, Utils) {
	var addedInlineCss, trimArg = Utils.trimArg;

	PluginManager.add('codesample', function(editor, pluginUrl) {
		var $ = editor.$, addedCss;

		if (!Env.ceFalse) {
			return;
		}

		// Todo: use a proper css loader here
		function loadCss() {
			var linkElm;

			if (editor.inline && addedInlineCss) {
				return;
			}

			if (!editor.inline && addedCss) {
				return;
			}

			if (editor.inline) {
				addedInlineCss = true;
			} else {
				addedCss = true;
			}

			linkElm = editor.dom.create('link', {
				rel: 'stylesheet',
				href: pluginUrl + '/css/prism.css'
			});

			editor.getDoc().getElementsByTagName('head')[0].appendChild(linkElm);
		}

		editor.on('PreProcess', function(e) {
			$('pre[contenteditable=false]', e.node).
				filter(trimArg(Utils.isCodeSample)).
				each(function(idx, elm) {
					var $elm = $(elm), code = elm.textContent;

					$elm.attr('class', $.trim($elm.attr('class')));
					$elm.removeAttr('contentEditable');

					$elm.empty().append($('<code></code>').each(function() {
						// Needs to be textContent since innerText produces BR:s
						this.textContent = code;
					}));
				});
		});

		editor.on('SetContent', function() {
			var unprocessedCodeSamples = $('pre').filter(trimArg(Utils.isCodeSample)).filter(function(idx, elm) {
				return elm.contentEditable !== "false";
			});

			if (unprocessedCodeSamples.length) {
				editor.undoManager.transact(function() {
					unprocessedCodeSamples.each(function(idx, elm) {
						$(elm).find('br').each(function(idx, elm) {
							elm.parentNode.replaceChild(editor.getDoc().createTextNode('\n'), elm);
						});

						elm.contentEditable = false;
						elm.innerHTML = editor.dom.encode(elm.textContent);
						Prism.highlightElement(elm);
						elm.className = $.trim(elm.className);
					});
				});
			}
		});

		editor.addCommand('codesample', function() {
			Dialog.open(editor);
		});

		editor.addButton('codesample', {
			cmd: 'codesample',
			title: 'Insert/Edit code sample'
		});

		editor.on('init', loadCss);
	});
});
