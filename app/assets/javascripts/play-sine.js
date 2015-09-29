var audioContext = new AudioContext();


function playSine(delay, pitch, duration) {
  var startTime = audioContext.currentTime + delay;
  var endTime = startTime + duration;

  var envelope = audioContext.createGain();
  envelope.connect(audioContext.destination);
  envelope.gain.value = 0;
  envelope.gain.setTargetAtTime(1, startTime, 0.1);
  envelope.gain.setTargetAtTime(0, endTime, 0.2);

  var oscillator1 = audioContext.createOscillator();
  oscillator1.connect(envelope);
  oscillator1.type = 'sine';
  oscillator1.detune.value = (pitch) * 100;
  oscillator1.start(startTime);
  oscillator1.stop(endTime + 2);
}
