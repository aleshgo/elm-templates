module Messages exposing (..)

import Auth.Messages
import Alert.Messages
import Http
import Time exposing (Time)


type Msg
    = AlertMsg Alert.Messages.Msg
    | HttpError Http.Error
    | TokenTestSuccess String
    | ClickTokenTest
    | Tick Time
