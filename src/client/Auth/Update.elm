module Auth.Update exposing (..)

import Auth.Messages exposing (Msg(..), OutMsg(..))
import Auth.Models exposing (Model, Views(..), decodeTokenPayload)
import Auth.Commands exposing (postUserCmd, loginUrl, registerUrl)
import Auth.Ports exposing (saveToken, removeToken)


update : Msg -> Model -> ( Model, Cmd Msg, Maybe OutMsg )
update msg model =
    case msg of
        ToView view ->
            let
                _ =
                    Debug.log "Switch view" model
            in
                ( { model | view = view, remember = False }, Cmd.none, Nothing )

        SetUsername username ->
            ( { model | username = username }, Cmd.none, Nothing )

        SetPassword password ->
            ( { model | password = password }, Cmd.none, Nothing )

        ToggleRemember ->
            ( { model | remember = not model.remember }, Cmd.none, Nothing )

        ClickLogIn ->
            let
                _ =
                    Debug.log "ClickLogIn" model
            in
                ( model, postUserCmd model loginUrl, Nothing )

        ClickRegister ->
            let
                _ =
                    Debug.log "ClickRegister" model
            in
                ( model, postUserCmd model registerUrl, Nothing )

        ClickLogOut ->
            let
                _ =
                    Debug.log "ClickLogOut" model
            in
                ( Auth.Models.init, removeToken model.token, Nothing )

        HttpError _ ->
            let
                _ =
                    Debug.log "HttpError" model
            in
                ( model, Cmd.none, Nothing )

        AuthError error ->
            let
                _ =
                    Debug.log "AuthError" error
            in
                ( model, Cmd.none, Just <| Alert <| toString error )

        GetTokenSuccess token ->
            let
                _ =
                    Debug.log "GetTokenSuccess" token

                decodedToken =
                    decodeTokenPayload token
            in
                ( { model
                    | token = token
                    , password = ""
                    , iat = decodedToken.iat
                    , exp = decodedToken.exp
                  }
                , saveToken token
                , Nothing
                )

        LoadToken token ->
            let
                _ =
                    Debug.log "LoadToken" token

                decodedToken =
                    decodeTokenPayload token
            in
                ( { model
                    | token = token
                    , username = decodedToken.username
                    , iat = decodedToken.iat
                    , exp = decodedToken.exp
                  }
                , Cmd.none
                , Nothing
                )
