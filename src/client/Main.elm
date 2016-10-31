module Main exposing (..)

import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
