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
    choiceVotebuilder(data);
  });
});

  function choiceVotebuilder(data){
    var choice = data.choice_id;
    var choice = "#choice_" + choice.toString();
    console.log(choice);
    var choices = $('[id^="choice_"]');
    var currentTotalVotes = 0
    for (var i = 0; i < choices.length; i++) {
      currentTotalVotes += parseInt(choices[i].getAttribute("data-votecount"));
    };
    currentTotalVotes++
    console.log(currentTotalVotes);
    $(choice + ' .vote-count').text("Votes: " + data.vote_count);
    $(choice + ' .progress-bar').attr('style', "width: " + (data.vote_count / currentTotalVotes * 100) + "%");
  };


//choices[1].getAttribute("id")
//choices[1].getAttribute("data-votecount")

// $('[id^="choice_"]');

// choices = $('[id^="choice_"]');

//choices[0].getAttribute("data-votecount")
