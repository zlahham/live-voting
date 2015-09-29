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
    return event_number;
  }

  pusher = new Pusher(pusherKey(), {
    encrypted: true
  });
  channel = pusher.subscribe('test_channel');
  return channel.bind(myEvent(), function(data) {
    console.log('message received');
    buildQuestion(data);

    var choiceFromButton = data.

    buildChart(choiceFromButton);
  });

  function myEvent(){
    var event_number = $('#event-id').text();
    return "event_" + event_number;
  }

  $('#choice-submit').click(function() {
    event.preventDefault();
    console.log('clicked submit');
  });

});
