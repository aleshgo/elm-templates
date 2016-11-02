module Models exposing (..)

import Auth.Models
import Alert.Models exposing (AlertMessage, AlertPosition(..), AlertType(..), AlertOptions)
import Time exposing (Time)


type alias Model =
    { auth : Auth.Models.Model
    , alert : Alert.Models.Model
    , tokenTest : Maybe Bool
    , time : Time
    }


initialModel : Model
initialModel =
    { auth = Auth.Models.init
    , alert = Alert.Models.init TopRight (AlertOptions 5000 True True True True)
    , tokenTest = Nothing
    , time = 0
    }
