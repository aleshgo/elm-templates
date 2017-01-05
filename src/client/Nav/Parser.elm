module Nav.Parser exposing (..)

import Navigation
import Nav.Models exposing (Page(..))
import UrlParser exposing ((</>), s, top)


toPath : Page -> String
toPath page =
    case page of
        Home ->
            "/"

        SignUp ->
            "/signup"

        Login ->
            "/login"


pageParser : UrlParser.Parser (Page -> a) a
pageParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map SignUp (s "signup")
        , UrlParser.map Login (s "login")
        ]
