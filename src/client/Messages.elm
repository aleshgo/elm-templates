module Messages exposing (..)

import Alert.Messages
import Http
import Time exposing (Time)
import Nav.Models exposing (Page)


type Msg
    = AlertMsg Alert.Messages.Msg
    | AuthError Http.Error
    | GetTokenSuccess String
    | HttpError Http.Error
    | TokenTestSuccess String
    | ClickTokenTest
    | Tick Time
    | ClickSignUp
    | ClickLogIn
    | ClickLogOut
    | GoToPage Page
    | SetUsername String
    | SetPassword String
    | ToggleRemember
    | SwitchLocale String
