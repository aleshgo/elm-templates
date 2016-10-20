module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Alert.Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map AlertMsg (Alert.Subscriptions.subs model.alert)
