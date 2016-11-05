module Pages.Auth exposing (..)

import Models exposing (Model)
import Html exposing (Html, div, text, button, h3, input, label)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, type', placeholder)
import Messages exposing (Msg(..))
import Date exposing (fromTime)
import Nav.Models exposing (Page(..))


authPage : Model -> Html Msg
authPage model =
    let
        authHeader =
            case model.page of
                Login ->
                    text "Log In"

                SignUp ->
                    text "Sign Up"

                _ ->
                    text ""

        authInput i t p =
            input [ class "width-full height-40 font-14 mt2 px1", placeholder p, type' t, onInput i ] []

        authButton c t =
            button [ class "flex-auto rounded border-none bg-mariner white mx1", onClick c ] [ text t ]

        authCheckbox c t =
            case model.page of
                Login ->
                    label []
                        [ input [ class "mt2", type' "checkbox", onClick c ] []
                        , text t
                        ]

                SignUp ->
                    text ""

                _ ->
                    text ""

        authLinks =
            case model.page of
                Login ->
                    [ authButton (GoToPage SignUp) "Create an account"
                    , authButton ClickLogIn "Login"
                    ]

                SignUp ->
                    [ authButton (GoToPage Login) "Log in to your account"
                    , authButton ClickSignUp "Create"
                    ]

                _ ->
                    []
    in
        div [ class "bg-gallery flex justify-center items-center height-full" ]
            [ div [ class "flex flex-column rounded-top width-300 p2 box-shadow bg-white" ]
                [ div [ class "width-full bg-mariner white" ] [ h3 [ class "center" ] [ authHeader ] ]
                , authInput SetUsername "text" "Username"
                , authInput SetPassword "password" "Password"
                , authCheckbox ToggleRemember "Remember a token"
                , div [ class "flex mt3 mb1 height-30 width-full" ] (authLinks)
                ]
            ]
