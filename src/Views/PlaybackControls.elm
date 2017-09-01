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
    in
        button [ onClick togglePlayback ] [ text <| toString model.playback ]


renderControlPanel : Model -> Html Msg
renderControlPanel model =
    renderPlaybackButton model
