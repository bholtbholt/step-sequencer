module Views.Tracks exposing (renderTracks, renderTrackSelector)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


renderStep : TrackIndex -> Sample -> StepIndex -> Step -> Html Msg
renderStep trackIndex trackSample stepIndex step =
    button
        [ onClick (ToggleStep trackIndex trackSample stepIndex)
        , classList
            [ ( "step", True )
            , ( "_active", step == Active )
            ]
        ]
        []


renderSequence : TrackIndex -> Track -> List (Html Msg)
renderSequence trackIndex track =
    Array.indexedMap (renderStep trackIndex track.sample) track.sequence
        |> Array.toList


renderTrack : TrackIndex -> Track -> Html Msg
renderTrack trackIndex track =
    div
        [ classList
            [ ( "track", True )
            , ( "_hidden", not track.isActive )
            ]
        ]
        [ p [ class "track-title" ] [ text track.name ]
        , div [ class "track-sequence" ] (renderSequence trackIndex track)
        ]


renderTrackButton : TrackIndex -> Track -> Html Msg
renderTrackButton trackIndex track =
    button
        [ onClick (ActivateTrack trackIndex)
        , classList
            [ ( "selector-button", True )
            , ( "_active", track.isActive )
            ]
        ]
        [ text track.name ]


renderTrackSelector : Model -> Html Msg
renderTrackSelector model =
    div [ class "track-selector" ] (Array.toList <| Array.indexedMap renderTrackButton model.tracks)


renderTracks : Model -> Html Msg
renderTracks model =
    div [ class "tracks" ] (Array.toList <| Array.indexedMap renderTrack model.tracks)
