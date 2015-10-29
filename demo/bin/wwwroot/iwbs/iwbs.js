/*jslint browser: true*/
/*global $, webshims*/

$(document).ready(function () {
	// if library webshims is linked, activate it
	if (typeof webshims !== "undefined") {
		webshims.polyfill('forms forms-ext');
	}
});

function AsyncRenderControl(id, parentSelector, htmlTag) {
	var elem = document.getElementById(id);
	if (elem === null) {
		$(parentSelector).append(htmlTag);
	} else {
		$("#" + id).replaceWith(htmlTag);
	}
	var formTag = $("body > form[name='SubmitForm']");
	var hidInpt;
	$("#" + id).find('input, select').each(function () {
		hidInpt = $(formTag).find("input[name='" + this.name + "']");
		if (hidInpt.length === 0) {
			formTag.append('<input type="hidden" name="' + this.name + '">');
		}
	});
}

function AsyncDestroyControl(id) {
	var elem = document.getElementById(id);
	if (elem !== null) {
		var formTag = $("body > form[name='SubmitForm']");
		var hidInpt;
		$(elem).find('input').each(function () {
			$(formTag).find("input[name='" + this.name + "']").remove();
		});
	}
	$("#" + id).remove();
	var iwelem = window[id + "IWCL"];
	if (iwelem !== null) {
		iwelem.IWRelease();
		iwelem.remove();
	}
}
