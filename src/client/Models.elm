module Models exposing (..)

import Alert.Models


type alias Model =
    { alert : Alert.Models.Model
    }


initialModel : Model
initialModel =
    { alert = Alert.Models.init
    }
