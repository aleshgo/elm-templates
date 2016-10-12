module I18n.LocaleData exposing (..)

import I18n.Model exposing (Locale(..), LocaleSet)


type TranslationId
    = HelloWorld


translate : Locale -> TranslationId -> String
translate locale id =
    let
        localeSet =
            case id of
                HelloWorld ->
                    LocaleSet "Hello friend" "Привет друг"
    in
        case locale of
            En ->
                .en localeSet

            Ru ->
                .ru localeSet
