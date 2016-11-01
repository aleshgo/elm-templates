module Messages exposing (..)

import Auth.Messages
import Alert.Messages


type Msg
    = AuthMsg Auth.Messages.Msg
    | AlertMsg Alert.Messages.Msg
