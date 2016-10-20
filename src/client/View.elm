module View exposing (..)

import Html exposing (Html, div, text, i)
import Html.App
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Models exposing (..)
import Alert.View exposing (viewAlert)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "flex items-center justify-center my-color bg-black my3" ]
            [ div [ class "mx1" ] [ text "Hello Friend!" ]
            , i [ class "fa fa-smile-o" ] []
            ]
        , Html.App.map AlertMsg <| viewAlert model.alert
        ]
