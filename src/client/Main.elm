module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, ModelStorage, initModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (..)
import Nav.Update exposing (urlUpdate)
import Time exposing (Time)


type alias Flags =
    { modelStorage : Maybe ModelStorage
    , time : Time
    }


init : Flags -> Result String Page -> ( Model, Cmd Msg )
init flags result =
    urlUpdate result (initModel flags.modelStorage flags.time)


main =
    Navigation.programWithFlags urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
