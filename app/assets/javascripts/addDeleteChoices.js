$(document).ready(function(){
  $("#addNewChoice").click(function() {
    $("#choices-div").append(createNewInputElement($("#choices-div")));
  });
});

function createNewInputElement(form) {
  var newIndex = $("#choices-div").children('input#choice-entry').length;
  var newInput = $("#choice-entry").clone().attr('name', generateNewInputName(newIndex));
  newInput.val('');
  return newInput;
};

function generateNewInputName(idx) {
  return "question[choices_attributes][" + idx + "][content]"
};


$(document).ready(function(){
  $("#deleteNewChoice").click(function() {
    $("#choices-div input:last-child").remove();
  });
});

