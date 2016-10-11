module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Ports exposing (saveBrowserLocale)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadBrowserLocale locale ->
            ( { model | locale = locale }, Cmd.none )

        SaveBrowserLocale locale ->
            ( { model | locale = locale }, saveBrowserLocale locale )
