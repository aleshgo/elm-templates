module Alert.Update exposing (..)

import Alert.Messages exposing (Msg(..))
import Alert.Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []
