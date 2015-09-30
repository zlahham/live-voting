$(document).ready(function() {


  $('#choice-submit').click(function() {
    event.preventDefault();
    var choiceValue = $( "input:radio[name=choice]:checked" ).val();
    console.log();
    $.post('/votes',{ choice: choiceValue });
    $('.question').hide();
    $('.holding-message').show();
    console.log( choiceValue );
  });

  var channel, pusher;
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
      window.console.log(window.location.href);
    }
  };

  function pusherKey(){
    var event_number = $('#pusher-key').text();
    return event_number
  };

  pusher = new Pusher(pusherKey(), {
    encrypted: true
  });
  channel = pusher.subscribe('test_channel');
  return channel.bind(myEvent(), function(data) {
    console.log('message received');
    buildQuestion(data);
    currentChoice(choiceValue);
  });

  function myEvent(){
    var event_number = $('#event-id').text();
    return "event_" + event_number
  };

});


function currentChoice(choiceValue) {
  console.log(choiceValue)
}

function buildQuestion(data) {
  $('.question').show();
  $('.holding-message').hide();
  $('#testing').text(data.test);
  $('#question-number').text(data.question.question_number);
  $('#question-title').text(data.question.content);
  $('#question-id').text(data.question.id);
  var $choiceOptions = $('#dvOptions');
  $choiceOptions.empty();
  for ( var i = 0; i < data.choices.length; i++) {
     $choiceOptions.append($('<li><input type="radio" name="choice" value="'
     + data.choices[i].id + '"><label for="choice">'
     + data.choices[i].content + '</label></li>'));
    };
  $( ".question-form").submit(function(){
    console.log("hiya")
  });
};
