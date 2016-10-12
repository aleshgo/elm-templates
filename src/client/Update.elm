module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Ports exposing (saveBrowserLocale)
import I18n.Locale as Locale


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadBrowserLocale code ->
            ( { model | locale = Locale.fromCode code }, Cmd.none )

        SaveBrowserLocale code ->
            ( { model | locale = Locale.fromCode code }, saveBrowserLocale code )
