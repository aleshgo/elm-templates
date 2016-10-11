module UI.LocaleSwitcher exposing (..)

import Html exposing (Html, div, text, select, option)
import Html.Attributes exposing (value, selected)
import Messages exposing (Msg(..))
import Models exposing (..)
import Events exposing (onSelect)


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
        [ value locale.id
        , selected (locale.id == model.locale)
        ]
        [ text locale.label ]
