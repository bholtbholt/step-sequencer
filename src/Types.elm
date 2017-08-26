module Types exposing (..)

import Array exposing (..)


type alias Model =
    { track : Track
    , playback : Playback
    , playbackPosition : PlaybackPosition
    , bpm : Float
    }


type Step
    = On
    | Off


type Playback
    = Playing
    | Stopped


type alias PlaybackPosition =
    Int


type alias Track =
    { sequence : Array Step
    , name : String
    }


type Msg
    = ToggleStep Int Step
