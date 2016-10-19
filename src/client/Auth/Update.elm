module Auth.Update exposing (..)

import Auth.Messages exposing (Msg(..))
import Auth.Models exposing (Model, Views(..), decodeTokenPayload)
import Auth.Commands exposing (postUserCmd, loginUrl)
import Auth.Ports exposing (saveToken)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToView view ->
            { model | view = view, remember = False } ! []

        SetUsername username ->
            { model | username = username } ! []

        SetPassword password ->
            { model | password = password } ! []

        ToggleRemember ->
            { model | remember = not model.remember } ! []

        ClickLogIn ->
            let
                _ =
                    Debug.log "ClickLogIn" model
            in
                model ! [ postUserCmd model loginUrl ]

        ClickRegister ->
            let
                _ =
                    Debug.log "ClickRegister" model
            in
                model ! []

        ClickLogOut ->
            let
                _ =
                    Debug.log "ClickLogOut" model
            in
                model ! []

        HttpError _ ->
            let
                _ =
                    Debug.log "HttpError" model
            in
                model ! []

        AuthError error ->
            let
                _ =
                    Debug.log "AuthError" error
            in
                model ! []

        GetTokenSuccess token ->
            let
                _ =
                    Debug.log "GetTokenSuccess" token
            in
                { model | token = token, password = "" } ! [ saveToken token ]

        LoadToken token ->
            let
                _ =
                    Debug.log "LoadToken" token
            in
                { model | token = token, username = .username <| decodeTokenPayload token } ! []
