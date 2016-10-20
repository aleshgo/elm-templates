module Messages exposing (..)

import Alert.Messages
import Alert.Models exposing (AlertType)


type Msg
    = NoOp
    | AlertMsg Alert.Messages.Msg
    | SetAlertMessageTitle String
    | SetAlertMessageText String
    | SetAlertMessageType AlertType
