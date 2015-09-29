debug = true

function load_ready(func) {
  $(window).ready(func);
  $(window).on('page:load', func);
}

load_ready(function() {

	// Show/hides things. 
	$('body').on('click', '.hide_toggle', hide_toggle);
	$('body').on('click', '.outline', function(){ $(this).toggleClass("outline_expanded"); });

	// This makes sure .full_text is the correct size to start with.
	$('.full_text').autosize();    
	
	update_steps_sort_order();

});
  
function hide_toggle(e) {
	  $('#' + $(e.target).data('target')).toggle();
	  if($(e.target).html().indexOf('Show') > -1) {
	    $(e.target).html($(e.target).html().replace('Show', 'Hide'));	
	  } else {
	    $(e.target).html($(e.target).html().replace('Hide', 'Show'));
	  }
}

function insert_flash_message(message){
  message = message + "<br>";
  $('#flash').append(message);
  setTimeout(function(){$('#flash').html($('#flash').html().replace(message,''));}, 5000);
}

function insert_error_message(e) {
  $(this).removeClass('waiting');
  insert_flash_message("Could not connect with server.");
}
