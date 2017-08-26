module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


renderStep : Int -> Step -> Html Msg
renderStep index step =
    let
        classes =
            if step == Off then
                "step"
            else
                "step _active"
    in
        button
            [ onClick (ToggleStep index step)
            , class classes
            ]
            []


renderSequence : Array Step -> List (Html Msg)
renderSequence sequence =
    Array.toList <| Array.indexedMap renderStep sequence


renderTrack : Track -> Html Msg
renderTrack track =
    div [ class "track" ]
        [ p [] [ text track.name ]
        , div [ class "track-sequence" ] (renderSequence track.sequence)
        ]


view : Model -> Html Msg
view model =
    div []
        [ renderTrack model.track
        , text (toString model)
        ]
