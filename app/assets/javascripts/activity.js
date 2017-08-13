$(function() {

  // on click
  $(".favorite").click( function() {
    var req_id = $(this).data('req_id');
    $.ajax({
      type: "POST",
      url: 'my_requests_favorited/' + req_id,
      success: function() {
        var filled_status = $('img.favorite#' + req_id).data('filled');

        if(filled_status == "true") {
          $('img.favorite#' + req_id).data('filled') = "false";
          $('img.favorite#' + req_id).attr('src') = 'images/star_icon.png';
        } else {
          $('img.favorite#' + req_id).data('filled') = "true";
          $('img.favorite#' + req_id).attr('src') = 'images/star_filled_icon.png';
        }
      }
    });
  });

});
