module Messages exposing (..)

import Alert.Messages
import Alert.Models exposing (AlertType, AlertPosition)


type Msg
    = NoOp
    | AlertMsg Alert.Messages.Msg
    | SetAlertMessageTitle String
    | SetAlertMessageText String
    | SetAlertMessageType AlertType
    | SetAlertPosition AlertPosition
    | SetTimeOut String
    | ToggleNewestOnTop
    | TogglePreventDuplicates
    | ToggleProgressBar
    | ToggleCloseButton
