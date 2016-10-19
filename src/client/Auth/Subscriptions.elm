module Auth.Subscriptions exposing (..)

import Auth.Models exposing (Model)
import Auth.Messages exposing (Msg(..))
import Auth.Ports exposing (loadToken)


subs : Model -> Sub Msg
subs model =
    loadToken LoadToken
