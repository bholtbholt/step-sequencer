# Elm Drum
A step-sequencer for programming drum beats written in Elm. I've written a case-study which has been published in [Smashing Magazine](https://www.smashingmagazine.com) in two parts: [Part 1](https://www.smashingmagazine.com/2018/01/learning-elm-drum-sequencer-part-1/) [Part 2](https://www.smashingmagazine.com/2018/01/learning-elm-drum-sequencer-part-2/).

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

Visiting ```http://localhost:3000/``` and navigating to your Elm files utilizes the standard Elm Reactor, which doesn't contain CSS styles.

### IDE Settings
It's recommended to install [Prettier](https://packagecontrol.io/packages/JsPrettier) and [Elm Language Support](https://packagecontrol.io/packages/Elm%20Language%20Support) for your IDE. These tools will auto-format Elm, CSS, and JS code.

### Development issues in reactor.html
At times, reactor.html logs a `ReferenceError: Can't find variable: Elm`. This occurs when the Elm bundle has not recompiled fast enough or when the Elm code can't be compiled. To fix, ensure your Elm code can be compiled, and do a hard refresh.

# Deploy/Building
To build/update the dist folder (which will update the Github Page repo), run
```yarn build```

*The build process should be run prior to every commit.*

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

# Next Steps
- Clear tracks
- Clear entire sequence
- Hash url sequences to share
- Preview track?
- Mute track?
- Local storage sequences?
- Keyboard control 1-8, q-i, a-k, z-, = 8 steps; - move down = move up; [ move left ] move right
