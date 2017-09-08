
define("tinymce/ui/ReflowQueue", [
	"tinymce/util/Delay"
], function(Delay) {
	var dirtyCtrls = {}, animationFrameRequested;

	return {
		/**
		 * Adds a control to the next automatic reflow call. This is the control that had a state
		 * change for example if the control was hidden/shown.
		 *
		 * @method add
		 * @param {tinymce.ui.Control} ctrl Control to add to queue.
		 */
		add: function(ctrl) {
			var parent = ctrl.parent();

			if (parent) {
				if (!parent._layout || parent._layout.isNative()) {
					return;
				}

				if (!dirtyCtrls[parent._id]) {
					dirtyCtrls[parent._id] = parent;
				}

				if (!animationFrameRequested) {
					animationFrameRequested = true;

					Delay.requestAnimationFrame(function() {
						var id, ctrl;

						animationFrameRequested = false;

						for (id in dirtyCtrls) {
							ctrl = dirtyCtrls[id];

							if (ctrl.state.get('rendered')) {
								ctrl.reflow();
							}
						}

						dirtyCtrls = {};
					}, document.body);
				}
			}
		},

		/**
		 * Removes the specified control from the automatic reflow. This will happen when for example the user
		 * manually triggers a reflow.
		 *
		 * @method remove
		 * @param {tinymce.ui.Control} ctrl Control to remove from queue.
		 */
		remove: function(ctrl) {
			if (dirtyCtrls[ctrl._id]) {
				delete dirtyCtrls[ctrl._id];
			}
		}
	};
});
