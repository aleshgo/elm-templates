module View exposing (..)

import Html exposing (Html, div, fieldset, form, label, text, h1, input, button, textarea)
import Html.App
import Html.Attributes exposing (class, type', name, checked)
import Html.Events exposing (onClick, onInput)
import Messages exposing (Msg(..))
import Models exposing (..)
import Alert.View exposing (viewAlert)
import Alert.Messages
import Alert.Models exposing (AlertType(..), AlertPosition(..))


view : Model -> Html Msg
view model =
    div []
        [ div [ class "mx3" ]
            [ h1 [ class "h1" ] [ text "Alert" ]
            , viewPanel model
            ]
        , Html.App.map AlertMsg <| viewAlert model.alert
        ]


viewPanel : Model -> Html Msg
viewPanel model =
    div [ class "bg-silver border border-gray rounded p2 flex flex-auto" ]
        [ div [ class "flex flex-column flex-auto p2 fit col-12" ]
            [ label [ class "label" ] [ text "Title" ]
            , input [ class "input", type' "text", onInput SetAlertMessageTitle ] []
            , label [ class "mt2 label" ] [ text "Text" ]
            , textarea [ class "textarea", onInput SetAlertMessageText ] []
            , button [ class "mt2 btn btn-primary", onClick <| AlertMsg <| Alert.Messages.AddAlertMessage model.alertMessage ] [ text "Show Alert" ]
            ]
        , div [ class "flex flex-column flex-auto p2 fit col-12" ]
            [ label [ class "label" ] [ text "Type" ]
            , fieldset [ class "fieldset" ]
                (let
                    alertTypeList =
                        [ Success, Info, Warning, Error ]
                 in
                    List.map (alertTypeRadio model) alertTypeList
                )
            , label [ class "label mt1" ] [ text "Position" ]
            , fieldset [ class "fieldset" ]
                (let
                    alertPositionList =
                        [ TopLeft, TopCenter, TopRight, TopFull, BottomLeft, BottomCenter, BottomRight, BottomFull ]
                 in
                    List.map (alertPositionRadio model) alertPositionList
                )
            ]
        , div [ class "flex flex-column flex-auto p2 fit col-12" ] []
        ]


alertPositionRadio : Model -> AlertPosition -> Html Msg
alertPositionRadio model position =
    radio "AlertPosition"
        (AlertMsg <| Alert.Messages.SetAlertPosition position)
        (toString position)
        (if model.alert.position == position then
            True
         else
            False
        )


alertTypeRadio : Model -> AlertType -> Html Msg
alertTypeRadio model type' =
    radio "AlertType"
        (SetAlertMessageType type')
        (toString type')
        (if model.alertMessage.type' == type' then
            True
         else
            False
        )


radio : String -> msg -> String -> Bool -> Html msg
radio name' msg label' checked' =
    label [ class "label" ]
        [ input [ type' "radio", onClick msg, name name', checked checked' ] []
        , text label'
        ]
