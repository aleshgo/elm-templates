module Nav.Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (..)


urlUpdate : Result String Page -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    case result of
        Err _ ->
            ( model, Navigation.modifyUrl (toPath model.page) )

        Ok page ->
            case page of
                _ ->
                    { model
                        | page = page
                    }
                        ! []
