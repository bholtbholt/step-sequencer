module Views.Tracks exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


renderStep : Int -> String -> Int -> Step -> Html Msg
renderStep trackIndex trackClip stepIndex step =
    let
        classes =
            if step == Off then
                "step"
            else
                "step _active"
    in
        button
            [ onClick (ToggleStep trackIndex trackClip stepIndex step)
            , class classes
            ]
            []


renderSequence : Int -> Track -> List (Html Msg)
renderSequence trackIndex track =
    Array.toList <| Array.indexedMap (renderStep trackIndex track.clip) track.sequence


renderTrack : Int -> Track -> Html Msg
renderTrack trackIndex track =
    div [ class "track" ]
        [ p [ class "track-title" ] [ text track.name ]
        , div [ class "track-sequence" ] (renderSequence trackIndex track)
        ]


renderTracks : Model -> Html Msg
renderTracks model =
    div [] (Array.toList <| Array.indexedMap renderTrack model.tracks)
