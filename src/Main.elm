module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Array exposing (..)
import Set exposing (..)
import Types exposing (..)
import Update exposing (update)
import Ports exposing (subscriptions)
import Views.Cursor exposing (renderCursor)
import Views.Tracks exposing (renderTracks)
import Views.PlaybackControls exposing (renderPlaybackControls)
import Views.Credits exposing (renderCredits)


initSequence : Array Step
initSequence =
    Array.initialize 16 (always Off)


initHat : Track
initHat =
    { sequence = initSequence
    , name = "Hat"
    , clip = "hat"
    }


initSnare : Track
initSnare =
    { sequence = initSequence
    , name = "Snare"
    , clip = "snare"
    }


initKick : Track
initKick =
    { sequence = initSequence
    , name = "Kick"
    , clip = "kick"
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
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view model =
    div [ class "step-sequencer" ]
        [ renderCursor model
        , renderTracks model
        , div
            [ class "control-panel" ]
            [ renderPlaybackControls model
            , renderCredits
            ]
        ]
