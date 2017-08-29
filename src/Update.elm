module Update exposing (update)

import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


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
            { track | sequence = (newSequence track) }
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

        TogglePlayback ->
            let
                toggledPlayback =
                    if model.playback == Stopped then
                        Playing
                    else
                        Stopped
            in
                ( { model | playback = toggledPlayback }, Cmd.none )
