function round(value, exp) {
  if (typeof exp === 'undefined' || +exp === 0)
    return Math.round(value);

  value = +value;
  exp  = +exp;

  if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0))
    return NaN;

  // Shift
  value = value.toString().split('e');
  value = Math.round(+(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp)));

  // Shift back
  value = value.toString().split('e');
  return +(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp));
}

$(function(){
	function tally (selector) {
		$(selector).each(function () {
			var total = 0,
				column = $(this).siblings(selector).andSelf().index(this);
			$(this).parents().prevUntil(':has(' + selector + ')').each(function () {
				total += parseFloat($('td.sum:eq(' + column + ')', this).html()) || 0;
				total=round(total,2);
			})
			$(this).html(total);
		});
	}
	tally('td.subtotal');
	tally('td.total');
});