module View exposing (..)

import String

import Html exposing (Html, div, text, button, input, ul, li, br, nav, p, h3)
import Html.App as App
import Html.Attributes exposing (placeholder, type', style)
import Html.Events exposing (onClick)

import Messages exposing (Msg(..))
import Models exposing (..)
import Nav.Models exposing (Page(..))

import Login.View exposing (loginView)
import Login.Models


view : Model -> Html Msg
view model =
    let
        message =
            if String.isEmpty model.login.token == False then
                "Welcome: " ++ model.login.username
            else
                "Hello guest, please sign in to use app"

    in
        div []
             [ h3 [] [ text message
             , button [ style [("display", (isLoggedIn model "inline"))]
                      , onClick LogOut
                      ]
                      [ text "Log Out" ]
             ]
            , nav [][ menu model ]
            , viewPage model ]


viewPage : Model -> Html Msg
viewPage model =
    case model.page of
        Login ->
            App.map LoginMsg (loginView model.login)

        Home ->
            div []
                [ text "Im a home page" ]

        Users ->
            div []
                [ text "Protected Page you will not see me if you weren't signed in" ]

        Pages id ->
            div []
                [ p [] [ text ("Protected Page " ++ toString id) ]
                 , p [] [ text "Protected Page you will not see me if you weren't signed in" ]
                ]


menu: Model -> Html Msg
menu model =
    ul [ style [("display", (isLoggedIn model "flex") ), ("list-style", "none")] ]
        [ li [] [ button [ onClick GoHomePage ] [ text "Go Home" ] ]
         ,li [] [ button [ onClick (GoToPage 1) ] [ text "Go to page 1" ] ]
         ,li [] [ button [ onClick (GoToPage 2) ] [ text "Go to page 2" ] ]
         ,li [] [ button [ onClick UsersList ] [ text "Users list" ] ]
            ]

isLoggedIn : Model -> String -> String
isLoggedIn model style =
    if String.isEmpty model.login.token == True then "none" else style