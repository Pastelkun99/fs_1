var script = document.createElement('script');
script.src = 'https://code.jquery.com/jquery-3.4.1.min.js';
script.type = 'text/javascript';
document.getElementsByTagName('head')[0].appendChild(script);

$("input:checkbox").on('click', function() {
	var $box = $(this);
	if ($box.is(":checked")) {
		var group = "input:checkbox[id='" + $box.attr("id") + "']";
		$(group).prop("checked", false);
		$box.prop("checked", true);
	} else {
		$box.prop("checked", false);
	}
});

var limit = 2;
$('input.commitCheck17').on('change', function(evt) {
	if ($(this).siblings(':checked').length >= limit) {
		this.checked = false;
	}
})
