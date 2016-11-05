module Commands exposing (..)

import Models exposing (Model)
import Task exposing (Task)
import Http
import Messages exposing (Msg(..))
import Json.Decode as Decode exposing (Decoder, (:=))
import Json.Encode as Encode


-- Urls


tokenTestUrl : String
tokenTestUrl =
    "api/sessions/test"


signupUrl : String
signupUrl =
    "api/users"


loginUrl : String
loginUrl =
    "api/sessions/create"



-- Encoders / Decoders


userEncoder : Model -> Encode.Value
userEncoder model =
    Encode.object
        [ ( "username", Encode.string model.username )
        , ( "password", Encode.string model.password )
        ]


tokenDecoder : Decoder String
tokenDecoder =
    "token" := Decode.string



-- POST signup / login request


postUser : Model -> String -> Task Http.Error String
postUser model url =
    { verb = "POST"
    , headers = [ ( "Content-Type", "application/json" ) ]
    , url = url
    , body = Http.string <| Encode.encode 0 <| userEncoder model
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson tokenDecoder


postUserCmd : Model -> String -> Cmd Msg
postUserCmd model url =
    Task.perform AuthError GetTokenSuccess <| postUser model url


tokenTest : Model -> String -> Task Http.Error String
tokenTest model url =
    { verb = "GET"
    , headers =
        [ ( "token"
          , case model.token of
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
