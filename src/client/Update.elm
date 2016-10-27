module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Alert.Models exposing (AlertOptions)
import Alert.Update
import String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetAlertMessageTitle title ->
            let
                alertMessage =
                    model.alertMessage
            in
                ( { model | alertMessage = { alertMessage | title = title } }, Cmd.none )

        SetAlertMessageText text ->
            let
                alertMessage =
                    model.alertMessage
            in
                ( { model | alertMessage = { alertMessage | text = text } }, Cmd.none )

        SetAlertMessageType type' ->
            let
                alertMessage =
                    model.alertMessage
            in
                ( { model | alertMessage = { alertMessage | type' = type' } }, Cmd.none )

        AlertMsg alertMsg ->
            let
                ( updatedAlert, cmd ) =
                    Alert.Update.update alertMsg model.alert
            in
                ( { model | alert = updatedAlert }, Cmd.map AlertMsg cmd )

        SetAlertPosition position ->
            let
                alert =
                    model.alert

                newAlert =
                    { alert | position = position }
            in
                { model | alert = newAlert } ! []

        SetTimeOut timeOutString ->
            let
                timeOut =
                    case String.toFloat timeOutString of
                        Ok val ->
                            val

                        Err msg ->
                            0

                alert =
                    model.alert

                options =
                    alert.options

                newAlert =
                    { alert | options = { options | timeOut = timeOut } }
            in
                { model | alert = newAlert } ! []

        ToggleNewestOnTop ->
            let
                alert =
                    model.alert

                options =
                    alert.options

                newAlert =
                    { alert | options = { options | newestOnTop = not alert.options.newestOnTop } }
            in
                { model | alert = newAlert } ! []

        TogglePreventDuplicates ->
            let
                alert =
                    model.alert

                options =
                    alert.options

                newAlert =
                    { alert | options = { options | preventDuplicates = not alert.options.preventDuplicates } }
            in
                { model | alert = newAlert } ! []

        ToggleCloseButton ->
            let
                alert =
                    model.alert

                options =
                    alert.options

                newAlert =
                    { alert | options = { options | closeButton = not alert.options.closeButton } }
            in
                { model | alert = newAlert } ! []

        ToggleProgressBar ->
            let
                alert =
                    model.alert

                options =
                    alert.options

                newAlert =
                    { alert | options = { options | progressBar = not alert.options.progressBar } }
            in
                { model | alert = newAlert } ! []
