module Subscriptions exposing (subscriptions)

import Types exposing (..)
import Time exposing (..)


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
