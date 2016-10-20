module Messages exposing (..)

import Alert.Messages


type Msg
    = NoOp
    | AlertMsg Alert.Messages.Msg
