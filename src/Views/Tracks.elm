module Views.Tracks exposing (renderTracks, renderTrackSelector)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Array exposing (..)


renderStep : Playback -> PlaybackPosition -> TrackIndex -> Sample -> StepIndex -> Step -> Html Msg
renderStep playback playbackPosition trackIndex trackSample stepIndex step =
    button
        [ onClick (ToggleStep trackIndex trackSample stepIndex)
        , classList
            [ ( "step", True )
            , ( "_active", step == Active )
            , ( "_flashing", playback == Playing && playbackPosition == stepIndex && step == Active )
            ]
        ]
        []


renderSequence : Playback -> PlaybackPosition -> TrackIndex -> Track -> List (Html Msg)
renderSequence playback playbackPosition trackIndex track =
    Array.indexedMap (renderStep playback playbackPosition trackIndex track.sample) track.sequence
        |> Array.toList


renderTrack : Playback -> PlaybackPosition -> TrackIndex -> Track -> Html Msg
renderTrack playback playbackPosition trackIndex track =
    div
        [ classList
            [ ( "track", True )
            , ( "_hidden", not track.isActive )
            ]
        ]
        [ p [ class "track-title" ] [ text track.name ]
        , div [ class "track-sequence" ] (renderSequence playback playbackPosition trackIndex track)
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
    div
        [ class "tracks" ]
        (Array.toList <| Array.indexedMap (renderTrack model.playback model.playbackPosition) model.tracks)
