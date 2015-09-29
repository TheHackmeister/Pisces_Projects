load_ready(function() {
	if(debug) console.log("Integrate .remove_button with update_object in edit_object.");
	$('body').on('click', '.edit_object', load_object);
	$('body').on('click', '#lightbox input[type="submit"]', save_object); 
	$('body').on('ajax:success', '.remove_button', delete_object);

	// These are a hold out from the old method of adding things.
	// It is probably the source of my double call too. 
	/*
	$('form[data-update-target]').on('ajax:success', function(evt, data) {
	  var target = $(this).data('update-target');
	  var result = $('#' + target).append(data);
	  if(!result.children().last().hasClass('validation_error')) {
	    this.reset(); //Clears the form as long as their wasn't an error.
	  }
	});
	$('form[data-update-target]').on('ajax:error', function(evt, data) {
	  var target = $(this).data('update-target');
	  $('#' + target).append('<div class="validation_error">There was an error communicating with the server. Please try again. Refresh to remove this error.</div>');
	});
	*/
});

function load_object(e) {
	$.ajax({
		context: this,
		url: $(e.target).attr('href'),
		dataType: 'html',
		method: 'GET',
		data: {format: 'js'},
		success: add_to_lightbox,
		error: insert_error_message 
	});
	return false; // Stops propogation. Otherwise it requests it twice.
} 

function add_to_lightbox(input) {
	if(debug == true) console.log("Check errors for add_to_lightbox");
	if(debug == true) console.log("Make sure save gets a js.");

	$('#lightbox').html(input);
	var form = $('#lightbox form');
	if(form.size()) {
		form.first().attr('data-remote', 'true');
//		form.first().append($('<input>').
//				attr('type', 'hidden').
//				attr('name', 'format').
//				val('js'));
	}
	$('#lightbox_container').addClass('show');	
}


function save_object(e) {
	if(debug == true) console.log("Check for insert_error_message in save_object");
	var button = $(e.target);
	var form = $('#lightbox form').first();
	if(button.val() == "Cancel") {
		hide_lightbox();
	} else if(button.val() == "Save") {
		$.ajax({
			url: form.attr('action'),
			dataType: 'html',
			method: 'POST', // PATCH
			data: form.serialize() + '&format=js',
			success: update_object,
			failure: insert_error_message
		});
		hide_lightbox();	
	}

	return false; // Stop propogation. 
}
	

function hide_lightbox() {
	$('#lightbox_container').removeClass('show');
	$('#lightbox').html("");
}


function update_object(results, not_used, headers) {
	var replace_item = headers.getResponseHeader('replace_item');
	var replace_id = headers.getResponseHeader('replace_id');
	results = $(results);
	var item = $('[data-' + replace_item + '="' + replace_id + '"]');

	if(item.size()) {
		item.html(results.html());
		insert_flash_message('Updated ' + replace_item.replace('_', ' ') + ' successfully.');
	} else {
		var container = $('div[data-' + replace_item + '="container"]');
		if(container.size()) {
			container.append(results);
			insert_flash_message('Created ' + replace_item.replace('_', ' ') + ' successfully.');
		} else {
			insert_error_message("Could not add new " + replace_item + ".");
		}
	}
}

function delete_object(e, results, not_used, headers) {
	var element = $(e.target);
	insert_flash_message(results);
	element.parent().parent().remove(); // Assumption is div(row) > div(column) > a(link).
}
