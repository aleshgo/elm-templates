module Messages exposing (..)

import Alert.Messages
import Alert.Models exposing (AlertType, AlertPosition)


type Msg
    = AlertMsg Alert.Messages.Msg
    | SetNewAlertMessageTitle String
    | SetNewAlertMessageText String
    | SetNewAlertMessageType AlertType
    | SetAlertPosition AlertPosition
    | SetTimeOut String
    | ToggleNewestOnTop
    | TogglePreventDuplicates
    | ToggleProgressBar
    | ToggleCloseButton
