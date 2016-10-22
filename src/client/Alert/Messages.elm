module Alert.Messages exposing (..)

import Alert.Models exposing (AlertMessage, AlertPosition, AlertOptions)
import Time exposing (Time)


type Msg
    = NoOp
    | Tick Time
    | AddAlertMessage AlertMessage
    | SetAlertPosition AlertPosition
    | SetTimeOut String
    | ToggleNewestOnTop
    | TogglePreventDuplicates
    | ToggleProgressBar
    | ToggleCloseButton
    | MouseEnterAlertMessage Float
    | MouseLeaveAlertMessage Float
    | MouseClickAlertMessage Float
