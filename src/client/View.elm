module View exposing (..)

import Html exposing (Html, div, text)
import Html
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Alert.View exposing (viewAlert)
import Nav.Models exposing (Page(..))
import Pages.Auth exposing (authPage)
import Pages.Home exposing (homePage)


view : Model -> Html Msg
view model =
    div []
        [ Html.map AlertMsg <| viewAlert model.alert
        , viewPage model
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.page of
        Home ->
            homePage model

        SignUp ->
            authPage model

        Login ->
            authPage model
