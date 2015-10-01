$(".events.vote").ready(function() {

  var ready = function() {

    $('#choice-submit').click(function() {
      event.preventDefault();
      var choiceValue = $( "input:radio[name=choice]:checked" ).val();
      $.post('/votes',{ choice: choiceValue });
      $('.question').hide();
      $('.holding-message').show();
    });

    function pusherKey(){
      var event_number = $('#pusher-key').text();
      return event_number
    };

    pusher = new Pusher(pusherKey(), {
      encrypted: true
    });

    channel = pusher.subscribe('test_channel');
    return channel.bind(myEvent(), function(data) {
      buildQuestion(data);
    });

    function myEvent(){
      var event_number = $('#event-id').text();
      return "event_" + event_number
    };
  };

  $(document).ready(ready);
  $(document).on('page:load', ready);

});

function buildQuestion(data) {
  $('.question').show();
  $('.holding-message').hide();
  $('#testing').text(data.test);
  $('#question-number').text(data.question.question_number);
  $('#question-title').text(data.question.content);
  var $choiceOptions = $('#dvOptions');
  $choiceOptions.empty();
  for ( var i = 0; i < data.choices.length; i++) {
     $choiceOptions.append($('<li class="list-group-item"><input type="radio" name="choice" value="'
     + data.choices[i].id + '"><label for="choice">'
     + data.choices[i].content + '</label></li>'));
    };
};
