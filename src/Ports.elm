port module Ports exposing (..)

import Types exposing (..)
import Time exposing (..)


port startPlayback : List String -> Cmd msg


bpmToMilliseconds : Float -> Float
bpmToMilliseconds bpm =
    let
        secondsPerMinute =
            Time.minute / Time.second

        millisecondsPerSecond =
            Time.second

        beats =
            4
    in
        ((secondsPerMinute / bpm * millisecondsPerSecond) / beats)


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.playback == Playing then
        Time.every (bpmToMilliseconds model.bpm) UpdatePlaybackPosition
    else
        Sub.none
