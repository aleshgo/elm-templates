module Models exposing (..)

import Auth.Models


type alias Model =
    { auth : Auth.Models.Model
    }


initialModel : Model
initialModel =
    { auth = Auth.Models.init
    }
