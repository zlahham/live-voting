$(document).ready(function() {

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
    $('.question').show();
    $('.holding-message').hide();
    $('#testing').text(data.test);
    $('#question-number').text(data.question.id);
    $('#question-title').text(data.question.content);
    $('#choice-1-text').text(data.choices[0].content);
    $('#choice-2-text').text(data.choices[1].content);
    $('#choice-1').val(data.choices[0].id);
    $('#choice-2').val(data.choices[1].id);

  });

  function myEvent(){
    var event_number = $('#event-id').text();
    return "event_" + event_number
  };

  $('#choice-submit').click(function() {
    event.preventDefault();
    console.log('clicked submit');
  });

});
