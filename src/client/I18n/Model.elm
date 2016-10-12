module I18n.Model exposing (..)


type Locale
    = En
    | Ru


type alias LocaleSet =
    { en : String
    , ru : String
    }
