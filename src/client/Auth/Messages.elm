module Auth.Messages exposing (..)

import Auth.Models exposing (Views)
import Http


type Msg
    = ToView Views
    | ClickRegister
    | ClickLogIn
    | ClickLogOut
    | SetUsername String
    | SetPassword String
    | ToggleRemember
    | HttpError Http.Error
    | AuthError Http.Error
    | GetTokenSuccess String
    | LoadToken String
