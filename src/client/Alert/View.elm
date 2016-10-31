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
            , ( "z-index", "999999" )
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
            "relative flex items-center alert "
                ++ (alertTypeToStyle message.type')
                ++ (if message.status == Hovered then
                        " alert-hovered"
                    else
                        ""
                   )
        , style
            [ ( "pointer-events", "auto" )
            , if model.position == TopFull || model.position == BottomFull then
                ( "width", "100%" )
              else
                ( "", "" )
            ]
        , onMouseEnter (MouseEnterAlertMessage message.id)
        , onMouseLeave (MouseLeaveAlertMessage message.id)
        , onClick (MouseClickAlertMessage message.id)
        ]
        [ div [ class "alert-icon" ] [ i [ class <| "fa " ++ (alertTypeToIcon message.type') ] [] ]
        , div [ class "m1" ]
            [ div [ class "alert-title" ] [ text message.title ]
            , div [ class "alert-text", property "innerHTML" <| string message.text ] []
            ]
        , (if model.options.progressBar then
            viewProgressBar model message
           else
            div [] []
          )
        , (if model.options.closeButton then
            viewCloseButton
           else
            div [] []
          )
        ]


viewProgressBar : Model -> AlertMessage -> Html Msg
viewProgressBar model message =
    let
        progressBarWidth =
            toString ((((message.id + model.options.timeOut) - model.time) / model.options.timeOut) * 100) ++ "%"
    in
        div [ class "absolute alert-progress-bar", style [ ( "width", progressBarWidth ) ] ] []


viewCloseButton : Html Msg
viewCloseButton =
    div [ class "absolute alert-close-button" ] [ i [ class "fa fa-times" ] [] ]
