module Events exposing (..)

import Html.Events exposing (on)
import Html exposing (Attribute)
import Json.Decode as Json


onSelect : (String -> msg) -> Attribute msg
onSelect handler =
    on "change" <| Json.map handler <| Json.at [ "target", "value" ] Json.string
