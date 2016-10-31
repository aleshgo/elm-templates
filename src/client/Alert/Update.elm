module Alert.Update exposing (..)

import Alert.Messages exposing (Msg(..))
import Alert.Models exposing (Model, AlertMessage, AlertStatus(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            let
                queue : List AlertMessage
                queue =
                    (List.filter (\m -> (model.time - m.id) < model.options.timeOut) model.queue)
            in
                { model | queue = queue, time = time } ! []

        AddAlertMessage type' title text ->
            let
                isDuplicate : AlertMessage -> Bool
                isDuplicate m =
                    m.title == title && m.text == text && m.type' == type'

                duplicates : List AlertMessage
                duplicates =
                    if model.options.preventDuplicates then
                        List.filter isDuplicate model.queue
                    else
                        []

                newAlertMessage : AlertMessage
                newAlertMessage =
                    AlertMessage model.time type' title text Idle

                queue : List AlertMessage
                queue =
                    if model.options.preventDuplicates && List.length duplicates > 0 then
                        List.map
                            (\m ->
                                if isDuplicate m then
                                    { m | id = model.time }
                                else
                                    m
                            )
                            model.queue
                    else
                        newAlertMessage :: model.queue
            in
                { model | queue = queue } ! []

        MouseEnterAlertMessage id ->
            let
                setHovered : AlertMessage -> AlertMessage
                setHovered message =
                    if message.id == id then
                        { message | status = Hovered }
                    else
                        message

                queue : List AlertMessage
                queue =
                    List.map setHovered model.queue
            in
                { model | queue = queue } ! []

        MouseLeaveAlertMessage id ->
            let
                unsetHovered : AlertMessage -> AlertMessage
                unsetHovered message =
                    if message.id == id then
                        { message | status = Idle }
                    else
                        message

                queue : List AlertMessage
                queue =
                    List.map unsetHovered model.queue
            in
                { model | queue = queue } ! []

        MouseClickAlertMessage id ->
            let
                queue : List AlertMessage
                queue =
                    List.filter (\m -> m.id /= id) model.queue
            in
                { model | queue = queue } ! []
