module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Alert.Update


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
