$(document).ready(function() {

  var channel, pusher;
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
      window.console.log(window.location.href);
    }
  };

  pusher = new Pusher('326d4e202ebb626d7423', {
    encrypted: true
  });

  channel = pusher.subscribe('vote_count_channel');
  return channel.bind('new_message', function(data) {
    console.log(data);
    console.log('message received');
    var choice = data.choice_id;
    var choice = "#choice_" + choice.toString();
    console.log(choice)

    $(choice + ' .vote-count').text("Votes: " + data.vote_count);
  });
});
