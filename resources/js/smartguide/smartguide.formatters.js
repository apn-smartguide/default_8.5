var formatterController = {
	init: function (sgRef) {},

	bindEvents: function (sgRef, context) {
		reformatAllFieldTypes();		
	}
}

function formatCurrency(n) {
	var res = Number(n.replace(/,/g, '').replace(/ /g, '')).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	return res;
}

function formatNumber(n) {
	if (isNaN(parseInt(n))) {
		alert("Please enter a valid number.");
		return "0";
	}
	return n.replace(/\./g, '').replace(/,/g, '').replace(/ /g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function formatPhoneFax(t) {
	var text = t.replace(/\D/g, '');
	return text.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
}

function formatPostalCode(p) {
	return p.toUpperCase();
}

function formatDecimalNumber(n) {
	if (isNaN(parseFloat(n))) {
		alert("Please enter a valid decimal number.");
		return "0.00";
	}
	// strip , from number as it causes problems in formatting expression below
	n = n.replace(/,/g, "");
	return parseFloat(n).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function reformatCurrency() {
	if ($(this).val() != '') {
		try {
			var formattedNumber = formatCurrency($(this).val());
			$(this).val(formattedNumber);
		} catch (e) {
		}
	}
}

function reformatPhone() {
	if ($(this).val() != '') {
		var formattedNumber = formatPhoneFax($(this).val());
		$(this).val(formattedNumber);
	}
}

function reformatNumber() {
	if ($(this).val() != '') {
		try {
			var formattedNumber = formatNumber($(this).val());
			$(this).val(formattedNumber);
		} catch (e) {
		}
	}
}

function reformatDecimalNumber() {
	if ($(this).val() != '') {
		try {
			var formattedNumber = formatDecimalNumber($(this).val());
			$(this).val(formattedNumber);
		} catch (e) {
		}
	}
}

function reformatPostalCode() {
	var postalcode = formatPostalCode($(this).val());
	$(this).val(postalcode);
}

function reformatAllFieldTypes(src) {
	if (typeof src != 'undefined') {
		if ($(src).hasClass('Currency') || $(src).hasClass('currency')) {
			$('input', src).each(reformatCurrency);
		}
		$('input[data-masktype=postalcanada],input[data-masktype=postalzip]').each(reformatPostalCode);
		if ($(src).hasClass('Number') || $(src).hasClass('number')) {
			$('div > input, div >input', src).each(reformatNumber);
		}
		if ($(src).hasClass('DecimalNumber') || $(src).hasClass('decimalnumber')) {
			$('input', src).each(reformatDecimalNumber);
		}
	} else {
		// apply to whole form
		$('div.Currency input,div.currency input').each(reformatCurrency);
		$('input[data-masktype=postalcanada],input[data-masktype=postalzip]').each(reformatPostalCode);
		$('div.Number > div > input, div.number > div >input').each(reformatNumber);
		$('div.DecimalNumber input, div.decimalnumber input').each(reformatDecimalNumber);
	}
}
