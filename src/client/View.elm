module View exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import Nav.Models exposing (Page(..))


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text ("Current page: " ++ (toString model.page)) ]
        , div [] [ text ("pageId: " ++ (toString model.pageId)) ]
        , viewPage model
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.page of
        Home ->
            div []
                [ button [ onClick (GoToPage 1) ] [ text "Go to page 1" ]
                , button [ onClick (GoToPage 2) ] [ text "Go to page 2" ]
                ]

        Pages id ->
            div []
                [ button [ onClick GoHomePage ] [ text "Go Home" ]
                ]
