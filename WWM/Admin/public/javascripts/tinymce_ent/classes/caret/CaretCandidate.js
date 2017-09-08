
define("tinymce/caret/CaretCandidate", [
	"tinymce/dom/NodeType",
	"tinymce/util/Arr",
	"tinymce/caret/CaretContainer"
], function(NodeType, Arr, CaretContainer) {
	var isContentEditableTrue = NodeType.isContentEditableTrue,
		isContentEditableFalse = NodeType.isContentEditableFalse,
		isBr = NodeType.isBr,
		isText = NodeType.isText,
		isInvalidTextElement = NodeType.matchNodeNames('script style textarea'),
		isAtomicInline = NodeType.matchNodeNames('img input textarea hr iframe video audio object'),
		isTable = NodeType.matchNodeNames('table'),
		isCaretContainer = CaretContainer.isCaretContainer;

	function isCaretCandidate(node) {
		if (isCaretContainer(node)) {
			return false;
		}

		if (isText(node)) {
			if (isInvalidTextElement(node.parentNode)) {
				return false;
			}

			return true;
		}

		return isAtomicInline(node) || isBr(node) || isTable(node) || isContentEditableFalse(node);
	}

	function isInEditable(node, rootNode) {
		for (node = node.parentNode; node && node != rootNode; node = node.parentNode) {
			if (isContentEditableFalse(node)) {
				return false;
			}

			if (isContentEditableTrue(node)) {
				return true;
			}
		}

		return true;
	}

	function isAtomicContentEditableFalse(node) {
		if (!isContentEditableFalse(node)) {
			return false;
		}

		return Arr.reduce(node.getElementsByTagName('*'), function(result, elm) {
			return result || isContentEditableTrue(elm);
		}, false) !== true;
	}

	function isAtomic(node) {
		return isAtomicInline(node) || isAtomicContentEditableFalse(node);
	}

	function isEditableCaretCandidate(node, rootNode) {
		return isCaretCandidate(node) && isInEditable(node, rootNode);
	}

	return {
		isCaretCandidate: isCaretCandidate,
		isInEditable: isInEditable,
		isAtomic: isAtomic,
		isEditableCaretCandidate: isEditableCaretCandidate
	};
});
