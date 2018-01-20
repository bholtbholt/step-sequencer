module Views.PlaybackControls exposing (renderPlaybackControls)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


renderPlaybackButton : Model -> Html Msg
renderPlaybackButton model =
    let
        togglePlayback =
            if model.playback == Stopped then
                StartPlayback
            else
                StopPlayback
    in
        button
            [ onClick togglePlayback
            , classList
                [ ( "playback-button", True )
                , ( "_playing", model.playback == Playing )
                , ( "_stopped", model.playback == Stopped )
                ]
            ]
            []


renderBPM : Model -> Html Msg
renderBPM model =
    input
        [ class "bpm-input"
        , value (toString model.bpm)
        , maxlength 3
        , type_ "number"
        , Html.Attributes.min "60"
        , Html.Attributes.max "300"
        , onInput UpdateBPM
        ]
        []


renderPlaybackControls : Model -> Html Msg
renderPlaybackControls model =
    div [ class "playback-controls" ]
        [ renderPlaybackButton model
        , renderBPM model
        ]
