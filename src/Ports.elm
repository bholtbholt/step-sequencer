port module Ports exposing (..)

import Types exposing (..)


port startPlayback : Float -> Cmd msg


port stopPlayback : () -> Cmd msg


port updatePlaybackPosition : (() -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    updatePlaybackPosition UpdatePlaybackPosition
