# Installation
Everything should automatically install by running
```yarn```

### Installation Issues
Some packages may need to be install globally if they're not running correctly:
- Elm: `npm install -g elm`
- Postcss-cli `npm i -g postcss-cli`

# Development
To start the Elm development server (Elm Reactor) and the Postcss-cli run
```yarn start```

Visit
```http://localhost:3000/reactor.html```

### IDE Settings
It's recommended to install [Prettier](https://packagecontrol.io/packages/JsPrettier) and [Elm Language Support](https://packagecontrol.io/packages/Elm%20Language%20Support) for your IDE. These tools will auto-format Elm, CSS, and JS code.

# Deploy/Building
To build/update the dist folder (which will update the Github Page repo), run
```yarn build```

*The build process should be run prior to every commit.*

# Data Design
```
steps
---
step = on | off | accent
step off = [ ]
step on  = [x]

tracks
---
name = name of track
clip = sound that triggers
sequence = static array of step statuses [on, off, off, ...]

playback controls
---
PlaybackPosition = which step is active (increments while playback === playing, resets at 16)
playback = playing | stopped
BPM = second / BPM * milliseconds = 60 / 120 * 1000
cursor = display position on the timeline

compiledSequence = reduces all the tracks into any array of triggers, so playback _should_ be smoother and more performant - [kick][hat][snare, kick][hat]

====

             ^
Hat | [ ][x][ ][x] | [ ][x][ ][x] | [ ][x][ ][x] | [ ][x][ ][x] |
Snr | [ ][ ][x][ ] | [ ][ ][x][ ] | [ ][ ][x][ ] | [ ][ ][x][ ] |
Kck | [x][ ][x][ ] | [x][ ][x][ ] | [x][ ][ ][ ] | [x][ ][ ][ ] |


[play|stop] [BPM: 120]

====
```

# CSS
CSS is run through [PostCSS](http://postcss.org). Available CSS variables are in `./postcss.config.js`.

When adding a new CSS file, you may need to restart the development server.


# Useful Links
- [Elm Guide](https://guide.elm-lang.org)
- [Elm Docs](http://elm-lang.org/docs)
- [Elm Core Package](http://package.elm-lang.org/packages/elm-lang/core/latest/)
- [Elm Html Package](http://package.elm-lang.org/packages/elm-lang/html/latest/)
- [Elm Packages](http://package.elm-lang.org)
- [Hex Colour Tool - Brightens and Darkens Colours](http://www.cssfontstack.com/oldsites/hexcolortool/)
- [Flat UI Colours](http://flatuicolors.com)
- [Howler.js - Audio API Library](https://github.com/goldfire/howler.js)
