module UI.LocaleSwitcher exposing (..)

import Html exposing (Html, div, text, select, option)
import Html.Attributes exposing (value, selected)
import Messages exposing (Msg(..))
import Models exposing (..)
import Events exposing (onSelect)
import I18n.Locale as Locale


localeSwitcher : Model -> Html Msg
localeSwitcher model =
    div []
        [ select [ onSelect (SaveBrowserLocale) ]
            (let
                option =
                    (localeSwitcherOption model)
             in
                List.map option model.localesList
            )
        ]


localeSwitcherOption model locale =
    option
        [ value <| Locale.toCode locale
        , selected (locale == model.locale)
        ]
        [ text <| Locale.toName locale ]
