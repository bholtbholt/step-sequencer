module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


renderStep : Int -> Int -> Step -> Html Msg
renderStep trackIndex stepIndex step =
    let
        classes =
            if step == Off then
                "step"
            else
                "step _active"
    in
        button
            [ onClick (ToggleStep trackIndex stepIndex step)
            , class classes
            ]
            []


renderSequence : Int -> Array Step -> List (Html Msg)
renderSequence trackIndex sequence =
    Array.toList <| Array.indexedMap (renderStep trackIndex) sequence


renderTrack : Int -> Track -> Html Msg
renderTrack trackIndex track =
    div [ class "track" ]
        [ p [] [ text track.name ]
        , div [ class "track-sequence" ] (renderSequence trackIndex track.sequence)
        ]


view : Model -> Html Msg
view model =
    div []
        [ div [] (Array.toList <| Array.indexedMap renderTrack model.tracks)
        , text (toString model)
        ]
