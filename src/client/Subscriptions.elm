module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Auth.Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map AuthMsg (Auth.Subscriptions.subs model.auth)
