module Alert.Models exposing (..)


type AlertType
    = Success
    | Info
    | Warning
    | Error


type alias AlertMessage =
    { id : Float
    , type' : AlertType
    , title : String
    , text : String
    }


type alias Model =
    { queue : List AlertMessage
    }


init : Model
init =
    Model [ AlertMessage 1 Success "Test Title" "Test Text" ]
