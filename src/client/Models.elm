module Models exposing (..)

import I18n.Model exposing (Locale(..))


type alias Model =
    { locale : Locale
    , localesList : List Locale
    }


initLocale : List Locale
initLocale =
    [ En, Ru ]


initialModel : Model
initialModel =
    { locale = En
    , localesList = initLocale
    }
