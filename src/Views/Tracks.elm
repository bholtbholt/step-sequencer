module Views.Tracks exposing (renderTracks, renderTrackSelector)

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
            [ onClick (ToggleStep trackIndex trackClip stepIndex)
            , class classes
            ]
            []


renderSequence : Int -> Track -> List (Html Msg)
renderSequence trackIndex track =
    Array.toList <| Array.indexedMap (renderStep trackIndex track.clip) track.sequence


renderTrack : Int -> Track -> Html Msg
renderTrack trackIndex track =
    let
        classes =
            if track.isActive then
                "track _active"
            else
                "track _hidden"
    in
        div [ class classes ]
            [ p [ class "track-title" ] [ text track.name ]
            , div [ class "track-sequence" ] (renderSequence trackIndex track)
            ]


renderTrackButton : Int -> Track -> Html Msg
renderTrackButton trackIndex track =
    let
        classes =
            if track.isActive then
                "selector-button _active"
            else
                "selector-button"
    in
        button
            [ onClick (ActivateTrack trackIndex)
            , class classes
            ]
            [ text track.name ]


renderTrackSelector : Model -> Html Msg
renderTrackSelector model =
    div [ class "track-selector" ] (Array.toList <| Array.indexedMap renderTrackButton model.tracks)


renderTracks : Model -> Html Msg
renderTracks model =
    div [ class "tracks" ] (Array.toList <| Array.indexedMap renderTrack model.tracks)
