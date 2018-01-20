port module Update exposing (update)

import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


port sendSamples : List String -> Cmd msg


setNestedArray : Int -> (a -> a) -> Array a -> Array a
setNestedArray index setFn array =
    case Array.get index array of
        Nothing ->
            array

        Just a ->
            Array.set index (setFn a) array


updateTrackStep : TrackIndex -> StepIndex -> Array Track -> Array Track
updateTrackStep trackIndex stepIndex tracks =
    let
        toggleStep step =
            if step == Inactive then
                Active
            else
                Inactive

        newSequence sequence =
            setNestedArray stepIndex toggleStep sequence

        newTrack track =
            { track | sequence = (newSequence track.sequence) }
    in
        setNestedArray trackIndex newTrack tracks


updatePlaybackSequence : StepIndex -> Sample -> Array (Set Sample) -> Array (Set Sample)
updatePlaybackSequence stepIndex trackSample playbackSequence =
    let
        updateSequence trackSample sequence =
            if Set.member trackSample sequence then
                Set.remove trackSample sequence
            else
                Set.insert trackSample sequence
    in
        setNestedArray stepIndex (updateSequence trackSample) playbackSequence


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartPlayback ->
            ( { model | playback = Playing }, Cmd.none )

        StopPlayback ->
            ( { model
                | playback = Stopped
                , playbackPosition = 16
              }
            , Cmd.none
            )

        UpdatePlaybackPosition _ ->
            let
                newPosition =
                    if model.playbackPosition >= 15 then
                        0
                    else
                        model.playbackPosition + 1

                stepSamples =
                    Array.get newPosition model.playbackSequence
                        |> Maybe.withDefault Set.empty
            in
                ( { model | playbackPosition = newPosition }, sendSamples (Set.toList stepSamples) )

        UpdateBPM bpm ->
            let
                newBPM =
                    Result.withDefault model.bpm (String.toInt bpm)
            in
                ( { model | bpm = newBPM }, Cmd.none )

        ToggleStep trackIndex trackSample stepIndex ->
            ( { model
                | tracks = updateTrackStep trackIndex stepIndex model.tracks
                , playbackSequence = updatePlaybackSequence stepIndex trackSample model.playbackSequence
              }
            , Cmd.none
            )

        ActivateTrack trackIndex ->
            let
                activateTrack track =
                    { track | isActive = True }

                deactivateTrack track =
                    { track | isActive = False }

                newTracks =
                    model.tracks
                        |> Array.map deactivateTrack
                        |> setNestedArray trackIndex activateTrack
            in
                ( { model | tracks = newTracks }, Cmd.none )
