module View exposing (..)

import Html exposing (Html, div, text, button, h3, input)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, type')
import Messages exposing (Msg(..))
import Auth.Messages
import Models exposing (Model)
import Auth.View exposing (authBox)
import String
import Date exposing (fromTime)


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
            div []
                [ div [] [ text <| "Hello: " ++ model.auth.username ]
                , div [] [ text <| "Token iat: " ++ toString (fromTime <| toFloat model.auth.iat) ]
                , div [] [ text <| "Token exp: " ++ toString (fromTime <| toFloat model.auth.exp) ]
                , div [] [ button [ onClick <| AuthMsg Auth.Messages.ClickLogOut ] [ text "LogOut" ] ]
                ]
        else
            Html.App.map AuthMsg (authBox model.auth)
