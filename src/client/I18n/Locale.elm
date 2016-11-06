module I18n.Locale exposing (..)

import I18n.Models exposing (Locale(..))
import String


fromCode : String -> Locale
fromCode code =
    case code of
        "en-US" ->
            En

        "en-GB" ->
            En

        "en" ->
            En

        "ru" ->
            Ru

        _ ->
            En


toCode : Locale -> String
toCode locale =
    case locale of
        En ->
            "en"

        Ru ->
            "ru"


toName : Locale -> String
toName locale =
    case locale of
        En ->
            "English"

        Ru ->
            "Русский"
