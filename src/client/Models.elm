module Models exposing (..)

import Alert.Models exposing (AlertMessage, AlertPosition(..), AlertType(..), AlertOptions)


type alias Model =
    { alert : Alert.Models.Model
    , newAlertMessageTitle : String
    , newAlertMessageText : String
    , newAlertMessageType : AlertType
    }


initialModel : Model
initialModel =
    { alert = Alert.Models.init TopRight (AlertOptions 5000 True True True True)
    , newAlertMessageTitle = ""
    , newAlertMessageText = ""
    , newAlertMessageType = Success
    }
