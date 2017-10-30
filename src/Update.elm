port module Update exposing (update)

import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


port sendClips : List String -> Cmd msg


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


updatePlaybackSequence : Int -> Clip -> Array (Set Clip) -> Array (Set Clip)
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

                stepClips =
                    Array.get newPosition model.playbackSequence
                        |> Maybe.withDefault Set.empty
            in
                ( { model | playbackPosition = newPosition }, sendClips (Set.toList stepClips) )

        UpdateBPM bpm ->
            let
                newBPM =
                    Result.withDefault model.bpm (String.toInt bpm)
            in
                ( { model | bpm = newBPM }, Cmd.none )

        ToggleStep trackIndex trackClip stepIndex ->
            ( { model
                | tracks = updateTrackStep trackIndex stepIndex model.tracks
                , playbackSequence = updatePlaybackSequence stepIndex trackClip model.playbackSequence
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
