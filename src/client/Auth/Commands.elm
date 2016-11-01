module Auth.Commands exposing (..)

import Json.Decode as Decode exposing (Decoder, (:=))
import Json.Encode as Encode
import Auth.Models exposing (Model)
import Http
import Task exposing (Task)
import Auth.Messages exposing (Msg(..))


-- import Http.Decorators
-- Urls


registerUrl : String
registerUrl =
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



-- POST register / login request


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
    Task.perform HttpError GetTokenSuccess <| postUser model url
