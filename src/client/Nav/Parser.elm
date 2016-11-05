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

        SignUp ->
            "/signup"

        Login ->
            "/login"


urlParser : Navigation.Parser (Result String Page)
urlParser =
    Navigation.makeParser pathParser


pathParser : Navigation.Location -> Result String Page
pathParser location =
    location.pathname
        |> String.dropLeft 1
        |> UrlParser.parse identity pageParser


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ format Home (s "")
        , format SignUp (s "signup")
        , format Login (s "login")
        ]
