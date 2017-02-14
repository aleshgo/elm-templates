module Nav.Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Navigation
import UrlParser
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (pageParser, toPath)


pageUpdate : Navigation.Location -> Model -> ( Model, Cmd Msg )
pageUpdate location model =
    case UrlParser.parsePath pageParser location of
        Nothing ->
            ( model, Navigation.modifyUrl (toPath Home))

        Just page ->
            case page of
                Home ->
                    ( { model | page = page }, Cmd.none)
                Pages pageId ->
                    ( { model | page = page, pageId = pageId }, Cmd.none)

