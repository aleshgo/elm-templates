module Alert.View exposing (..)

import Html exposing (Html, text, div, i)
import Html.Attributes exposing (class, style, property)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Json.Encode exposing (string)
import Alert.Models exposing (Model, AlertMessage, AlertPosition(..), AlertStatus(..), alertTypeToStyle, alertTypeToIcon, alertPositionToStyle)
import Alert.Messages exposing (Msg(..))


viewAlert : Model -> Html Msg
viewAlert model =
    div
        [ class <| "fixed bottom-0 overflow-hidden " ++ (alertPositionToStyle model.position)
        , style
            [ ( "max-height", "100%" )
            , ( "z-index", "999999999" )
            , ( "pointer-events", "none" )
            ]
        ]
        (List.map (viewAlertMessage model)
            (if model.options.newestOnTop then
                model.queue
             else
                List.reverse model.queue
            )
        )


viewAlertMessage : Model -> AlertMessage -> Html Msg
viewAlertMessage model message =
    div
        [ class <|
            "flex items-center alert "
                ++ (alertTypeToStyle message.type')
                ++ (if model.position == TopFull || model.position == BottomFull then
                        " alert-full"
                    else
                        ""
                   )
                ++ (if message.status == Hovered then
                        " alert-hovered"
                    else
                        ""
                   )
        , onMouseEnter (MouseEnterAlertMessage message.id)
        , onMouseLeave (MouseLeaveAlertMessage message.id)
        , onClick (MouseClickAlertMessage message.id)
        ]
        [ div [ class "m1 h2" ] [ i [ class <| "fa " ++ (alertTypeToIcon message.type') ] [] ]
        , div [ class "m1" ]
            [ div [ class "h4" ] [ text message.title ]
            , div [ class "h6", property "innerHTML" <| string message.text ] []
            , div [] [ text <| toString message.id ]
            ]
        ]
