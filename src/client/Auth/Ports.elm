port module Auth.Ports exposing (..)

import Auth.Models exposing (Model)


port loadToken : (String -> msg) -> Sub msg


port saveToken : String -> Cmd msg


port removeToken : String -> Cmd msg
