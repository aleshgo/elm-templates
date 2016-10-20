module Alert.Messages exposing (..)

import Alert.Models exposing (AlertMessage, AlertPosition)
import Time exposing (Time)


type Msg
    = NoOp
    | Tick Time
    | AddAlertMessage AlertMessage
    | SetAlertPosition AlertPosition
