module Update exposing (update)

import Types exposing (..)
import Array exposing (..)


initSequence : Array Step
initSequence =
    Array.initialize 16 (always Off)


initTrack : Track
initTrack =
    { sequence = initSequence
    , name = "Track"
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleStep trackIndex stepIndex step ->
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
            in
                ( { model | tracks = Array.set trackIndex newTrack model.tracks }
                , Cmd.none
                )
