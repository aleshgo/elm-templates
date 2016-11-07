module Pages.Home exposing (..)

import Models exposing (Model, tokenValid, tokenLeftTime)
import Html exposing (Html, div, text, button, input)
import Messages exposing (Msg(..))
import Date exposing (fromTime)
import Token exposing (initTokenPayload)
import Html.Events exposing (onClick)
import I18n.Locale as Locale
import I18n.LocaleData exposing (translate, TranslationId(..))


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
                            (translate model.locale Successful)

                        False ->
                            (translate model.locale Unsuccessful)
     in
        div []
            [ div [] [ text <| (translate model.locale Hello) ++ tokenPayload.username ]
            , div [] [ text <| (translate model.locale TokenIat) ++ toString (fromTime tokenPayload.iat) ]
            , div [] [ text <| (translate model.locale TokenExp) ++ toString (fromTime tokenPayload.exp) ]
            , div [] [ text <| (translate model.locale CurrentTime) ++ toString (fromTime model.time) ]
            , div [] [ text <| (translate model.locale TokenLeftTime) ++ toString (tokenLeftTime model) ]
            , div [] [ text <| (translate model.locale TokenValid) ++ toString (tokenValid model) ]
            , div [] [ text <| (translate model.locale LocaleText) ++ (Locale.toName model.locale) ]
            , div [] [ button [ onClick <| ClickLogOut ] [ text (translate model.locale LogOutButton) ] ]
            , div [] [ button [ onClick <| ClickTokenTest ] [ text (translate model.locale TokenTestButton) ] ]
            , (if tokenTest then
                div [] [ text ((translate model.locale TokenTestResult) ++ tokenTestResult) ]
               else
                div [] []
              )
            ]
    )
