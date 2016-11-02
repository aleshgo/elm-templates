port module Auth.Ports exposing (..)

import Auth.Models exposing (TokenStorage)


port loadToken : (String -> msg) -> Sub msg


port saveToken : TokenStorage -> Cmd msg


port removeToken : String -> Cmd msg
