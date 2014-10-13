function search_field (e) {
    switch (e.keyCode) {
        case 13:
        case 10:
            break;

        default:
            searchAJAX(e.target,getURL(e.target, "path"));
            //console.log(e.target);
            break;
    }
}

function getURL(field, tag){
    field = $(field).eq(0);
    return field.data(tag) + field.val();
}

function search_result(field,results,id_key, display_key) {
    var r_field = $(field).parent().find("div.search_results");
    r_field.html("");

    $.each(results, function () {
        var elm = $('<a data-id="' + this[id_key] + '"/>'); // Have to put the id here. elm.data() doesn't work.
        elm.addClass("search_selector");
        elm.html(this[display_key]);

        r_field.append(elm);
        r_field.append('<br/>');
    });
}

function select_search(e) {
    var elm = $(e.target);
    var search_container = elm.parent().parent();
    search_container.find(".search_field").val(elm.html());
    search_container.find(".search_id").val(elm.data('id'));
    search_container.find('.search_results').html("");

}

function searchAJAX(cont,url) {
    $.ajax({
        context: cont,
        url: url,
        dataType: "json"
    }).done(function(results){
            results = results.slice(0,7);  //Limits to the top 7 results
            search_result(cont,results,"id","customer_name");
        });
}

function window_ready() {
    $('body').on('keyup', '.search_field', search_field);
    $('body').on('click', 'a.search_selector', select_search);
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
}

$(window).ready(window_ready);
$(window).on('page:load', window_ready);

