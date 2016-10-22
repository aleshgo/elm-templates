module Alert.Update exposing (..)

import Alert.Messages exposing (Msg(..))
import Alert.Models exposing (Model, AlertMessage, AlertType(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Tick time ->
            { model | queue = (List.filter (\q -> time - q.id < model.timeOut) model.queue), time = time } ! []

        SetAlertPosition position ->
            { model | position = position } ! []

        AddAlertMessage alertMessage ->
            let
                _ =
                    Debug.log "time" model.time

                queue =
                    { alertMessage | id = model.time } :: model.queue
            in
                { model | queue = queue } ! []
