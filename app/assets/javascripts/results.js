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

  channel = pusher.subscribe('vote_count_channel');
  return channel.bind('new_message', function(data) {
    console.log(data);
    console.log('message received');
    var choice = data.choice_id;
    var choice = "#choice_" + choice.toString();
    console.log(choice)
    $(choice + ' .vote-count').text(data.vote_count);
    drawGraph(data[0].vote_count, data[1].vote_count);
  });
});
