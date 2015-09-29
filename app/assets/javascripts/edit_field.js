load_ready(function () {
	$('body').on('click', 'div[data-field]', load_field);
	$('body').on('blur', '.edit_field', save_field_edit); 

	// These are needed to be able to skip invalid blurs when in an ajax field. 
	if(debug) console.log('Consider figuring out how to make select_search_check not global. In edit_field.');
	select_search_check = false;
	// For search_html.
	$('body').on('mousedown', 'a.search_selector', function(event) { select_search_check = true;});
	$('body').on('mouseup', 'a.search_selector', function(event) { select_search_check = false;});
	// For date picker.
	$('body').on('mousedown', '.edit_field.date_picker select', function(event) { select_search_check = true;});
	$('body').on('mouseup', '.edit_field.date_picker select', function(event) { select_search_check = false;});

	// This fixes the date into something rails can understand.
	$('body').on('change', '.edit_field.date_picker select', date_picker_fix);
});

function load_field(e) {
	console.log("OK");
	var text = $(this);
	text.addClass('waiting');

	var path = text.parents('[data-path]').data('path');
	path = path ? path + '/' : ''; // If there isn't any extra path, don't add anything. 
	var id = text.parents('[data-id]').data('id');

	// Make json request. 
	$.ajax({
		context: this,
		url: path + id + '/edit',
		dataType: 'html',
		method: 'GET',
		data: {format: 'js', 'field_name': text.data('field')},
		success: insert_field_edit,
		error: insert_error_message 
	});
}

function insert_field_edit(response){
	var text = $(this);	
	text.removeClass('waiting');
	text.hide();

	var edit_area = $(response);
	text.after(edit_area); // Inserts text_area after the text. 
	edit_area.find(':input').filter(':visible:first').focus();
}

function save_field_edit(e) {
	  edit_container = $(this);
	  if(select_search_check == true) {
		  select_search_check = false;
		  return;
	  }

	  var edit_field = edit_container.find(':input').first();
	  var text = edit_container.prev('div');

	  var path = text.parents('[data-path]').data('path');
	  path = path ? path + '/' : ''; // If there isn't any extra path, don't add anything. 
	  var id = text.parents('[data-id]').data('id');
	  var model = text.parents('[data-model]').data('model');

	  edit_field.addClass('waiting');

	  // This creates the data hash with a dynamic key. Normally hashs can't have dynamic keys. 
	  var key = model + '[' + edit_container.data('field-name') + ']'
		  var data_hash = (function(hash) { hash[key]= edit_field.val(); return hash;})({});
	  $.ajax({
		  context: edit_container,
		  url: path + id,
		  dataType: 'json',
		  method: 'PUT',
		  data: $.extend({format: 'js'}, data_hash), 
		  success: update_field,
		  error: insert_error_message
	  });
}


function update_field(response) {
	if(response['error']) {
		insert_flash_message(response['error']);
		$(this).removeClass('waiting');
		return;
	}

	var text_area = $(this);
	var text = text_area.prev('div');
	var field_name = text_area.data('field-name').replace(/_id$/, '');
	text.html(response['results']);
	text_area.remove();
	text.show();
	insert_flash_message('Updated ' + field_name.replace('_', ' ') + ' successfully.');
}

// This is needed to translate the date into something rails understands.
function date_picker_fix(e) {
	var field = $(this);
	var hidden = field.parent().find('input').first();
	var selecter = field.attr('name');
	var regex = /\(\di\)/;
	var selecter = regex.exec(selecter)[0].replace('(', '').replace(')', '');

	switch(selecter) {
		case '1i':
			hidden.val(hidden.val().replace(/\d+$/, field.val()));
			console.log("Year?");
		break;
		case '2i':
			hidden.val(hidden.val().replace(/^\d+/, field.val()));
			console.log("Month?");
		break;
		case '3i':
			hidden.val(hidden.val().replace(/\/\d+\//, '/' + field.val() + '/'));
			console.log("Day?");
		break;
	}
}
