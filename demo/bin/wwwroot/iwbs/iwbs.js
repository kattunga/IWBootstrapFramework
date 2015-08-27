$(document).ready(
	function(){
		// enable bootstrap tooltips
		$('[data-toggle="tooltip"]').tooltip();
		
		// configure polyfill
		if (typeof webshims != "undefined") {
		//	webshims.setOptions('forms-ext', {types: 'date'});
			webshims.polyfill('forms forms-ext');
		}
	}
);
