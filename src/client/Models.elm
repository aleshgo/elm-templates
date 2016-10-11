module Models exposing (..)


type alias Locale =
    { id : String
    , label : String
    }


type alias Model =
    { locale : String
    , localesList : List Locale
    }


initLocale : List Locale
initLocale =
    [ Locale "en"
        "English"
    , Locale "ru"
        "Русский"
    ]


initialModel : Model
initialModel =
    { locale = ""
    , localesList = initLocale
    }
