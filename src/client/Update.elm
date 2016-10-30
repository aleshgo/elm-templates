module Update exposing (..)

import String
import Models exposing (Model)
import Messages exposing (Msg(..))
import Navigation
import Nav.Models exposing (Page(..))
import Nav.Parser exposing (toPath)

import Login.Update
import Login.Models exposing (LoginModel, SignedUser)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoHomePage ->
            ( model, checkAuth model (toPath Home) )

        UsersList ->
            ( model, checkAuth model (toPath Users) )

        GoToPage id ->
            ( model, checkAuth model (toPath (Pages id)) )

        LoginPage ->
            model ! []

        LogOut ->
            ( { model
                | login = LoginModel "" ( SignedUser "" ) "" ""
            }, checkAuth model (toPath (Login)))

        LoginMsg subMsg ->
            let
                ( updatedLogin, cmd ) =
                    Login.Update.update subMsg model.login
            in
                ( { model | login = updatedLogin }, Cmd.map LoginMsg cmd )


checkAuth : Model -> String -> Cmd msg
checkAuth ({login} as model) routeString =
    if String.isEmpty login.token then
        Navigation.newUrl (toPath Login)
    else
        Navigation.newUrl routeString