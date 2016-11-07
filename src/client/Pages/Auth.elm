module Pages.Auth exposing (..)

import Models exposing (Model)
import Html exposing (Html, div, text, button, h3, input, label)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, type', placeholder)
import Messages exposing (Msg(..))
import Date exposing (fromTime)
import Nav.Models exposing (Page(..))
import I18n.LocaleData exposing (translate, TranslationId(..))


authPage : Model -> Html Msg
authPage model =
    let
        authHeader =
            case model.page of
                Login ->
                    text <| translate model.locale LoginHeader

                SignUp ->
                    text <| translate model.locale SignUpHeader

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
                    [ authButton (GoToPage SignUp) (translate model.locale ToSignUpButton)
                    , authButton ClickLogIn (translate model.locale LoginButton)
                    ]

                SignUp ->
                    [ authButton (GoToPage Login) (translate model.locale ToLoginButton)
                    , authButton ClickSignUp (translate model.locale SignUpButton)
                    ]

                _ ->
                    []
    in
        div [ class "bg-gallery flex justify-center items-center height-full" ]
            [ div [ class "flex flex-column rounded-top width-300 p2 box-shadow bg-white" ]
                [ div [ class "width-full bg-mariner white" ] [ h3 [ class "center" ] [ authHeader ] ]
                , authInput SetUsername "text" (translate model.locale UsernameInput)
                , authInput SetPassword "password" (translate model.locale PasswordInput)
                , authCheckbox ToggleRemember (translate model.locale RememberCheckbox)
                , div [ class "flex mt3 mb1 height-30 width-full" ] (authLinks)
                ]
            ]
