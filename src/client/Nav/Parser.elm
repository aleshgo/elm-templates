module Nav.Parser exposing (..)

import Navigation
import Nav.Models exposing (Page(..))
import UrlParser exposing ((</>), s, top, int)


toPath : Page -> String
toPath page =
    case page of
        Home ->
            "/"

        Pages id ->
            "/pages/" ++ toString id


pageParser : UrlParser.Parser (Page -> a) a
pageParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map Pages (s "pages" </> int)
        ]
