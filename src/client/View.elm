module View exposing (..)

import Html exposing (Html, div, text, button, h3, input)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, type')
import Messages exposing (Msg(..))
import Models exposing (Model)
import Auth.View exposing (authBox)
import String


view : Model -> Html Msg
view model =
    let
        loggedIn =
            if String.length model.auth.token > 0 then
                True
            else
                False
    in
        if loggedIn then
            text <| "Hello: " ++ model.auth.username
        else
            Html.App.map AuthMsg (authBox model.auth)
