module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (..)
import Nav.Update exposing (urlUpdate)


init : Result String Page -> ( Model, Cmd Msg )
init result =
    urlUpdate result initialModel


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
