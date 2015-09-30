$(document).ready(function() {
  var cl = new CanvasLoader('canvasloader-container');
  cl.setColor('#7067CF'); // default is '#000000'
  cl.setShape('spiral'); // default is 'oval'
  cl.setDiameter(200); // default is 40
  cl.setDensity(108); // default is 40
  cl.setRange(1); // default is 1.3
  cl.setSpeed(1); // default is 2
  cl.setFPS(60); // default is 24
  cl.show(); // Hidden by default

  // This bit is only for positioning - not necessary
    // var loaderObj = document.getElementById("canvasLoader");
    // loaderObj.style.position = "absolute";
    // loaderObj.style["top"] = cl.getDiameter() * -0.5 + "px";
    // loaderObj.style["left"] = cl.getDiameter() * -0.5 + "px";
});