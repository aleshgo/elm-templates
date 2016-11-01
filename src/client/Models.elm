module Models exposing (..)

import Auth.Models
import Alert.Models exposing (AlertMessage, AlertPosition(..), AlertType(..), AlertOptions)


type alias Model =
    { auth : Auth.Models.Model
    , alert : Alert.Models.Model
    }


initialModel : Model
initialModel =
    { auth = Auth.Models.init
    , alert = Alert.Models.init TopRight (AlertOptions 5000 True True True True)
    }
