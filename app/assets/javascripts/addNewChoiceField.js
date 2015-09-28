$(document).ready(function(){
  $("#addNewChoice").click(function() {
    $("#new_question").append(createNewInputElement($("#new_question")));
  });
});

function createNewInputElement(form) {
  var newIndex = $("#new_question").children('input#choice-entry').length;
  var newInput = $("#choice-entry").clone().attr('name', generateNewInputName(newIndex));
  return newInput;
}

function generateNewInputName(idx) {
  return "question[choices_attributes][" + idx + "][content]"
}