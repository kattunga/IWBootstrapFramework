$(document).ready(function () {
	$('[data-toggle="tooltip"]').tooltip();
	if (typeof webshims !== "undefined") {
		webshims.polyfill('forms forms-ext');
	}
	$(".btn").mouseup(function(){
		$(this).blur();
	})
});

function AsyncCreateControl(id, parentId, htmlTag) {
	var elem = document.getElementById(id);
	if (elem === null) {
		if (parentId === "body") {
			var parent = document.body;
		} else {
			var parent = document.getElementById(parentId);
		}
		if (parent !== null) {
			parent.insertAdjacentHTML('beforeEnd', htmlTag);
		}
	}
}

function AsyncDestroyControl(id) {
	var iwelem = window[id+"IWCL"];
	if (iwelem !== null) {
		iwelem.IWRelease();
		iwelem.remove();
	}
}
