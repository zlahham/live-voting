var audioContext = new AudioContext();


function playSine(pitch) {
  var startTime = audioContext.currentTime;
  var endTime = startTime + 0.1;

  var biquadFilter = audioContext.createBiquadFilter();
  biquadFilter.connect(audioContext.destination);
  biquadFilter.type = "lowpass";
  biquadFilter.frequency.value = 80;
  biquadFilter.gain.value = 1;

  var envelope = audioContext.createGain();
  envelope.connect(biquadFilter);
  envelope.gain.value = 0;
  envelope.gain.setTargetAtTime(1, startTime, .5);
  envelope.gain.setTargetAtTime(0, endTime, .1);

  var oscillator = audioContext.createOscillator();
  oscillator.connect(envelope);
  oscillator.type = 'sine';
  oscillator.detune.value = (pitch) * 100;
  oscillator.start(startTime);
  oscillator.stop(endTime + 3);
}
