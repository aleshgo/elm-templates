module Auth.Update exposing (..)

import Auth.Messages exposing (Msg(..))
import Auth.Models exposing (Model, Views(..), decodeTokenPayload)
import Auth.Commands exposing (postUserCmd, loginUrl)
import Auth.Ports exposing (saveToken, removeToken)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToView view ->
            let
                _ =
                    Debug.log "Switch view" model
            in
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
                Auth.Models.init ! [ removeToken model.token ]

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

                decodedToken =
                    decodeTokenPayload token
            in
                { model
                    | token = token
                    , password = ""
                    , iat = decodedToken.iat
                    , exp = decodedToken.exp
                }
                    ! [ saveToken token ]

        LoadToken token ->
            let
                _ =
                    Debug.log "LoadToken" token

                decodedToken =
                    decodeTokenPayload token
            in
                { model
                    | token = token
                    , username = decodedToken.username
                    , iat = decodedToken.iat
                    , exp = decodedToken.exp
                }
                    ! []
