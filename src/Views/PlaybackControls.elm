module Views.PlaybackControls exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


renderCursorPoint : Model -> Int -> Set String -> Html Msg
renderCursorPoint model index _ =
    let
        activeClass =
            if model.playbackPosition == index then
                "_active"
            else
                ""
    in
        li [ class activeClass ] []


renderCursor : Model -> Html Msg
renderCursor model =
    ul
        [ class "cursor" ]
        (Array.toList <| Array.indexedMap (renderCursorPoint model) model.playbackSequence)


renderPlaybackButton : Model -> Html Msg
renderPlaybackButton model =
    let
        togglePlayback =
            if model.playback == Stopped then
                StartPlayback
            else
                StopPlayback

        buttonClasses =
            if model.playback == Playing then
                "playback-button _playing"
            else
                "playback-button _stopped"
    in
        button
            [ onClick togglePlayback
            , class buttonClasses
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


renderControlPanel : Model -> Html Msg
renderControlPanel model =
    div [ class "playback-controls" ]
        [ renderPlaybackButton model
        , renderBPM model
        ]
