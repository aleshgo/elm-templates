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
import Commands exposing (tokenTestCmd, tokenTestUrl)
import Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AlertMsg alertMsg ->
            let
                ( updatedAlert, cmd ) =
                    Alert.Update.update alertMsg model.alert
            in
                ( { model | alert = updatedAlert }, Cmd.map AlertMsg cmd )

        HttpError error ->
            ( { model | tokenTest = Just False }, Cmd.none )

        TokenTestSuccess token ->
            ( { model | tokenTest = Just True }, Cmd.none )

        ClickTokenTest ->
            ( model, tokenTestCmd model tokenTestUrl )

        Tick time ->
            ( { model | time = time }, Cmd.none )
