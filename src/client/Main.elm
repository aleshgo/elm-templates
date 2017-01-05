module Main exposing (..)

import Html
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
