/*jslint browser: true*/
/*global $, webshims*/

$(document).ready(function () {
	// if library webshims is linked, activate it
	if (typeof webshims !== "undefined") {
		webshims.polyfill('forms forms-ext');
	}
});

function AsyncCreateControl(id, parentId, htmlTag) {
	var elem = document.getElementById(id);
	var parent;
	if (elem === null) {
		if (parentId === "body") {
			parent = document.body;
		} else {
			parent = document.getElementById(parentId);
		}
		if (parent !== null) {
			parent.insertAdjacentHTML('beforeEnd', htmlTag);
		}
	}
}

function AsyncRenderControl(id, htmlTag) {
	var elem = document.getElementById(id);
	if (elem !== null) {
		$(elem).html(htmlTag);
		var formTag = $("body > form[name='SubmitForm']");
		var hidInpt;
		$(elem).find('input').each(function () {
			hidInpt = $(formTag).find("input[name='"+this.name+"']");
			if (hidInpt.length === 0) {
				formTag.append('<input type="hidden" name="'+this.name+'">');
			}
		});
	}
}

function AsyncDestroyControl(id) {
	var elem = document.getElementById(id);
	if (elem !== null) {
		var formTag = $("body > form[name='SubmitForm']");
		var hidInpt;
		$(elem).find('input').each(function () {
			$(formTag).find("input[name='"+this.name+"']").remove();
		});
	}
	var iwelem = window[id + "IWCL"];
	if (iwelem !== null) {
		iwelem.IWRelease();
		iwelem.remove();
	}
}
