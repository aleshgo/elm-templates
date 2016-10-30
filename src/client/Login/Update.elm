module Login.Update exposing (update)

import Login.Models exposing (..)
import Login.Messages exposing (..)
import Login.Commands exposing (signIn)
import Debug exposing (log)


update : Msg -> LoginModel -> ( LoginModel, Cmd Msg )
update msg model =
    case log "data: " msg of
        SignIn ->
            ( model , signIn model )

        UserName newName ->
            { model | username = newName } ! []

        UserPassword newPass ->
            { model | password = newPass } ! []

        FetchSucced newModel ->
            { model
                | token = newModel.token
                , user = newModel.user } ! []

        FetchFail error ->
            model ! []