module Auth.Update exposing (..)

import Auth.Messages exposing (Msg(..), OutMsg(..))
import Auth.Models exposing (Model, Views(..), TokenStorage, decodeTokenPayload)
import Auth.Commands exposing (postUserCmd, loginUrl, registerUrl)
import Auth.Ports exposing (saveToken, removeToken)


update : Msg -> Model -> ( Model, Cmd Msg, Maybe OutMsg )
update msg model =
    case msg of
        ToView view ->
            ( { model | view = view, remember = False }, Cmd.none, Nothing )

        SetUsername username ->
            ( { model | username = username }, Cmd.none, Nothing )

        SetPassword password ->
            ( { model | password = password }, Cmd.none, Nothing )

        ToggleRemember ->
            ( { model | remember = not model.remember }, Cmd.none, Nothing )

        ClickLogIn ->
            ( model, postUserCmd model loginUrl, Nothing )

        ClickRegister ->
            ( model, postUserCmd model registerUrl, Nothing )

        ClickLogOut ->
            ( Auth.Models.init, removeToken "", Nothing )

        HttpError error ->
            ( model, Cmd.none, Just <| Alert <| toString error )

        GetTokenSuccess token ->
            ( { model
                | token = Just token
                , password = ""
                , tokenPayload = decodeTokenPayload token
              }
            , saveToken <| TokenStorage token model.remember
            , Nothing
            )

        LoadToken token ->
            ( { model
                | token =
                    if token == "" then
                        Nothing
                    else
                        Just token
                , tokenPayload = decodeTokenPayload token
              }
            , Cmd.none
            , Nothing
            )
