module Views.Tracks exposing (renderTracks, renderTrackSelector)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


renderStep : TrackIndex -> Sample -> StepIndex -> Step -> Html Msg
renderStep trackIndex trackSample stepIndex step =
    let
        classes =
            if step == Active then
                "step _active"
            else
                "step"
    in
        button
            [ onClick (ToggleStep trackIndex trackSample stepIndex)
            , class classes
            ]
            []


renderSequence : TrackIndex -> Track -> List (Html Msg)
renderSequence trackIndex track =
    Array.indexedMap (renderStep trackIndex track.sample) track.sequence
        |> Array.toList


renderTrack : TrackIndex -> Track -> Html Msg
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


renderTrackButton : TrackIndex -> Track -> Html Msg
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
