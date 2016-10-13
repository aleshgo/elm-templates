module View exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import UI.LocaleSwitcher exposing (localeSwitcher)
import I18n.Locale as Locale
import I18n.Models exposing (Locale(..))
import I18n.LocaleData exposing (translate, TranslationId(..))


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text <| translate model.locale HelloWorld ]
        , text ("Browser language: " ++ Locale.toName model.locale)
        , localeSwitcher model
        ]
