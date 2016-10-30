module Login.Messages exposing (..)

import Http
import Login.Models exposing (LoginModel)

type Msg
    = SignIn
    | UserName String
    | UserPassword String
    | FetchSucced LoginModel
    | FetchFail Http.Error