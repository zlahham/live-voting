# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  console.log('hello');

  Pusher.log = (message) ->
    if window.console and window.console.log
      window.console.log message
    return

  questionTitle = $('#question-title')
  pusher = new Pusher('8881c0f8a42807b64625', encrypted: true)
  channel = pusher.subscribe('test_channel')
  channel.bind 'my_event', (data) ->
    alert data.message
    title = data.questionTitle
    updateQuestion title
    return


# $( document ).ready(function() {
#
# });
