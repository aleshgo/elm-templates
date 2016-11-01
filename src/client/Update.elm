module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Auth.Update
import Alert.Update
import Auth.Messages
import OutMessage
import Task
import Alert.Messages
import Alert.Models exposing (AlertType(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthMsg authMsg ->
            Auth.Update.update authMsg model.auth
                |> OutMessage.mapComponent (\newChild -> Model newChild model.alert)
                |> OutMessage.mapCmd AuthMsg
                |> OutMessage.evaluateMaybe interpretOutMsg Cmd.none

        AlertMsg alertMsg ->
            let
                ( updatedAlert, cmd ) =
                    Alert.Update.update alertMsg model.alert
            in
                ( { model | alert = updatedAlert }, Cmd.map AlertMsg cmd )


interpretOutMsg : Auth.Messages.OutMsg -> Model -> ( Model, Cmd Msg )
interpretOutMsg outmsg model =
    case outmsg of
        Auth.Messages.Alert msg ->
            ( model, Task.perform identity identity (Task.succeed (AlertMsg <| Alert.Messages.AddAlertMessage Error "Error" msg)) )
