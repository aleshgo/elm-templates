module View exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import UI.LocaleSwitcher exposing (localeSwitcher)
import I18n.Locale as Locale


hello_world =
    "Hello World"


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text hello_world ]
        , text ("Browser language: " ++ Locale.toName model.locale)
        , localeSwitcher model
        ]
