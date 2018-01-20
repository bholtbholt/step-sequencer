module Types exposing (..)

import Array exposing (..)
import Set exposing (..)
import Time exposing (..)


type alias Model =
    { tracks : Array Track
    , playback : Playback
    , playbackPosition : PlaybackPosition
    , playbackSequence : Array (Set Sample)
    , bpm : Int
    }


type alias Track =
    { sequence : Array Step
    , name : String
    , sample : Sample
    , isActive : Bool
    }


type Step
    = Active
    | Inactive


type Playback
    = Playing
    | Stopped


type alias PlaybackPosition =
    Int


type alias Sample =
    String


type alias TrackIndex =
    Int


type alias StepIndex =
    Int


type Msg
    = ToggleStep TrackIndex Sample StepIndex
    | StartPlayback
    | StopPlayback
    | UpdatePlaybackPosition Time
    | UpdateBPM String
    | ActivateTrack TrackIndex
