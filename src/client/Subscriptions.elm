module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Ports exposing (loadBrowserLocale)


subscriptions : Model -> Sub Msg
subscriptions model =
    loadBrowserLocale LoadBrowserLocale
