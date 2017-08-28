module Main exposing (main)

import Html exposing (..)
import Array exposing (..)
import Types exposing (..)
import Update exposing (update)
import View exposing (view)


initSequence : Array Step
initSequence =
    Array.initialize 16 (always Off)


initTrack : Track
initTrack =
    { sequence = initSequence
    , name = "Track"
    }


init : ( Model, Cmd.Cmd Msg )
init =
    ( { playback = Stopped
      , playbackPosition = 1
      , bpm = 120
      , tracks = Array.initialize 4 (always initTrack)
      }
    , Cmd.none
    )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = always Sub.none
        }
