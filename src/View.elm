module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


-- Can i curry trackIndex this function to apply it in ToggleStep?


renderStep : Int -> Step -> Html Msg
renderStep stepIndex step =
    let
        classes =
            if step == Off then
                "step"
            else
                "step _active"
    in
        button
            [ onClick (ToggleStep 0 stepIndex step)
            , class classes
            ]
            []


renderSequence : Int -> Array Step -> List (Html Msg)
renderSequence trackIndex sequence =
    Array.toList <| Array.indexedMap renderStep sequence


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
