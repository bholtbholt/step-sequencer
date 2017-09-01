module Update exposing (update)

import Types exposing (..)
import Array exposing (..)
import Set exposing (..)
import Ports exposing (..)


setNestedArray : Int -> (a -> a) -> Array a -> Array a
setNestedArray index setFn array =
    case Array.get index array of
        Nothing ->
            array

        Just a ->
            Array.set index (setFn a) array


updateTrackStep : Int -> Int -> Array Track -> Array Track
updateTrackStep trackIndex stepIndex tracks =
    let
        toggleStep step =
            if step == Off then
                On
            else
                Off

        newSequence track =
            setNestedArray stepIndex toggleStep track.sequence

        newTrack track =
            { track | sequence = newSequence track }
    in
        setNestedArray trackIndex newTrack tracks


updatePlaybackSequence : Int -> String -> Array (Set String) -> Array (Set String)
updatePlaybackSequence stepIndex trackClip playbackSequence =
    let
        updateSequence trackClip sequence =
            if Set.member trackClip sequence then
                Set.remove trackClip sequence
            else
                Set.insert trackClip sequence
    in
        setNestedArray stepIndex (updateSequence trackClip) playbackSequence


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleStep trackIndex trackClip stepIndex ->
            ( { model
                | tracks = updateTrackStep trackIndex stepIndex model.tracks
                , playbackSequence = updatePlaybackSequence stepIndex trackClip model.playbackSequence
              }
            , Cmd.none
            )

        StartPlayback ->
            let
                seconds =
                    60

                milliseconds =
                    1000

                beats =
                    4

                bpmToMilliseconds =
                    ((seconds / model.bpm * milliseconds) / beats)
            in
                ( { model | playback = Playing }, startPlayback bpmToMilliseconds )

        StopPlayback ->
            ( { model
                | playback = Stopped
                , playbackPosition = 0
              }
            , stopPlayback ()
            )

        UpdatePlaybackPosition _ ->
            let
                newPosition =
                    if model.playbackPosition == 15 then
                        0
                    else
                        model.playbackPosition + 1
            in
                ( { model | playbackPosition = newPosition }, Cmd.none )
