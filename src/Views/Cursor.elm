module Views.Cursor exposing (renderCursor)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


renderCursorPoint : Model -> Int -> Set String -> Html Msg
renderCursorPoint model index _ =
    let
        activeClass =
            if model.playbackPosition == index && model.playback == Playing then
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
