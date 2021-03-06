load_ready(function () {
  $('body').on('keypress', '.search_field', function(event) { if(event.keyCode == 13) {return false;} else {return true;}});
  $('body').on('keyup', '.search_field', search_field);
  $('body').on('click', 'a.search_selector', select_search);
});

function search_field (e) {
    switch (e.keyCode) {
    	case 38: // Up
    	case 40: //Down
			search_html_change_selected(e);
    		break;
        case 13: // Enter (Keypad)
        case 10: // Enter (Normal)
        	$(e.target).parent().find('.selected').click();
        	break;
        case 8: //Backspace
        case 46: //Delete
            if($(e.target).val() == "") {
                get_search_container(e.target).eq(0).find('.search_id').eq(0).val('');
                break;
            }
        default:
            searchAJAX(e.target,getURL(e.target, "path"));
            //console.log(e.target);
            break;
    }
}

function search_html_change_selected(e) {
	var input_field = $(e.target);
	var curr = $(get_search_container(e.target).find('.selected'));//May need not $
	curr.removeClass('selected');
	if(e.keyCode == 38) { // Up
		if(curr.prevAll('a').length == 0) curr.parent().find('a').last().addClass('selected');
		curr.prevAll('a').eq(0).addClass('selected');
		
	} else if (e.keyCode == 40) { // Down
		if(curr.nextAll('a').length == 0) curr.parent().find('a').eq(0).addClass('selected');
		curr.nextAll('a').eq(0).addClass('selected');
	}
}

function getURL(field, tag){
    field = $(field).eq(0);
    var json = jQuery.extend({},field.data(tag)); //This weird call clones the json object.
    var url = json.path + "?";
    var input = json.input;
    //console.log(json);
    delete json.path;
    delete json.input;
   // if(Object.keys(json).length > 0) {
		$(json).each(function(key, val){
			$.each(val, function(key, val) {
				//console.log("Key: " + key + " Val: " + val);
				url += key + "=" + val + "&";
			});
		});
	//}
    url += input + "=" + field.val() + "*";
    //console.log(url); 
    return  url;
}

function searchAJAX(cont,url) {
    $.ajax({
        context: cont,
        url: url,
        dataType: "json"
    }).done(function(results){
	for(var key in results) {break;}; // Gets the key.
	results = results[key];
        results = results.slice(0,7);  //Limits to the top 7 results
        search_result(cont,results,"id",$(cont).data('display-field'));
        });
}


function search_result(field,results,id_key, display_key) {
    var r_field = get_search_container(field).find(".search_results");
    r_field.html("");

    $.each(results, function () {
        var elm = $('<a data-id="' + this[id_key] + '"/>'); // Have to put the id here. elm.data() doesn't work.
        elm.addClass("search_selector");
        elm.html(this[display_key]);

        r_field.append(elm);
        r_field.append('<br/>');
    });
    r_field.find('a').eq(0).addClass('selected'); 
}

function get_search_container(elm) {
    elm = $(elm);
    var container = $(elm).parent();
    if(container.hasClass('field_with_errors')) {
        container = $(elm).parent().parent();
    }
    return container;
}

function select_search(e) {
    var elm = $(e.target);
    var search_container = elm.parent().parent();
    search_container.find(".search_field").val(elm.html()).focus();
    search_container.find(".search_id").val(elm.data('id'));
    search_container.find('.search_results').html("");
}
