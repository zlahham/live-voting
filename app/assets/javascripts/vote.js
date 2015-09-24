$(document).ready(function() {
  var channel, pusher;
  console.log('hello');
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
    }
  };
  pusher = new Pusher('8881c0f8a42807b64625', {
    encrypted: true
  });
  channel = pusher.subscribe('test_channel');
  return channel.bind('my_event', function(data) {
    console.log('message received');
    $('#testing').text(data.test);
  });
});
