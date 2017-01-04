module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (toPath)
import Nav.Update exposing (pageUpdate)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoHomePage ->
            -- Model does not reset
            ( model, Navigation.newUrl (toPath Home) )

        GoToPage id ->
            ( model, Navigation.newUrl (toPath (Pages id)) )

        UrlChange location ->
             pageUpdate location model
