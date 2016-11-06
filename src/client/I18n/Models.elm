module I18n.Models exposing (..)


type Locale
    = En
    | Ru


type alias LocaleSet =
    { en : String
    , ru : String
    }
