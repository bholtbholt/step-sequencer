module Types exposing (..)

import Array exposing (..)
import Set exposing (..)
import Time exposing (..)


type alias Model =
    { tracks : Array Track
    , playback : Playback
    , playbackPosition : PlaybackPosition
    , playbackSequence : Array (Set Clip)
    , bpm : Int
    }


type alias Track =
    { sequence : Array Step
    , name : String
    , clip : Clip
    , isActive : Bool
    }


type Step
    = On
    | Off


type Playback
    = Playing
    | Stopped


type alias PlaybackPosition =
    Int


type alias Clip =
    String


type Msg
    = ToggleStep Int String Int
    | StartPlayback
    | StopPlayback
    | UpdatePlaybackPosition Time
    | UpdateBPM String
    | ActivateTrack Int
