module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Auth.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthMsg authMsg ->
            let
                ( updatedAuth, cmd ) =
                    Auth.Update.update authMsg model.auth
            in
                ( { model | auth = updatedAuth }, Cmd.map AuthMsg cmd )
