/*jslint browser: true*/
/*global $, webshims*/

// this add support for webshims and jquery >= 1.12.0
// issue https://github.com/aFarkas/webshim/issues/560
jQuery.swap = function( elem, options, callback, args ) {
    var ret, name, old = {};
    // Remember the old values, and insert the new ones
    for ( name in options ) {
            old[ name ] = elem.style[ name ];
            elem.style[ name ] = options[ name ];
    }

    ret = callback.apply( elem, args || [] );

    // Revert the old values
    for ( name in options ) {
            elem.style[ name ] = old[ name ];
    }
    return ret;
};

$(document).ready(function () {
	// if library webshims is linked, activate it
	if (typeof webshims !== "undefined") {
		webshims.polyfill('forms forms-ext');
	}
});

function AsyncRenderControl(id, parentSelector, htmlTag) {
	var elem = document.getElementById(id);
	if (elem === null && parentSelector === "") {
		return false;
	}
	if (elem === null) {
		var scrp = $(parentSelector).children('script');
		if (scrp.length === 0) {
			$(parentSelector).append(htmlTag);
		} else {
			$(scrp[0]).before(htmlTag);
		}
	} else {
		$("#" + id).replaceWith(htmlTag);
	}
	var formTag = $("body > form[name='SubmitForm']");
	var hidInpt;
	$("#" + id).find('input, select, textarea').each(function () {
		hidInpt = $(formTag).find("input[name='" + this.name + "']");
		if (hidInpt.length === 0) {
			formTag.append('<input type="hidden" name="' + this.name + '">');
		}
	});
	if (typeof webshims !== "undefined") {
		$("#" + id).updatePolyfill();
	}
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
