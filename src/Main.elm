module Main exposing (main)

import Html exposing (..)
import Array exposing (..)
import Set exposing (..)
import Types exposing (..)
import Update exposing (update)
import Views.Tracks exposing (..)
import Views.PlaybackControls exposing (..)


initSequence : Array Step
initSequence =
    Array.initialize 16 (always Off)


initHat : Track
initHat =
    { sequence = initSequence
    , name = "Hat"
    , clip = "hat.wav"
    }


initSnare : Track
initSnare =
    { sequence = initSequence
    , name = "Snare"
    , clip = "snare.wav"
    }


initKick : Track
initKick =
    { sequence = initSequence
    , name = "Kick"
    , clip = "kick.wav"
    }


init : ( Model, Cmd.Cmd Msg )
init =
    ( { playback = Stopped
      , playbackPosition = 0
      , playbackSequence = Array.initialize 16 (always Set.empty)
      , bpm = 120
      , tracks = Array.fromList [ initHat, initSnare, initKick ]
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


view : Model -> Html Msg
view model =
    div []
        [ renderCursor model
        , renderTracks model
        , renderControlPanel model
        , p [] [ text (toString model) ]
        ]
