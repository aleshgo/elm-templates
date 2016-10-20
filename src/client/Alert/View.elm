module Alert.View exposing (..)

import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Alert.Models exposing (Model, AlertMessage)
import Alert.Messages exposing (Msg(..))


viewAlert : Model -> Html Msg
viewAlert model =
    div []
        (List.map viewAlertMessage model.queue)


viewAlertMessage : AlertMessage -> Html Msg
viewAlertMessage message =
    div []
        [ text message.text
        ]
