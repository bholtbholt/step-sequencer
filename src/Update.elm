module Update exposing (update)

import Types exposing (..)
import Array exposing (..)
import Set exposing (..)


initTrack : Track
initTrack =
    { sequence = Array.initialize 16 (always Off)
    , name = "update"
    , clip = "update"
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleStep trackIndex trackClip stepIndex step ->
            let
                toggledStep =
                    if step == Off then
                        On
                    else
                        Off

                newSequence =
                    Array.set stepIndex toggledStep selectedTrack.sequence

                newTrack =
                    { selectedTrack | sequence = newSequence }

                -- can I get this track without a maybe? Set a record within a set
                selectedTrack =
                    Maybe.withDefault initTrack (Array.get trackIndex model.tracks)

                updateSequence trackClip =
                    if Set.member trackClip selectedSequence then
                        Set.remove trackClip selectedSequence
                    else
                        Set.insert trackClip selectedSequence

                -- can I get this sequence without a maybe? Do nothing if it can't find it
                selectedSequence =
                    Maybe.withDefault Set.empty (Array.get stepIndex model.playbackSequence)
            in
                ( { model
                    | tracks = Array.set trackIndex newTrack model.tracks
                    , playbackSequence = Array.set stepIndex (updateSequence trackClip) model.playbackSequence
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
