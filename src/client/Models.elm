module Models exposing (..)

import Alert.Models exposing (AlertMessage, AlertType(..), defaultAlertMessage)


type alias Model =
    { alert : Alert.Models.Model
    , alertMessage : AlertMessage
    }


initialModel : Model
initialModel =
    { alert = Alert.Models.init
    , alertMessage = defaultAlertMessage
    }
