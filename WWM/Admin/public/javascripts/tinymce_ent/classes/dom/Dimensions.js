
define("tinymce/dom/Dimensions", [
	"tinymce/util/Arr",
	"tinymce/dom/NodeType",
	"tinymce/geom/ClientRect"
], function(Arr, NodeType, ClientRect) {

	function getClientRects(node) {
		function toArrayWithNode(clientRects) {
			return Arr.map(clientRects, function(clientRect) {
				clientRect = ClientRect.clone(clientRect);
				clientRect.node = node;

				return clientRect;
			});
		}

		if (Arr.isArray(node)) {
			return Arr.reduce(node, function(result, node) {
				return result.concat(getClientRects(node));
			}, []);
		}

		if (NodeType.isElement(node)) {
			return toArrayWithNode(node.getClientRects());
		}

		if (NodeType.isText(node)) {
			var rng = node.ownerDocument.createRange();

			rng.setStart(node, 0);
			rng.setEnd(node, node.data.length);

			return toArrayWithNode(rng.getClientRects());
		}
	}

	return {
		/**
		 * Returns the client rects for a specific node.
		 *
		 * @method getClientRects
		 * @param {Array/DOMNode} node Node or array of nodes to get client rects on.
		 * @param {Array} Array of client rects with a extra node property.
		 */
		getClientRects: getClientRects
	};
});
