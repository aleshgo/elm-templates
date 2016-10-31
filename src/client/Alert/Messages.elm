module Alert.Messages exposing (..)

import Alert.Models exposing (AlertMessage, AlertType, AlertPosition, AlertOptions)
import Time exposing (Time)


type Msg
    = Tick Time
    | AddAlertMessage AlertType String String
    | MouseEnterAlertMessage Float
    | MouseLeaveAlertMessage Float
    | MouseClickAlertMessage Float
