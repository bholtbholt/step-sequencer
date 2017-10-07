module Views.Credits exposing (renderCredits)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


creditLink : String -> String -> Html Msg
creditLink title link =
    li []
        [ a
            [ href link
            , target "_blank"
            , class "credit-link"
            ]
            [ text title ]
        ]


renderCredits : Html Msg
renderCredits =
    div [ class "credits" ]
        [ h1 [ class "credit-title" ]
            [ text "Elm"
            , strong [] [ text "Drum" ]
            ]
        , ul [ class "credit-links" ]
            [ li [] [ text "Made in Elm by Brian Holt" ]
            , creditLink "Github" "https://github.com/bholtbholt/step-sequencer"
            , creditLink "Twitter" "https://twitter.com/BHOLTBHOLT"
            ]
        ]
