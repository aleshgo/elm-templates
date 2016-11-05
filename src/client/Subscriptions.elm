module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Alert.Subscriptions
import Time exposing (second)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map AlertMsg (Alert.Subscriptions.subs model.alert)
        , Time.every second Tick
        ]
