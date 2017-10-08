(() => {
  // Safari tends to cleanup the tracks after some inactivity
  // and disabling autoSuspend retains the audio in memory
  window.Howler.autoSuspend = false;

  const kick = new Howl({ src: ['./samples/kck.mp3'] });
  const snare = new Howl({ src: ['./samples/snr.mp3'] });
  const hat = new Howl({ src: ['./samples/hat.mp3'] });
  const samples = {
    kick: kick,
    snare: snare,
    hat: hat,
  };

  const app = Elm.Main.embed(document.body);

  app.ports.startPlayback.subscribe(clips => {
    clips.map(clip => samples[clip].play());
  });
})();
