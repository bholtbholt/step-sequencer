module Types exposing (..)

import Array exposing (..)
import Set exposing (..)


type alias Model =
    { tracks : Array Track
    , playback : Playback
    , playbackPosition : PlaybackPosition
    , playbackSequence : Array (Set String)
    , bpm : Float
    }


type alias Track =
    { sequence : Array Step
    , name : String
    , clip : String
    }


type Step
    = On
    | Off


type Playback
    = Playing
    | Stopped


type alias PlaybackPosition =
    Int


type Msg
    = ToggleStep Int String Int Step
    | TogglePlayback
