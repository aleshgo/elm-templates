module View exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import UI.LocaleSwitcher exposing (localeSwitcher)


view : Model -> Html Msg
view model =
    div []
        [ text ("Browser language: " ++ model.locale)
        , localeSwitcher model
        ]
