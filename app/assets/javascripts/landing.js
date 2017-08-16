$(document).on('turbolinks:load', function() {

  $('#donate_button').click( function() {
    mixpanel.track("donate_button_clicked", {
        "user_id": 000,
    });
  });
});
