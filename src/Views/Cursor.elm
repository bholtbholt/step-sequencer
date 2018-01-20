module Views.Cursor exposing (renderCursor)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


renderCursorPoint : Model -> Int -> Set String -> Html Msg
renderCursorPoint model index _ =
    li
        [ classList
            [ ( "_active", model.playbackPosition == index && model.playback == Playing )
            ]
        ]
        []


renderCursor : Model -> Html Msg
renderCursor model =
    ul
        [ class "cursor" ]
        (Array.toList <| Array.indexedMap (renderCursorPoint model) model.playbackSequence)
