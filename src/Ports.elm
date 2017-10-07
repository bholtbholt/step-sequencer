port module Ports exposing (..)

import Types exposing (..)
import Time exposing (..)


port startPlayback : List String -> Cmd msg


bpmToMilliseconds : Int -> Float
bpmToMilliseconds bpm =
    let
        secondsPerMinute =
            Time.minute / Time.second

        millisecondsPerSecond =
            Time.second

        beats =
            4
    in
        ((secondsPerMinute / (toFloat bpm) * millisecondsPerSecond) / beats)


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.playback == Playing then
        Time.every (bpmToMilliseconds model.bpm) UpdatePlaybackPosition
    else
        Sub.none
