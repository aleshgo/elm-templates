module Models exposing (..)

import Alert.Models exposing (AlertMessage, AlertType(..))


type alias Model =
    { alert : Alert.Models.Model
    , alertMessage : AlertMessage
    }


initialModel : Model
initialModel =
    { alert = Alert.Models.init
    , alertMessage = AlertMessage 0 Success "" ""
    }
