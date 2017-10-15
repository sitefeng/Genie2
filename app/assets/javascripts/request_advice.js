
$(document).on('turbolinks:load', function() {

  $('#submit_button').click(function() {
    var questionTitle = $('#question_title').attr("value");

    if(questionTitle.length < 10 || questionTitle.length > 255) {
      alert("Question title must be 10 to 255 characters");
      $("#request_form").preventDefault(); // not working
    }

    var questionDetails = $('#details').attr("value");

    if(questionDetails.length > 5000) {
      alert("Question title must be less than 5000 characters");
      $("#request_form").preventDefault(); // not working
    }

    var requestField = $('#advice_field').attr("value");
    if(requestField.length < 2 || requestField.length > 5000) {
      alert("Advice must be 2 to 5000 characters");
      $("#request_form").preventDefault(); // not working
    }
  });

});
