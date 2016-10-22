module Alert.Update exposing (..)

import Alert.Messages exposing (Msg(..))
import Alert.Models exposing (Model, AlertMessage, AlertOptions, AlertType(..), AlertStatus(..))
import String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Tick time ->
            { model | queue = (List.filter (\q -> time - q.id < model.options.timeOut) model.queue), time = time } ! []

        SetAlertPosition position ->
            { model | position = position } ! []

        SetTimeOut timeOutString ->
            let
                options : AlertOptions
                options =
                    model.options

                timeOut =
                    case String.toFloat timeOutString of
                        Ok val ->
                            val

                        Err msg ->
                            0
            in
                { model | options = { options | timeOut = timeOut } } ! []

        ToggleNewestOnTop ->
            let
                options : AlertOptions
                options =
                    model.options
            in
                { model | options = { options | newestOnTop = not model.options.newestOnTop } } ! []

        TogglePreventDuplicates ->
            let
                options : AlertOptions
                options =
                    model.options
            in
                { model | options = { options | preventDuplicates = not model.options.preventDuplicates } } ! []

        ToggleCloseButton ->
            let
                options : AlertOptions
                options =
                    model.options
            in
                { model | options = { options | closeButton = not model.options.closeButton } } ! []

        ToggleProgressBar ->
            let
                options : AlertOptions
                options =
                    model.options
            in
                { model | options = { options | progressBar = not model.options.progressBar } } ! []

        AddAlertMessage alertMessage ->
            let
                dublicate : List AlertMessage
                dublicate =
                    if model.options.preventDuplicates then
                        List.filter (\q -> q.title == alertMessage.title && q.text == alertMessage.text) model.queue
                    else
                        []

                queue : List AlertMessage
                queue =
                    if model.options.preventDuplicates then
                        if List.length dublicate > 0 then
                            model.queue
                        else
                            { alertMessage | id = model.time } :: model.queue
                    else
                        { alertMessage | id = model.time } :: model.queue
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
