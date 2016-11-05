module Update exposing (..)

import Models exposing (Model, toModelStorage)
import Messages exposing (Msg(..))
import Alert.Update
import Task
import Alert.Messages
import Alert.Models exposing (AlertType(..))
import Ports exposing (saveModel, removeModel)
import Token exposing (decodeTokenPayload)
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (toPath)
import Commands exposing (postUserCmd, loginUrl, signupUrl, tokenTestCmd, tokenTestUrl)
import Nav.Models exposing (Page(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AlertMsg alertMsg ->
            let
                ( updatedAlert, cmd ) =
                    Alert.Update.update alertMsg model.alert
            in
                ( { model | alert = updatedAlert }, Cmd.map AlertMsg cmd )

        SetUsername username ->
            ( { model | username = username }, Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        ToggleRemember ->
            ( { model | remember = not model.remember }, Cmd.none )

        AuthError error ->
            ( model, Task.perform identity identity (Task.succeed (AlertMsg <| Alert.Messages.AddAlertMessage Error "Error" <| toString error)) )

        HttpError error ->
            ( { model | tokenTest = Just False }, Cmd.none )

        TokenTestSuccess token ->
            ( { model | tokenTest = Just True }, Cmd.none )

        ClickTokenTest ->
            ( model, tokenTestCmd model tokenTestUrl )

        Tick time ->
            ( { model | time = time }, Cmd.none )

        ClickLogIn ->
            ( model, postUserCmd model loginUrl )

        ClickSignUp ->
            ( model, postUserCmd model signupUrl )

        ClickLogOut ->
            ( Models.initialModel, Cmd.batch [ removeModel "", Navigation.newUrl (toPath Login) ] )

        GoToPage page ->
            ( model, Navigation.newUrl (toPath page) )

        GetTokenSuccess token ->
            let
                newModel =
                    { model
                        | token = Just token
                        , username = ""
                        , password = ""
                        , page = Home
                        , tokenPayload = decodeTokenPayload token
                    }
            in
                ( newModel, Cmd.batch [ saveModel <| toModelStorage newModel, Navigation.newUrl (toPath Home) ] )
