module View exposing (..)

import Html exposing (Html, div, text, button, h3, input)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, type')
import Messages exposing (Msg(..))
import Auth.Messages
import Models exposing (Model)
import Auth.View exposing (authBox)
import Auth.Models exposing (initTokenPayload)
import String
import Date exposing (fromTime)
import Alert.View exposing (viewAlert)


view : Model -> Html Msg
view model =
    div []
        [ Html.App.map AlertMsg <| viewAlert model.alert
        , (let
            loggedIn =
                case model.auth.tokenPayload of
                    Nothing ->
                        False

                    Just token ->
                        True

            tokenPayload =
                case model.auth.tokenPayload of
                    Nothing ->
                        initTokenPayload

                    Just tokenPayload ->
                        tokenPayload
           in
            if loggedIn then
                div []
                    [ div [] [ text <| "Hello: " ++ tokenPayload.username ]
                    , div [] [ text <| "Token iat: " ++ toString (fromTime tokenPayload.iat) ]
                    , div [] [ text <| "Token exp: " ++ toString (fromTime tokenPayload.exp) ]
                    , div [] [ button [ onClick <| AuthMsg Auth.Messages.ClickLogOut ] [ text "LogOut" ] ]
                    ]
            else
                Html.App.map AuthMsg (authBox model.auth)
          )
        ]
