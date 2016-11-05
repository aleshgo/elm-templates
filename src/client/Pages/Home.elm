module Pages.Home exposing (..)

import Models exposing (Model, tokenValid, tokenLeftTime)
import Html exposing (Html, div, text, button, input)
import Messages exposing (Msg(..))
import Date exposing (fromTime)
import Token exposing (initTokenPayload)
import Html.Events exposing (onClick)


homePage : Model -> Html Msg
homePage model =
    (let
        tokenPayload =
            case model.tokenPayload of
                Nothing ->
                    initTokenPayload

                Just tokenPayload ->
                    tokenPayload

        tokenTest =
            case model.tokenTest of
                Nothing ->
                    False

                Just token ->
                    True

        tokenTestResult =
            case model.tokenTest of
                Nothing ->
                    ""

                Just token ->
                    case token of
                        True ->
                            "Successful"

                        False ->
                            "Unsuccessful"
     in
        div []
            [ div [] [ text <| "Hello: " ++ tokenPayload.username ]
            , div [] [ text <| "Token iat: " ++ toString (fromTime tokenPayload.iat) ]
            , div [] [ text <| "Token exp: " ++ toString (fromTime tokenPayload.exp) ]
            , div [] [ text <| "Current time: " ++ toString (fromTime model.time) ]
            , div []
                [ text <|
                    "Token left time, sec: "
                        ++ toString (tokenLeftTime model)
                ]
            , div [] [ text <| "Token valid: " ++ toString (tokenValid model) ]
            , div [] [ button [ onClick <| ClickLogOut ] [ text "LogOut" ] ]
            , div [] [ button [ onClick <| ClickTokenTest ] [ text "TokenTest" ] ]
            , (if tokenTest then
                div [] [ text ("Token test result: " ++ tokenTestResult) ]
               else
                div [] []
              )
            ]
    )
