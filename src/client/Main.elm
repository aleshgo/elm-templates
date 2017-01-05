module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, ModelStorage, initModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (..)
import Nav.Update exposing (pageUpdate)
import Time exposing (Time)


type alias Flags =
    { modelStorage : Maybe ModelStorage
    , time : Time
    , language : String
    }


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags result =
    pageUpdate result (initModel flags.modelStorage flags.time flags.language)


main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
