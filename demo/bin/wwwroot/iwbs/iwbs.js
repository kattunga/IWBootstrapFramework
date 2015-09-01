$(document).ready(function () {
	$('[data-toggle="tooltip"]').tooltip();
	if (typeof webshims !== "undefined") {
		webshims.polyfill('forms forms-ext');
	}
});

function AsyncCreateControl(tag, id, parentId) {
	var elem = document.getElementById(id);
	if (elem === null) {
		if (parentId === "body") {
			var parent = document.body;
		} else {
			var parent = document.getElementById(parentId);
		}
		if (parent !== null) {
			elem = document.createElement(tag);
			elem.id = id;
			parent.appendChild(elem);
		}
	}
}
