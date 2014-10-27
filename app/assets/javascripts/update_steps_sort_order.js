function update_steps_sort_order() {
  jQuery(function() {
    return $('#steps').sortable({
      axis: 'y',
      items: '.item',
      cursor: 'move',
      sort: function(e, ui) {
        return ui.item.addClass('active-item-shadow');
      },
      stop: function(e, ui) {
        return ui.item.removeClass('active-item-shadow');
      },
      update: function(e, ui) {
        var item_id, position;
        item_id = ui.item.data('item-id');
        console.log(item_id);
        position = ui.item.index();
        return $.ajax({
          type: 'POST',
          url: '/steps/update_row_order',
          dataType: 'json',
          data: {
            step: {
              step_id: item_id,
              row_order_position: position
            }
          }
        });
      }
    });
  });

};

/*jQuery ->
    $('#steps').sortable(
      axis: 'y'
      items: '.item'
      cursor: 'move'

      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        # highlight the row on drop to indicate an update
        #ui.item.children('div').effect('highlight', {}, 1000)
      update: (e, ui) ->
        item_id = ui.item.data('item-id')
        console.log(item_id)
        position = ui.item.index() # this will not work with paginated items, as the index is zero on every page
        $.ajax(
          type: 'POST'
          url: '/steps/update_row_order'
          dataType: 'json'
          data: { step: {step_id: item_id, row_order_position: position } }
        )
    )
*/