module Alert.Subscriptions exposing (..)

import Alert.Models exposing (Model)
import Alert.Messages exposing (Msg(..))
import Time exposing (millisecond)


subs : Model -> Sub Msg
subs model =
    Time.every millisecond Tick
