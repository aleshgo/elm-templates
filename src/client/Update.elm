module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Auth.Update
import Auth.Messages
import OutMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthMsg authMsg ->
            Auth.Update.update authMsg model.auth
                |> OutMessage.mapComponent (\newChild -> Model newChild)
                |> OutMessage.mapCmd AuthMsg
                |> OutMessage.evaluateMaybe interpretOutMsg Cmd.none


interpretOutMsg : Auth.Messages.OutMsg -> Model -> ( Model, Cmd Msg )
interpretOutMsg outmsg model =
    case outmsg of
        Auth.Messages.Alert msg ->
            let
                _ =
                    Debug.log "Auth module error: " msg
            in
                ( model, Cmd.none )
