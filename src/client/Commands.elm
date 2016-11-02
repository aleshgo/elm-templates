module Commands exposing (..)

import Models exposing (Model)
import Task exposing (Task)
import Http
import Messages exposing (Msg(..))
import Json.Decode as Decode exposing (Decoder, (:=))
import Json.Encode as Encode


tokenTestUrl : String
tokenTestUrl =
    "api/sessions/test"


tokenTest : Model -> String -> Task Http.Error String
tokenTest model url =
    { verb = "GET"
    , headers =
        [ ( "token"
          , case model.auth.token of
                Just token ->
                    token

                Nothing ->
                    ""
          )
        ]
    , url = url
    , body = Http.empty
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson metaDecoder


tokenTestCmd : Model -> String -> Cmd Msg
tokenTestCmd model url =
    Task.perform HttpError TokenTestSuccess <| tokenTest model url


metaDecoder : Decoder String
metaDecoder =
    "token" := Decode.string
