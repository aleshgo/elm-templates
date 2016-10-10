module Nav.Parser exposing (..)

import Navigation
import Nav.Models exposing (Page(..))
import String
import UrlParser exposing (Parser, (</>), format, int, oneOf, s, string)


toPath : Page -> String
toPath page =
    case page of
        Home ->
            "/"

        Pages id ->
            "/pages/" ++ toString id


urlParser : Navigation.Parser (Result String Page)
urlParser =
    Navigation.makeParser pathParser


pathParser : Navigation.Location -> Result String Page
pathParser location =
    UrlParser.parse identity pageParser (String.dropLeft 1 location.pathname)


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ format Home (s "")
        , format Pages (s "pages" </> int)
        ]
