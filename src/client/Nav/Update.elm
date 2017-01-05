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
            if not (tokenValid model) then
                ( model, Navigation.modifyUrl (toPath Login) )
            else
                ( model, Navigation.modifyUrl (toPath Home) )


        Just page ->
            if page == Home && not (tokenValid model) then
                ( { model | page = Login }, Navigation.modifyUrl (toPath Login) )
            else
                { model | page = page } ! []

