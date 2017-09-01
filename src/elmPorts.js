(() => {
  let playbackFunction;
  const app = Elm.Main.embed(document.body);

  app.ports.startPlayback.subscribe(bpm => {
    playbackFunction = setInterval(() => {
      app.ports.updatePlaybackPosition.send(null);
    }, bpm);
  });

  app.ports.stopPlayback.subscribe(() => {
    clearInterval(playbackFunction);
  });
})();
