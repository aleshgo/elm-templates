module Login.View exposing (loginView)

import Html exposing (Html, div, input, br, button, text, p)
import Html.Attributes exposing (placeholder, type')
import Html.Events exposing (onClick, onInput)

import Login.Models exposing (LoginModel)
import Login.Messages exposing (Msg(..))


loginView : LoginModel -> Html Msg
loginView model =
    div []
        [ input [ type' "text", placeholder "username", onInput UserName ] []
         , br [] []
         , input [type' "password", placeholder "password", onInput UserPassword ] []
         , br [] []
         , button [ type' "button", onClick SignIn ] [ text "login" ]
         ]