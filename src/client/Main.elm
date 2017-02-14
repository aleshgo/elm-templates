module Main exposing (..)

import Html
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (..)
import Nav.Update exposing (pageUpdate)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    pageUpdate location initialModel


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
