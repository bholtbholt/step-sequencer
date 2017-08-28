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


renderControlPanel : Model -> Html Msg
renderControlPanel model =
    button [ onClick TogglePlayback ] [ text <| toString model.playback ]
