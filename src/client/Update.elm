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
import Commands exposing (postUserRequest, tokenTestRequest, loginUrl, signupUrl)
import Nav.Models exposing (Page(..))
import I18n.Locale as Locale
import Nav.Update exposing (pageUpdate)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AlertMsg alertMsg ->
            let
                ( updatedAlert, cmd ) =
                    Alert.Update.update alertMsg model.alert
            in
                ( { model | alert = updatedAlert }, Cmd.map AlertMsg cmd )
        -- Form
        SetUsername username ->
            ( { model | username = username }, Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        ToggleRemember ->
            ( { model | remember = not model.remember }, Cmd.none )

        ClickLogIn ->
            ( model, postUserRequest model loginUrl )

        ClickSignUp ->
            ( model, postUserRequest model signupUrl )

        ClickLogOut ->
            let
                newModel =
                    Models.initialModel
            in
                ( { newModel | locale = model.locale }, Cmd.batch [ removeModel "", Navigation.newUrl (toPath Login) ] )

        ClickTokenTest ->
            ( model, tokenTestRequest model )

        -- Effects
        Tick time ->
            ( { model | time = time }, Cmd.none )

        -- Nav
        GoToPage page ->
            ( model, Navigation.newUrl (toPath page) )

        UrlChange location ->
             pageUpdate location model

        -- I18n
        SwitchLocale code ->
            let
                newModel =
                    { model | locale = Locale.fromCode code }
            in
                ( newModel, saveModel <| toModelStorage newModel )

        -- Requests
        UserRequest result ->
            case result of
                Err error ->
                    ( model, Task.perform identity (Task.succeed (AlertMsg <| Alert.Messages.AddAlertMessage Error "" "Error")) )

                Ok token ->
                    let
                        newModel =
                            { model
                                | token = Just token
                                , username = ""
                                , password = ""
                                , page = Home
                                , tokenPayload = decodeTokenPayload token
                            }

                        _ = Debug.log "newModel" newModel
                    in
                        ( newModel, Cmd.batch [ saveModel <| toModelStorage newModel, Navigation.newUrl (toPath Home) ] )

        TokenTestRequest result ->
            case result of
                Err error ->
                    ( { model | tokenTest = Nothing }, Task.perform identity (Task.succeed (AlertMsg <| Alert.Messages.AddAlertMessage Error "" "Not Valid token")) )

                Ok token ->
                    ( { model | tokenTest = Just True }, Cmd.none )