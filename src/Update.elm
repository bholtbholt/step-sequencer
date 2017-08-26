module Update exposing (update)

import Types exposing (..)
import Array exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleStep index step ->
            let
                toggledStep =
                    if step == Off then
                        On
                    else
                        Off

                selectedTrack =
                    model.track

                newSequence =
                    Array.set index toggledStep selectedTrack.sequence

                newTrack =
                    { selectedTrack | sequence = newSequence }
            in
                ( { model | track = newTrack }
                , Cmd.none
                )
