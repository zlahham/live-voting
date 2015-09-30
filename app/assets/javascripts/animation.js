$(".events.vote").ready(function() {

  var cl = new CanvasLoader('canvasloader-container');
    cl.setColor('#7067CF');
    cl.setShape('spiral');
    cl.setDiameter(200);
    cl.setDensity(108);
    cl.setRange(1);
    cl.setSpeed(1);
    cl.setFPS(60);
    cl.show();

});
