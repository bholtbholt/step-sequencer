module Main exposing (main)

import Html exposing (..)
import Array exposing (..)
import Types exposing (..)
import Update exposing (update)
import View exposing (view)


initTrack : Array Step
initTrack =
    Array.initialize 16 (always Off)


init : ( Model, Cmd.Cmd Msg )
init =
    ( { playback = Stopped
      , playbackPosition = 1
      , bpm = 120
      , track =
            { sequence = initTrack
            , name = "Kick"
            }
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
